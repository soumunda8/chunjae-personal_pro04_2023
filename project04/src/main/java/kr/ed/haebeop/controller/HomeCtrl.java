package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.service.BoardMgnService;
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

    @Autowired
    private BoardMgnService boardMgnService;

    @RequestMapping(value = "/")
    public String index(Model model) throws Exception {

        List<BoardMgn> boardMgnListForHeader = boardMgnService.listBoardMgnForHeader();
        model.addAttribute("boardMgnListForHeader", boardMgnListForHeader);

        return "/index";
    }

    @RequestMapping(value = "/sample")
    public String sample(Model model) {
        return "/sample";
    }

}