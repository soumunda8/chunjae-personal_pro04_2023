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
    public void boardMgnInsert(BoardMgn boardMgn) throws Exception {
        boardMgnMapper.boardMgnInsert(boardMgn);
    }

}