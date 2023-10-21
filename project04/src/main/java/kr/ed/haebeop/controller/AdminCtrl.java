package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.*;
import kr.ed.haebeop.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminCtrl {

    @Autowired
    HttpSession session;

    @Autowired
    private MemberService memberService;

    @Autowired
    private BoardMgnService boardMgnService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private FilesService filesService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private LectureService lectureService;

    @GetMapping("/")
    public String home(Model model) throws Exception {
        return "/admin/home";
    }

    @GetMapping("/memberConf.do")
    public String memberList(HttpServletRequest request, Model model) throws Exception {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        int total = memberService.memberCount(page);
        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<Member> memberList = memberService.memberList(page);
        model.addAttribute("memberList", memberList);

        return "/admin/memberList";
    }

    @GetMapping("/boardMgnConf.do")
    public String boardMgnList(HttpServletRequest request, Model model) throws Exception {
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        int total = boardMgnService.countBoardMgn(page);
        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<BoardMgn> boardMgnList = boardMgnService.listBoardMgn(page);
        model.addAttribute("boardMgnList", boardMgnList);



        return "/admin/boardTypeList";
    }

    @GetMapping("/getBoardMgn.do")
    public String boardMgnGet(HttpServletRequest request, Model model) throws Exception {
        int bmNo = Integer.parseInt(request.getParameter("no"));

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        return "/admin/boardTypeGet";
    }

    @GetMapping("/boardMgnAdd.do")
    public String boardMgnAdd(Model model) throws Exception {

        return "/admin/boardTypeAdd";
    }

    @PostMapping("/boardMgnAdd.do")
    public String boardMgnAddPro(BoardMgn boardMgn, Model model) throws Exception {
        boardMgnService.boardMgnInsert(boardMgn);

        return "redirect:/admin/boardMgnConf.do";
    }

    @GetMapping("/boardMgnModify.do")
    public String boardMgnModify(HttpServletRequest request, Model model) throws Exception {
        int bmNo = Integer.parseInt(request.getParameter("no"));

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        return "/admin/boardTypeUpdate";
    }

    @PostMapping("/boardMgnModify.do")
    public String boardMgnModifyPro(BoardMgn boardMgn, Model model) throws Exception {

        int par = boardMgn.getPar();

        boardMgnService.boardMgnUpdate(boardMgn);

        return "redirect:/admin/getBoardMgn.do?no="+boardMgn.getBmNo();
    }

    @GetMapping("/boardMgnDel.do")
    public String boardMgnDeletePro(HttpServletRequest request, Model model) throws Exception {
        int bmNo = Integer.parseInt(request.getParameter("no"));

        List<BoardVO> boardList = boardService.boardListForAdmin(bmNo);

        for (BoardVO board : boardList) {
            int bno = board.getBno();

            FileDTO fileDTO = new FileDTO();
            fileDTO.setPar(bno);
            fileDTO.setToUse("board");
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
        }

        boardMgnService.boardMgnDelete(bmNo);

        return "redirect:/admin/boardMgnConf.do";
    }

    @GetMapping("/lectureConf.do")
    public String lectureList(HttpServletRequest request, Model model) throws Exception {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        int total = lectureService.lectureCount(page);

        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<LectureVO> lectureList = lectureService.lectureList(page);
        model.addAttribute("lectureList", lectureList);

        return "/admin/lectureList";
    }

    @GetMapping("/lectureAdd.do")
    public String lectureAdd(Model model) throws Exception {
        return "/admin/lectureAdd";
    }

    @PostMapping("/lectureAdd.do")
    public String lectureAddPro(HttpServletRequest request,Lecture lecture, Model model, List<MultipartFile> uploadThumbnail) throws Exception {

        Lecture lec = lectureService.lectureInsert(lecture);

        if(uploadThumbnail != null) {
            ServletContext application = request.getSession().getServletContext();
            //String realPath = application.getRealPath("/resources/upload");                                                             // 운영 서버
            String realPath = "D:\\park\\project\\personal\\personal_pro04_2023\\project04\\src\\main\\webapp\\resources\\upload";	      // 개발 서버

            SimpleDateFormat sdf = new SimpleDateFormat("yyy/MM/dd");
            Date date = new Date();
            String dateFolder = sdf.format(date);

            File uploadPath = new File(realPath, dateFolder);
            if(!uploadPath.exists()) {uploadPath.mkdirs();}

            for(MultipartFile multipartFile : uploadThumbnail) {
                if(multipartFile.isEmpty()) {continue;}

                String originalFilename = multipartFile.getOriginalFilename();
                UUID uuid = UUID.randomUUID();
                String uploadFilename = uuid.toString() + "_" + originalFilename;

                FileDTO fileDTO = new FileDTO();
                fileDTO.setPar(lec.getLno());
                fileDTO.setSaveFolder(String.valueOf(uploadPath));

                String fileType = multipartFile.getContentType();
                String[] fileTypeArr = fileType.split("/");
                fileDTO.setFileType(fileTypeArr[0]);

                fileDTO.setOriginNm(originalFilename);
                fileDTO.setSaveNm(uploadFilename);
                fileDTO.setToUse("lecture");

                multipartFile.transferTo(new File(uploadPath, uploadFilename));     // 서버에 파일 업로드 수행
                filesService.filesInsert(fileDTO);                                  // DB 등록
            }

        }

        return "redirect:/admin/lectureConf.do";
    }


    @GetMapping("/findPro.do")
    public String findPro(HttpServletRequest request, Model model) throws Exception {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        int total = 0;

        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<Product> proList = new ArrayList<>();
        model.addAttribute("proList", proList);

        return "/admin/findPro";
    }

    @GetMapping("/findTeacher.do")
    public String findTeacher(HttpServletRequest request, Model model) throws Exception {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        int total = memberService.memberTeacherCount(page);

        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<Member> teacherList = memberService.memberTeacherList(page);
        model.addAttribute("teacherList", teacherList);

        return "/admin/findTeacher";
    }

    @GetMapping("/findLecture.do")
    public String findLecture(HttpServletRequest request, Model model) throws Exception {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        int total = lectureService.lectureCount(page);

        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<LectureVO> lectureList = lectureService.lectureList(page);
        model.addAttribute("lectureList", lectureList);

        return "/admin/findLecture";
    }

}