package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.*;
import kr.ed.haebeop.util.BoardPage;
import kr.ed.haebeop.util.LecturePage;
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

    @Autowired
    private CategoryService categoryService;

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

        return "/lecture/lectureGet";
    }

}