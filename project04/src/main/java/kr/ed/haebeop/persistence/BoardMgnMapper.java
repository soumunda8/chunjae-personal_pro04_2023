package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.util.Page;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BoardMgnMapper {

    @Select("SELECT * FROM boardMgn WHERE depth = 1")
    public List<BoardMgn> listBoardMgnForHeader() throws Exception;

    @Select("SELECT * FROM boardMgn ORDER BY depth ASC LIMIT #{postStart}, #{postCount}")
    public List<BoardMgn> listBoardMgn(Page page) throws Exception;

    @Select("SELECT COUNT(*) FROM boardMgn")
    public int countBoardMgn(Page page) throws Exception;

    @Select("SELECT * FROM boardMgn WHERE bmNo = #{bmNo}")
    public BoardMgn getBoardMgn(int bmNo) throws Exception;

    @Select("SELECT * FROM boardMgn WHERE par = #{par}")
    public BoardMgn getSubBoardMgn(int par) throws Exception;

    @Insert("INSERT INTO boardMgn VALUES(DEFAULT, #{boardType}, #{boardNm}, #{depth}, #{par}, #{parNm}, #{aboutAuth}, #{commentUse}, #{fileUse})")
    public void boardMgnInsert(BoardMgn boardMgn) throws Exception;

    @Update("UPDATE boardMgn SET boardType = #{boardType}, boardNm = #{boardNm}, depth = #{depth}, par = #{par}, parNm = #{parNm}, aboutAuth = #{aboutAuth}, commentUse = #{commentUse}, fileUse = #{fileUse} WHERE bmNo = #{bmNo}")
    public void boardMgnUpdate(BoardMgn boardMgn) throws Exception;

    @Delete("DELETE FROM boardMgn WHERE bmNo = #{bmNo}")
    public void boardMgnDelete(int bmNo) throws Exception;

}