package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.MemberMgn;
import kr.ed.haebeop.domain.MemberMgnVO;
import kr.ed.haebeop.persistence.MemberMgnMapper;
import kr.ed.haebeop.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberMgnServiceImpl implements MemberMgnService {

    @Autowired
    private MemberMgnMapper memberMgnMapper;

    @Override
    public List<MemberMgnVO> memberMgnList(Page page) throws Exception {
        return memberMgnMapper.memberMgnList(page);
    }

    @Override
    public int memberMgnCount() throws Exception {
        return memberMgnMapper.memberMgnCount();
    }

    @Override
    public MemberMgnVO memberMgnGet(String id) throws Exception {
        return memberMgnMapper.memberMgnGet(id);
    }

    @Override
    public void memberMgnInsert(String id) throws Exception {
        memberMgnMapper.memberMgnInsert(id);
    }

    @Override
    public void memberMgnStatusUpdate(MemberMgn memberMgn) throws Exception {
        memberMgnMapper.memberMgnStatusUpdate(memberMgn);
    }

    @Override
    public void memberMgnUpdate(MemberMgn memberMgn) throws Exception {
        memberMgnMapper.memberMgnUpdate(memberMgn);
    }

    @Override
    public void memberMgnUpdateAccept(String author) throws Exception {
        memberMgnMapper.memberMgnUpdateAccept(author);
    }
}