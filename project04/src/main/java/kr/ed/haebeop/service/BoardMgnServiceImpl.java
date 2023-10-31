package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.persistence.BoardMgnMapper;
import kr.ed.haebeop.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardMgnServiceImpl implements BoardMgnService {

    @Autowired
    private BoardMgnMapper boardMgnMapper;

    @Override
    public List<BoardMgn> listBoardMgnForHeader() throws Exception {
        return boardMgnMapper.listBoardMgnForHeader();
    }

    @Override
    public List<BoardMgn> listBoardMgn(Page page) throws Exception {
        return boardMgnMapper.listBoardMgn(page);
    }

    @Override
    public int countBoardMgn(Page page) throws Exception {
        return boardMgnMapper.countBoardMgn(page);
    }

    @Override
    public BoardMgn getBoardMgn(int bmNo) throws Exception {
        return boardMgnMapper.getBoardMgn(bmNo);
    }

    @Override
    public List<BoardMgn> getSubBoardMgn(int par) throws Exception {
        return boardMgnMapper.getSubBoardMgn(par);
    }

    @Override
    public void boardMgnInsert(BoardMgn boardMgn) throws Exception {
        boardMgnMapper.boardMgnInsert(boardMgn);
    }

    @Override
    public void boardMgnUpdate(BoardMgn boardMgn) throws Exception {
        boardMgnMapper.boardMgnUpdate(boardMgn);
    }

    @Override
    public void boardMgnDelete(int bmNo) throws Exception {
        boardMgnMapper.boardMgnDelete(bmNo);
    }

}