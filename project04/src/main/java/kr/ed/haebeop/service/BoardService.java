package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.util.BoardPage;

import java.util.List;

public interface BoardService {

    public List<Board> boardList(BoardPage page);
    public int boardCount(BoardPage page);

}