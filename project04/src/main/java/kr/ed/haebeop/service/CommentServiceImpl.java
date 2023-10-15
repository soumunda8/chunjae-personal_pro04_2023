package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Comment;
import kr.ed.haebeop.domain.CommentVO;
import kr.ed.haebeop.persistence.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Override
    public List<CommentVO> commentList(int par) throws Exception {
        return commentMapper.commentList(par);
    }

    @Override
    public CommentVO comment(int cno) throws Exception {
        return commentMapper.comment(cno);
    }

    @Override
    public CommentVO commentInsert(Comment comment) throws Exception {
        commentMapper.commentInsert(comment);
        CommentVO commentVO = commentMapper.commentLast();
        return commentVO;
    }

    @Override
    public void commentUpdate(Comment comment) throws Exception {
        commentMapper.commentUpdate(comment);
    }

    @Override
    public void commentDelete(int cno) throws Exception {
        commentMapper.commentDelete(cno);
    }

    @Override
    public void commentDeleteAll(int par) throws Exception {
        commentMapper.commentDeleteAll(par);
    }
}