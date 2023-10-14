package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.domain.BoardVO;
import kr.ed.haebeop.util.BoardPage;

import java.util.List;

public interface BoardService {

    public List<BoardVO> boardList(BoardPage page) throws Exception;
    public int boardCount(BoardPage page) throws Exception;
    public BoardVO boardGet(int bno) throws Exception;
    public int boardInsert(Board board) throws Exception;

}