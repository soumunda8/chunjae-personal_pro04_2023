package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Member;

import java.util.List;

public interface MemberService {

    public List<Member> memberList() throws Exception;

    public boolean loginPro(String id, String pw) throws Exception;

    public boolean idCheck(String id) throws Exception;

    public void insert(Member member) throws Exception;

}