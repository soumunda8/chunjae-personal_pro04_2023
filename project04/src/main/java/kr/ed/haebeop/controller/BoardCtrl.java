package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.domain.BoardVO;
import kr.ed.haebeop.service.BoardMgnService;
import kr.ed.haebeop.service.BoardService;
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
@RequestMapping("/board")
public class BoardCtrl {

    @Autowired
    HttpSession session;

    @Autowired
    private BoardService boardService;

    @Autowired
    private BoardMgnService boardMgnService;

    @GetMapping("/")
    public String main() throws Exception {
        return "redirect:/board/list.do?no=1";
    }

    @GetMapping("/list.do")
    public String boardList(HttpServletRequest request, Model model) throws Exception {
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";

        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int bmNo = request.getParameter("no") != null ? Integer.parseInt(request.getParameter("no")) : 1;

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
        model.addAttribute("boardList", boardList);

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        // 권한 관련 - 등록
        boolean addCheck = false;
        if(sid != "" && (boardMgn.getAboutAuth() == 2 || sid.equals("admin"))) {
            addCheck = true;
        }

        model.addAttribute("addCheck", addCheck);

        return "/board/boardList";
    }

    @GetMapping("/add.do")
    public String boardAdd(HttpServletRequest request, Model model) throws Exception {
        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bmNo = Integer.parseInt(request.getParameter("no"));

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        return "/board/boardAdd";
    }

    @PostMapping("/add.do")
    public String boardAddPro(HttpServletRequest request, Board board, Model model) throws Exception {
        String author = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bmNo = Integer.parseInt(request.getParameter("no"));

        board.setAuthor(author);
        board.setBmNo(bmNo);
        boardService.boardInsert(board);

        return "redirect:/board/list.do?no=" + bmNo;
    }

    @GetMapping("/get.do")
    public String boardDetail(HttpServletRequest request, Model model) throws Exception {

        String sid = session.getAttribute("sid") != null ? (String) session.getAttribute("sid") : "";
        int bno = Integer.parseInt(request.getParameter("bno"));

        BoardVO board = boardService.boardGet(bno);
        model.addAttribute("board", board);

        // 권한 관련 - 등록
        boolean addCheck = false;
        if(sid != "" && board.getAuthor().equals(sid)) {
            addCheck = true;
        }

        model.addAttribute("addCheck", addCheck);

        return "/board/boardGet";
    }

}