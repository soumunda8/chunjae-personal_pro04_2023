package kr.ed.haebeop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

@Controller
public class HomeCtrl {

    @RequestMapping(value = "/")
    public String index(Model model) {
        return "/index";
    }

    @RequestMapping(value = "/sample")
    public String sample(Model model) {
        return "/sample";
    }

}