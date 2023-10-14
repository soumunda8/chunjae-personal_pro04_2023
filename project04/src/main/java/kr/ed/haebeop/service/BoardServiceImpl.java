package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.domain.BoardVO;
import kr.ed.haebeop.persistence.BoardMapper;
import kr.ed.haebeop.util.BoardPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardMapper boardMapper;

    @Override
    public List<BoardVO> boardList(BoardPage page) throws Exception {
        return boardMapper.boardList(page);
    }

    @Override
    public int boardCount(BoardPage page) throws Exception {
        return boardMapper.boardCount(page);
    }

    @Override
    public BoardVO boardGet(int bno) throws Exception {
        return boardMapper.boardGet(bno);
    }

    @Override
    public int boardInsert(Board board) throws Exception {
        boardMapper.boardInsert(board);
        return boardMapper.boardGetLast();
    }
}