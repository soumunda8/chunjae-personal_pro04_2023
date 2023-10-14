package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.domain.BoardVO;
import kr.ed.haebeop.domain.FileDTO;
import kr.ed.haebeop.service.BoardMgnService;
import kr.ed.haebeop.service.BoardService;
import kr.ed.haebeop.service.FilesService;
import kr.ed.haebeop.util.BoardPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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

    @GetMapping("/")
    public String main() throws Exception {
        return "redirect:/board/list.do?no=1";
    }

    @GetMapping("/list.do")
    public String boardList(HttpServletRequest request, Model model) throws Exception {
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";

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

        List<BoardMgn> boardMgnListForHeader = boardMgnService.listBoardMgnForHeader();
        model.addAttribute("boardMgnListForHeader", boardMgnListForHeader);

        // 권한 관련 - 등록
        boolean addCheck = false;
        if(sid != "" && (boardMgn.getAboutAuth() == 2 || sid.equals("admin"))) {
            addCheck = true;
        }

        model.addAttribute("addCheck", addCheck);

        return "/board/boardList";
    }

    @GetMapping("/add.do")
    public String boardAdd(HttpServletRequest request, Model model) throws Exception {
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bmNo = Integer.parseInt(request.getParameter("no"));

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        List<BoardMgn> boardMgnListForHeader = boardMgnService.listBoardMgnForHeader();
        model.addAttribute("boardMgnListForHeader", boardMgnListForHeader);

        return "/board/boardAdd";
    }

    @PostMapping("/add.do")
    public String boardAddPro(HttpServletRequest request, Board board, Model model, List<MultipartFile> uploadFiles) throws Exception {
        String author = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bmNo = Integer.parseInt(request.getParameter("no"));

        board.setAuthor(author);
        board.setBmNo(bmNo);
        int bno = boardService.boardInsert(board);

        if(uploadFiles != null) {
            ServletContext application = request.getSession().getServletContext();
            //String realPath = application.getRealPath("/resources/upload");                                                             // 운영 서버
            String realPath = "C:\\Dev\\IdeaProjects\\project\\personal\\project4\\project04\\src\\main\\webapp\\resources\\upload";	  // 개발 서버

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
                fileDTO.setFileType(multipartFile.getContentType());
                fileDTO.setOriginNm(originalFilename);
                fileDTO.setSaveNm(uploadFilename);

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

        BoardVO board = boardService.boardGet(bno);
        model.addAttribute("board", board);

        // 권한 관련 - 수정
        boolean addCheck = false;
        if(sid != "" && board.getAuthor().equals(sid)) {
            addCheck = true;
        }
        model.addAttribute("addCheck", addCheck);

        List<FileDTO> fileList = filesService.fileListByPar(board.getBno());
        model.addAttribute("fileList", fileList);

        List<BoardMgn> boardMgnListForHeader = boardMgnService.listBoardMgnForHeader();
        model.addAttribute("boardMgnListForHeader", boardMgnListForHeader);

        return "/board/boardGet";
    }

    @GetMapping("/update.do")
    public String boardUpdate(HttpServletRequest request, Model model) throws Exception {

        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bno = Integer.parseInt(request.getParameter("bno"));

        BoardVO board = boardService.boardGet(bno);
        model.addAttribute("board", board);

        // 권한 관련 - 등록
        boolean addCheck = false;
        if(sid != "" && board.getAuthor().equals(sid)) {
            addCheck = true;
        }
        model.addAttribute("addCheck", addCheck);

        List<FileDTO> fileList = filesService.fileListByPar(board.getBno());
        model.addAttribute("fileList", fileList);

        List<BoardMgn> boardMgnListForHeader = boardMgnService.listBoardMgnForHeader();
        model.addAttribute("boardMgnListForHeader", boardMgnListForHeader);

        return "/board/boardUpdate";
    }

}