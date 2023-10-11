package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.persistence.BoardMapper;
import kr.ed.haebeop.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardMapper boardMapper;

    @Override
    public List<Board> boardList(Page page) {
        return boardMapper.boardList(page);
    }

    @Override
    public int boardCount(Page page) {
        return boardMapper.boardCount(page);
    }
}