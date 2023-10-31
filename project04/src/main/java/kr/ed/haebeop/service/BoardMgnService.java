package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.util.Page;

import java.util.List;

public interface BoardMgnService {

    public List<BoardMgn> listBoardMgnForHeader() throws Exception;
    public List<BoardMgn> listBoardMgn(Page page) throws Exception;
    public int countBoardMgn(Page page) throws Exception;
    public BoardMgn getBoardMgn(int bmNo) throws Exception;
    public List<BoardMgn> getSubBoardMgn(int par) throws Exception;
    public void boardMgnInsert(BoardMgn boardMgn) throws Exception;
    public void boardMgnUpdate(BoardMgn boardMgn) throws Exception;
    public void boardMgnDelete(int bmNo) throws Exception;

}