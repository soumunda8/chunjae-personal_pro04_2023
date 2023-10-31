package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.domain.BoardVO;
import kr.ed.haebeop.util.BoardPage;

import java.util.List;

public interface BoardService {

    public List<BoardVO> boardList(BoardPage page) throws Exception;
    public int boardCount(BoardPage page) throws Exception;
    public List<BoardVO> boardListForAdmin(int bmNo) throws Exception;
    public BoardVO boardGet(boolean hasCookie, int bno, String sid) throws Exception;
    public BoardVO boardGetInfo(int bno) throws Exception;
    public int boardInsert(Board board) throws Exception;
    public void boardUpdate(Board board) throws Exception;
    public void qnaUpdate(Board board) throws Exception;
    public void boardDelete(int bno) throws Exception;

}