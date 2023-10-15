package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.util.Page;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface BoardMgnMapper {

    @Select("SELECT * FROM boardMgn")
    public List<BoardMgn> listBoardMgnForHeader() throws Exception;

    @Select("SELECT * FROM boardMgn LIMIT #{postStart}, #{postCount}")
    public List<BoardMgn> listBoardMgn(Page page) throws Exception;

    @Select("SELECT COUNT(*) FROM boardMgn")
    public int countBoardMgn(Page page) throws Exception;

    @Select("SELECT * FROM boardMgn WHERE bmNo = #{bmNo}")
    public BoardMgn getBoardMgn(int bmNo) throws Exception;

    @Insert("INSERT INTO boardMgn VALUES(DEFAULT, #{boardNm}, #{aboutAuth}, #{commentUse}, #{fileUse})")
    public void boardMgnInsert(BoardMgn boardMgn) throws Exception;

    @Update("UPDATE boardMgn SET boardNm = #{boardNm}, aboutAuth = #{aboutAuth}, commentUse = #{commentUse}, fileUse = #{fileUse} WHERE bmNo = #{bmNo}")
    public void boardMgnUpdate(BoardMgn boardMgn) throws Exception;

}