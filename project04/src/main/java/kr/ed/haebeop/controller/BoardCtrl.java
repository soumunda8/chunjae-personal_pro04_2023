package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.*;
import kr.ed.haebeop.util.BoardPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/board")
public class BoardCtrl {

    @Autowired
    HttpSession session;

    @Autowired
    private BoardService boardService;

    @Autowired
    private BoardMgnService boardMgnService;

    @Autowired
    private FilesService filesService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private MemberService memberService;

    private final String toUseFileByBoard = "board";

    @GetMapping("/")
    public String main() throws Exception {
        return "redirect:/board/list.do?no=1";
    }

    @GetMapping("/list.do")
    public String boardList(HttpServletRequest request, Model model) throws Exception {
        String sid = (String) session.getAttribute("sid");

        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int bmNo = request.getParameter("no") != null ? Integer.parseInt(request.getParameter("no")) : 1;

        BoardPage page = new BoardPage();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        page.setBmNo(bmNo);
        int total = boardService.boardCount(page);

        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);
        List<BoardVO> boardList = boardService.boardList(page);
        model.addAttribute("boardList", boardList);

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        /*List<BoardMgn> boardMgnListForHeader = boardMgnService.listBoardMgnForHeader();
        model.addAttribute("boardMgnListForHeader", boardMgnListForHeader);*/

        // 권한 관련 - 등록
        boolean addCheck = false;
        if(sid != null && (boardMgn.getAboutAuth() == memberService.memberGet(sid).getGrade() || sid.equals("admin"))) {
            addCheck = true;
        }

        model.addAttribute("addCheck", addCheck);

        return "/board/boardList";
    }

    @GetMapping("/add.do")
    public String boardAdd(HttpServletRequest request, Model model) throws Exception {
        String sid = (String) session.getAttribute("sid");
        int bmNo = Integer.parseInt(request.getParameter("no"));

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        return "/board/boardAdd";
    }

    @PostMapping("/add.do")
    public String boardAddPro(HttpServletRequest request, Board board, Model model, List<MultipartFile> uploadFiles) throws Exception {
        String author = (String) session.getAttribute("sid");
        int bmNo = Integer.parseInt(request.getParameter("no"));

        board.setAuthor(author);
        board.setBmNo(bmNo);
        int bno = boardService.boardInsert(board);

        if(uploadFiles != null) {
            ServletContext application = request.getSession().getServletContext();
            //String realPath = application.getRealPath("/resources/upload");                                                             // 운영 서버
            String realPath = "D:\\park\\project\\personal\\personal_pro04_2023\\project04\\src\\main\\webapp\\resources\\upload";	      // 개발 서버

            SimpleDateFormat sdf = new SimpleDateFormat("yyy/MM/dd");
            Date date = new Date();
            String dateFolder = sdf.format(date);

            File uploadPath = new File(realPath, dateFolder);
            if(!uploadPath.exists()) {uploadPath.mkdirs();}

            for(MultipartFile multipartFile : uploadFiles) {
                if(multipartFile.isEmpty()) {continue;}

                String originalFilename = multipartFile.getOriginalFilename();
                UUID uuid = UUID.randomUUID();
                String uploadFilename = uuid.toString() + "_" + originalFilename;
                
                FileDTO fileDTO = new FileDTO();
                fileDTO.setPar(bno);
                fileDTO.setSaveFolder(String.valueOf(uploadPath));

                String fileType = multipartFile.getContentType();
                String[] fileTypeArr = fileType.split("/");
                fileDTO.setFileType(fileTypeArr[0]);

                fileDTO.setOriginNm(originalFilename);
                fileDTO.setSaveNm(uploadFilename);
                fileDTO.setToUse("board");

                multipartFile.transferTo(new File(uploadPath, uploadFilename));     // 서버에 파일 업로드 수행
                filesService.filesInsert(fileDTO);                                  // DB 등록
            }

        }

        return "redirect:/board/list.do?no=" + bmNo;
    }

    @GetMapping("/get.do")
    public String boardDetail(HttpServletRequest request, Model model) throws Exception {
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bno = Integer.parseInt(request.getParameter("bno"));

        BoardVO board = boardService.boardGet(bno, sid);
        model.addAttribute("board", board);

        // 권한 관련 - 수정
        boolean addCheck = false;
        if(sid != null && board.getAuthor().equals(sid)) {
            addCheck = true;
        }
        model.addAttribute("addCheck", addCheck);

        FileDTO fileDTO = new FileDTO();
        fileDTO.setPar(board.getBno());
        fileDTO.setToUse(toUseFileByBoard);
        List<FileDTO> fileList = filesService.fileListByPar(fileDTO);
        model.addAttribute("fileList", fileList);

        List<CommentVO> commentList = commentService.commentList(bno);
        for(CommentVO commentVO :commentList) {
            String originNm = commentVO.getNm();
            if(!originNm.equals("관리자")) {
                String nm = originNm.substring(0, 1);
                for(int i = 0; i < originNm.length()-2; i++){
                    nm += "*";
                }
                nm += originNm.substring(originNm.length() - 1);
                commentVO.setNm(nm);
            }
        }
        model.addAttribute("commentList", commentList);

        /*List<BoardMgn> boardMgnListForHeader = boardMgnService.listBoardMgnForHeader();
        model.addAttribute("boardMgnListForHeader", boardMgnListForHeader);
*/
        return "/board/boardGet";
    }

    @GetMapping("/update.do")
    public String boardUpdate(HttpServletRequest request, Model model) throws Exception {
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bno = Integer.parseInt(request.getParameter("bno"));

        BoardVO board = boardService.boardGet(bno, sid);
        model.addAttribute("board", board);

        // 권한 관련 - 수정
        boolean addCheck = false;
        if(sid != null && board.getAuthor().equals(sid)) {
            addCheck = true;
        }
        model.addAttribute("addCheck", addCheck);

        FileDTO fileDTO = new FileDTO();
        fileDTO.setPar(board.getBno());
        fileDTO.setToUse(toUseFileByBoard);

        List<FileDTO> fileList = filesService.fileListByPar(fileDTO);
        model.addAttribute("fileList", fileList);

        /*List<BoardMgn> boardMgnListForHeader = boardMgnService.listBoardMgnForHeader();
        model.addAttribute("boardMgnListForHeader", boardMgnListForHeader);*/

        return "/board/boardUpdate";
    }

    @PostMapping("/update.do")
    public String boardUpdatePro(HttpServletRequest request, List<MultipartFile> uploadFiles) throws Exception {
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bno = Integer.parseInt(request.getParameter("bno"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        Board board = new Board();
        board.setBno(bno);
        board.setTitle(title);
        board.setContent(content);
        boardService.boardUpdate(board);

        if(uploadFiles != null) {
            ServletContext application = request.getSession().getServletContext();
            //String realPath = application.getRealPath("/resources/upload");                                                             // 운영 서버
            String realPath = "D:\\park\\project\\personal\\personal_pro04_2023\\project04\\src\\main\\webapp\\resources\\upload";	      // 개발 서버

            SimpleDateFormat sdf = new SimpleDateFormat("yyy/MM/dd");
            Date date = new Date();
            String dateFolder = sdf.format(date);

            File uploadPath = new File(realPath, dateFolder);
            if(!uploadPath.exists()) {uploadPath.mkdirs();}

            for(MultipartFile multipartFile : uploadFiles) {
                if(multipartFile.isEmpty()) {continue;}

                String originalFilename = multipartFile.getOriginalFilename();
                UUID uuid = UUID.randomUUID();
                String uploadFilename = uuid.toString() + "_" + originalFilename;

                FileDTO fileDTO = new FileDTO();
                fileDTO.setPar(bno);
                fileDTO.setSaveFolder(String.valueOf(uploadPath));

                String fileType = multipartFile.getContentType();
                String[] fileTypeArr = fileType.split("/");
                fileDTO.setFileType(fileTypeArr[0]);

                fileDTO.setOriginNm(originalFilename);
                fileDTO.setSaveNm(uploadFilename);
                fileDTO.setToUse("board");

                multipartFile.transferTo(new File(uploadPath, uploadFilename));     // 서버에 파일 업로드 수행
                filesService.filesInsert(fileDTO);                                  // DB 등록
            }

        }
        return "redirect:/board/get.do?bno=" + bno;
    }

    @GetMapping("/delete.do")
    public String boardDeletePro(HttpServletRequest request) throws Exception {
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bno = Integer.parseInt(request.getParameter("bno"));

        BoardVO boardVO = boardService.boardGet(bno, sid);
        int bmNo = boardVO.getBmNo();

        FileDTO fileDTO = new FileDTO();
        fileDTO.setPar(bno);
        fileDTO.setToUse(toUseFileByBoard);
        List<FileDTO> fileList = filesService.fileListByPar(fileDTO);
        for(FileDTO files : fileList) {
            File file = new File(files.getSaveFolder() + File.separator + files.getSaveNm());
            if (file.exists()) {
                file.delete();
                filesService.filesDeleteAll(bno);
            }
        }

        commentService.commentDeleteAll(bno);
        boardService.boardDelete(bno);
        return "redirect:/board/list.do?no=" + bmNo;
    }

    @PostMapping("commentAdd.do")
    @ResponseBody
    public CommentVO commentInsert(@RequestBody Comment comment) throws Exception {
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        comment.setAuthor(sid);
        CommentVO commentVO = commentService.commentInsert(comment);
        String originNm = commentVO.getNm();
        if(!originNm.equals("관리자")) {
            String nm = originNm.substring(0, 1);
            for(int i = 0; i < originNm.length()-2; i++){
                nm += "*";
            }
            nm += originNm.substring(originNm.length() - 1);
            commentVO.setNm(nm);
        }
        return commentVO;
    }

    @PostMapping("commentRemove.do")
    @ResponseBody
    public boolean commentDelete(@RequestBody Comment comment) throws Exception {
        boolean result = false;
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        CommentVO commentVO = commentService.comment(comment.getCno());
        if(commentVO.getAuthor().equals(sid) || sid.equals("admin")) {
            commentService.commentDelete(commentVO.getCno());
        }
        return result;
    }

}