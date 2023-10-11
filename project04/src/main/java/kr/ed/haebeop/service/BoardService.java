package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.util.Page;

import java.util.List;

public interface BoardService {

    public List<Board> boardList(Page page);
    public int boardCount(Page page);

}