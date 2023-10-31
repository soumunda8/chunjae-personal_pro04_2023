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
    public List<BoardVO> boardListForAdmin(int bmNo) throws Exception {
        return boardMapper.boardListForAdmin(bmNo);
    }

    @Override
    public BoardVO boardGet(boolean hasCookie, int bno, String sid) throws Exception {
        BoardVO boardVO = boardMapper.boardGet(bno);
        if(!sid.equals(boardVO.getAuthor()) && !sid.equals("admin")) {
            if(!hasCookie){
                boardMapper.boardVisitedUpdate(bno);
                boardVO.setVisited(boardVO.getVisited() + 1); //확인필요
            }
        }
        return boardVO;
    }

    @Override
    public BoardVO boardGetInfo(int bno) throws Exception {
        BoardVO boardVO = boardMapper.boardGet(bno);
        return boardVO;
    }

    @Override
    public int boardInsert(Board board) throws Exception {
        boardMapper.boardInsert(board);
        return boardMapper.boardGetLast();
    }

    @Override
    public void boardUpdate(Board board) throws Exception {
        boardMapper.boardUpdate(board);
    }

    @Override
    public void qnaUpdate(Board board) throws Exception {
        boardMapper.qnaUpdate(board);
    }

    @Override
    public void boardDelete(int bno) throws Exception {
        boardMapper.boardDelete(bno);
    }

}