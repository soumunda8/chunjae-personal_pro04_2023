package kr.ed.haebeop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/notice/")
public class NoticeCtrl {

    @GetMapping("list.do")
    public String noticeList(HttpServletRequest request, Model model) throws Exception {

        return "/notice/list";
    }

}