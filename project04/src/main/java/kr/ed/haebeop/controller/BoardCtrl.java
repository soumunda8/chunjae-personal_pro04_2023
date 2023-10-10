package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/board/")
public class BoardCtrl {

    @Autowired
    private BoardService boardService;

    @GetMapping("boardList")
    public String boardList(Model model) throws Exception {
        List<Board> boardList = boardService.boardList();
        model.addAttribute("boardList", boardList);
        return "/board/boardList";
    }

}