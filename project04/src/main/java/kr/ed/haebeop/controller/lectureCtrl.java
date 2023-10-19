package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.domain.BoardVO;
import kr.ed.haebeop.domain.Lecture;
import kr.ed.haebeop.service.BoardMgnService;
import kr.ed.haebeop.service.BoardService;
import kr.ed.haebeop.service.LectureService;
import kr.ed.haebeop.service.MemberService;
import kr.ed.haebeop.util.BoardPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
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

    @RequestMapping("/list.do")
    public String lectureList(HttpServletRequest request, Model model) throws Exception {

        int lno = Integer.parseInt(request.getParameter("no"));

        String sid = (String) session.getAttribute("sid");

        Lecture lecture = lectureService.lectureGet(lno);
        model.addAttribute("lecture", lecture);
        
        BoardMgn boardMgn = boardMgnService.getSubBoardMgn(lno);

        if(boardMgn != null) {
            String type = request.getParameter("type");
            String keyword = request.getParameter("keyword");
            int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

            BoardPage page = new BoardPage();
            page.setSearchType(type);
            page.setSearchKeyword(keyword);
            page.setBmNo(boardMgn.getBmNo());
            int total = boardService.boardCount(page);

            page.makeBlock(curPage, total);
            page.makeLastPageNum(total);
            page.makePostStart(curPage, total);

            model.addAttribute("type", type);
            model.addAttribute("keyword", keyword);
            model.addAttribute("page", page);
            model.addAttribute("curPage", curPage);
            List<BoardVO> boardList = boardService.boardList(page);

            for(BoardVO boardVO : boardList) {
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

            model.addAttribute("boardList", boardList);
            model.addAttribute("boardMgn", boardMgn);

            // 권한 관련 - 등록
            boolean addCheck = false;
            if(sid != null && (boardMgn.getAboutAuth() >= memberService.memberGet(sid).getGrade() || sid.equals("admin"))) {
                addCheck = true;
            }

            model.addAttribute("addCheck", addCheck);

            model.addAttribute("h2Block", " style='display:none'");
        }

        return "/lecture/lectureList";
    }

}