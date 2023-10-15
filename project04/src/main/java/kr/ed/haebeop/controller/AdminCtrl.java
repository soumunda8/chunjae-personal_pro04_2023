package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.domain.LectureVO;
import kr.ed.haebeop.domain.Member;
import kr.ed.haebeop.service.BoardMgnService;
import kr.ed.haebeop.service.LectureService;
import kr.ed.haebeop.service.MemberService;
import kr.ed.haebeop.util.BoardPage;
import kr.ed.haebeop.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

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
        System.out.println(boardMgn.toString());

        boardMgnService.boardMgnUpdate(boardMgn);

        return "redirect:/admin/getBoardMgn.do?no="+boardMgn.getBmNo();
    }

    @GetMapping("/boardMgnDel.do")
    public String boardMgnDeletePro(HttpServletRequest request, Model model) throws Exception {
        int bmNo = Integer.parseInt(request.getParameter("no"));

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

}