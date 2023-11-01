package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.BoardMgnService;
import kr.ed.haebeop.service.FilesService;
import kr.ed.haebeop.service.LectureService;
import kr.ed.haebeop.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Controller
public class HomeCtrl {

    /*
    @Autowired
    private ReviewService reviewService;
    */

    @Autowired
    private LectureService lectureService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private FilesService filesService;

    @RequestMapping(value = "/")
    public String index(Model model) throws Exception {

        /*
        List<Review> reviewList = reviewService.reviewList_main();
        model.addAttribute("reviewList", reviewList);
        */

        List<LectureVO> lectureList = lectureService.lectureListMain();
        model.addAttribute("lectureList", lectureList);

        List<Member> teacherList = memberService.getTeacherMain();
        for (Member member : teacherList) {
            FileDTO fileDTO = filesService.fileByParForThumbnail(member.getMno());
            if(fileDTO != null && fileDTO.getFileType().equals("image")) {
                member.setFileNm(fileDTO.getSaveNm());
                member.setSaveFolder(fileDTO.getSaveFolder());
            }
        }
        model.addAttribute("teacherList", teacherList);

        return "/index";
    }

}