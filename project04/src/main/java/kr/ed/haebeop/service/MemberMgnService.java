package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.MemberMgn;
import kr.ed.haebeop.domain.MemberMgnVO;
import kr.ed.haebeop.util.Page;

import java.util.List;

public interface MemberMgnService {

    public List<MemberMgnVO> memberMgnList(Page page) throws Exception;
    public int memberMgnCount() throws Exception;
    public MemberMgnVO memberMgnGet(String id) throws Exception;
    public void memberMgnInsert(String id) throws Exception;
    public void memberMgnStatusUpdate(MemberMgn memberMgn) throws Exception;
    public void memberMgnUpdate(MemberMgn memberMgn) throws Exception;
    public void memberMgnUpdateAccept(String author) throws Exception;

}