package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Comment;
import kr.ed.haebeop.domain.CommentVO;

import java.util.List;

public interface CommentService {

    public List<CommentVO> commentList(int par) throws Exception;
    public CommentVO comment(int cno) throws Exception;
    public CommentVO commentInsert(Comment comment) throws Exception;
    public void commentUpdate(Comment comment) throws Exception;
    public void commentDelete(int cno) throws Exception;
    public void commentDeleteAll(int par) throws Exception;

}