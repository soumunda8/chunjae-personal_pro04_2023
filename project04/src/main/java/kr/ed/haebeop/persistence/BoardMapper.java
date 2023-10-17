package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.domain.BoardVO;
import kr.ed.haebeop.util.BoardPage;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    public List<BoardVO> boardList(BoardPage page) throws Exception;
    public int boardCount(BoardPage page) throws Exception;
    public List<BoardVO> boardListForAdmin(int bmNo) throws Exception;
    public BoardVO boardGet(int bno) throws Exception;
    public int boardGetLast() throws Exception;
    public void boardInsert(Board board) throws Exception;
    public void boardUpdate(Board board) throws Exception;
    public void qnaUpdate(Board board) throws Exception;
    public void boardVisitedUpdate(int bno) throws Exception;
    public void boardDelete(int bno) throws Exception;

}