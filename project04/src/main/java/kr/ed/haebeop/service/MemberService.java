package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Member;
import kr.ed.haebeop.util.Page;

import java.util.List;

public interface MemberService {

    public List<Member> memberList(Page page) throws Exception;

    public int memberCount(Page page) throws Exception;

    public boolean loginPro(String id, String pw) throws Exception;

    public boolean idCheck(String id) throws Exception;

    public void insert(Member member) throws Exception;

}