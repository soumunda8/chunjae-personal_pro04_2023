package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.util.Page;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMgnMapper {

    public List<BoardMgn> listBoardMgn(Page page) throws Exception;
    public int countBoardMgn(Page page) throws Exception;
    public BoardMgn getBoardMgn(int bmNo) throws Exception;
    public void boardMgnInsert(BoardMgn boardMgn) throws Exception;

}