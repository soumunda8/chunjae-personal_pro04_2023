package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Comment;
import kr.ed.haebeop.domain.CommentVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CommentMapper {

    @Select("SELECT * FROM commentList WHERE par = #{par}")
    public List<CommentVO> commentList(int par) throws Exception;

    @Select("SELECT * FROM commentList ORDER BY resDate DESC LIMIT 1")
    public CommentVO commentLast() throws Exception;

    @Select("SELECT * FROM commentList WHERE cno = #{cno}")
    public CommentVO comment(int cno) throws Exception;

    @Insert("INSERT INTO comment VALUES(DEFAULT, #{author}, #{content}, DEFAULT, #{par})")
    public void commentInsert(Comment comment) throws Exception;

    @Update("UPDATE comment SET content = #{content} WHERE cno = #{cno}")
    public void commentUpdate(Comment comment) throws Exception;

    @Delete("DELETE FROM comment WHERE cno = #{cno}")
    public void commentDelete(int cno) throws Exception;

    @Delete("DELETE FROM comment WHERE par = #{par}")
    public void commentDeleteAll(int par) throws Exception;

}