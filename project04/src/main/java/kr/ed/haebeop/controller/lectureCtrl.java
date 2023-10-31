package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.*;
import kr.ed.haebeop.util.BoardPage;
import kr.ed.haebeop.util.LecturePage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/lecture")
public class lectureCtrl {

    @Autowired
    HttpSession session;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private BoardMgnService boardMgnService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private FilesService filesService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private CommentService commentService;

    @RequestMapping("/list.do")
    public String lectureList(HttpServletRequest request, Model model) throws Exception {

        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        String cateNo = request.getParameter("cateNo") != null ? request.getParameter("cateNo") : "";

        LecturePage page = new LecturePage();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        page.setCateNo(cateNo);
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

        List<Category> categoryList = categoryService.categoryKeywordList("su");
        model.addAttribute("categoryList", categoryList);

        model.addAttribute("cateNo", cateNo);

        return "/lecture/lectureList";

    }

    @RequestMapping("/get.do")
    public String lectureGet(HttpServletRequest request, Model model) throws Exception {

        int lno = Integer.parseInt(request.getParameter("lno"));

        LectureVO lecture = lectureService.lectureGet(lno);
        model.addAttribute("lecture", lecture);

        List<BoardMgn> boardMgnList = boardMgnService.getSubBoardMgn(lno);
        model.addAttribute("boardMgnList", boardMgnList);

        return "/lecture/lectureGet";
    }


    @GetMapping("/boardList.do")
    public String lectureBoardList(HttpServletRequest request, Model model) throws Exception{
        int bmNo = request.getParameter("no") != null ? Integer.parseInt(request.getParameter("no")) : 0;
        int lno = Integer.parseInt(request.getParameter("lno"));
        String sid = (String) session.getAttribute("sid");
        Member member = memberService.memberGet(sid);

        LectureVO lecture = lectureService.lectureGet(lno);
        model.addAttribute("lecture", lecture);

        List<BoardMgn> boardMgnList = boardMgnService.getSubBoardMgn(lno);
        model.addAttribute("boardMgnList", boardMgnList);

        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

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

        String pathGetUrl = "";
        for(BoardVO boardVO : boardList) {

            pathGetUrl = "/lecture/boardGet.do?bno=" + boardVO.getBno();
            boardVO.setPathGetUrl(pathGetUrl);

            String authorNm = boardVO.getNm();
            if(!authorNm.equals("관리자")) {
                String nm = authorNm.substring(0, 1);
                for(int i = 0; i < authorNm.length()-2; i++){
                    nm += "*";
                }
                nm += authorNm.substring(authorNm.length() - 1);
                boardVO.setNm(nm);
            }
        }

        model.addAttribute("bmNo", bmNo);
        model.addAttribute("boardList", boardList);

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        // 권한 관련 - 등록
        boolean addCheck = false;

        int cnt = 0;
        if(member != null){
            if(member.getGrade() == 1) {
                cnt = lecture.getTeacherId().equals(sid) ? 1 : 0 ;
            }

            if(member.getGrade() == 2) {
                cnt = paymentService.paymentGet(sid) != null ? 1 : 0;
            }
        }

        if(sid != null && ((boardMgn.getAboutAuth() >= memberService.memberGet(sid).getGrade() && cnt == 1) || sid.equals("admin"))) {
            addCheck = true;
        }

        model.addAttribute("addCheck", addCheck);

        String pathUrl = "/lecture/boardList.do";
        model.addAttribute("pathUrl", pathUrl);

        String pathPageUrl = "/lecture/boardList.do?no=" + bmNo + "&lno=" + lno;
        model.addAttribute("pathPageUrl", pathPageUrl);

        model.addAttribute("lno", lno);

        return "/lecture/lectBoardList";
    }

    @GetMapping("/boardAdd.do")
    public String lectureBoardAdd(HttpServletRequest request, Model model) throws Exception{
        int bmNo = request.getParameter("no") != null ? Integer.parseInt(request.getParameter("no")) : 0;
        int lno = Integer.parseInt(request.getParameter("lno"));
        String sid = (String) session.getAttribute("sid");

        LectureVO lecture = lectureService.lectureGet(lno);
        model.addAttribute("lecture", lecture);

        List<BoardMgn> boardMgnList = boardMgnService.getSubBoardMgn(lno);
        model.addAttribute("boardMgnList", boardMgnList);

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        model.addAttribute("bmNo", bmNo);

        String pathUrl = "/lecture/boardList.do?no=" + bmNo + "&lno=" + lecture.getLno();
        model.addAttribute("pathUrl", pathUrl);

        return "/lecture/lectBoardAdd";
    }

    @GetMapping("/boardGet.do")
    public String lectureBoardGet(HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bno = Integer.parseInt(request.getParameter("bno"));

        Cookie[] cookies = request.getCookies();
        boolean hasCookie = false;
        if (cookies != null) {
            String bcookie = "board"+bno;
            for (Cookie cookie : cookies) {
                if (bcookie.equals(cookie.getName())) {
                    hasCookie = true;
                    break;
                }
            }
            if(!hasCookie){
                Cookie cookie = new Cookie(bcookie, bcookie);
                cookie.setMaxAge(3600); // 초 단위, 1시간

                // 응답 헤더에 쿠키 추가
                response.addCookie(cookie);
            }
        }

        BoardVO board = boardService.boardGet(hasCookie, bno, sid);
        BoardMgn boardMgn = boardMgnService.getBoardMgn(board.getBmNo());
        Member member = memberService.memberGet(sid);
        LectureVO lecture = lectureService.lectureGet(boardMgn.getPar());

        model.addAttribute("lecture", lecture);
        model.addAttribute("lno", boardMgn.getPar());

        String bNm = board.getNm();

        if(!bNm.equals("관리자")) {
            String nm = bNm.substring(0, 1);
            for(int i = 0; i < bNm.length()-2; i++){
                nm += "*";
            }
            nm += bNm.substring(bNm.length() - 1);
            board.setNm(nm);
        }
        model.addAttribute("board", board);

        // 권한 관련 - 수정
        boolean addCheck = false;
        if(!sid.equals("") && board.getAuthor().equals(sid)) {
            addCheck = true;
        }
        model.addAttribute("addCheck", addCheck);

        FileDTO fileDTO = new FileDTO();
        fileDTO.setPar(board.getBno());
        fileDTO.setToUse("board");
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

        String pathUrl = "/lecture/boardList.do?no=" + board.getBmNo() + "&lno=" + lecture.getLno();
        model.addAttribute("pathUrl", pathUrl);

        String pathUpdateUrl = "/lecture/boardUpdate.do?bno=" + bno;
        model.addAttribute("pathUpdateUrl", pathUpdateUrl);

        List<BoardMgn> boardMgnList = boardMgnService.getSubBoardMgn(lecture.getLno());
        model.addAttribute("boardMgnList", boardMgnList);

        model.addAttribute("bmNo", board.getBmNo());

        int cnt = 0;
        if(member != null) {
            if(member.getGrade() == 1) {
                cnt = lecture.getTeacherId().equals(sid) ? 1 : 0 ;
            }
        }

        model.addAttribute("cnt", cnt);
        model.addAttribute("boardMgn", boardMgn);

        return "/lecture/lectBoardGet";
    }

    @GetMapping("/boardUpdate.do")
    public String lectureBoardUpdate(HttpServletRequest request, Model model) throws Exception{
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bno = Integer.parseInt(request.getParameter("bno"));

        BoardVO board = boardService.boardGetInfo(bno);
        model.addAttribute("board", board);

        BoardMgn boardMgn = boardMgnService.getBoardMgn(board.getBmNo());
        model.addAttribute("boardMgn", boardMgn);
        LectureVO lecture = lectureService.lectureGet(boardMgn.getPar());

        model.addAttribute("lecture", lecture);
        model.addAttribute("lecture", lecture);
        model.addAttribute("lno", boardMgn.getPar());

        List<BoardMgn> boardMgnList = boardMgnService.getSubBoardMgn(boardMgn.getPar());
        model.addAttribute("boardMgnList", boardMgnList);

        // 권한 관련 - 수정
        boolean addCheck = false;
        if(sid != null && board.getAuthor().equals(sid)) {
            addCheck = true;
        }
        model.addAttribute("addCheck", addCheck);

        FileDTO fileDTO = new FileDTO();
        fileDTO.setPar(board.getBno());
        fileDTO.setToUse("board");

        List<FileDTO> fileList = filesService.fileListByPar(fileDTO);
        model.addAttribute("fileList", fileList);

        String pathUrl = "/lecture/boardGet.do?bno=" + bno;
        model.addAttribute("pathUrl", pathUrl);

        model.addAttribute("bmNo", board.getBmNo());

        return "/lecture/lectBoardUpdate";
    }

}