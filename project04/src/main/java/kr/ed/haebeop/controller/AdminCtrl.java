package kr.ed.haebeop.controller;

import kr.ed.haebeop.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminCtrl {

    @Autowired
    private MemberService memberService;

    @GetMapping("/")
    public String home(Model model) throws Exception {


        return "/admin/home";
    }

}