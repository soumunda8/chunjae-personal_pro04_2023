package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Member;
import kr.ed.haebeop.util.Page;

import java.util.List;

public interface MemberService {

    public List<Member> memberList(Page page) throws Exception;

    public int memberCount(Page page) throws Exception;

    public List<Member> memberTeacherList(Page page) throws Exception;

    public int memberTeacherCount(Page page) throws Exception;

    public boolean loginPro(String id, String pw) throws Exception;

    public boolean idCheck(String id) throws Exception;

    public Member memberGet(String id) throws Exception;

    public List<Member> getTeacherMain() throws Exception;

    public void insert(Member member) throws Exception;

    public void updateMemberForTeacher(String id) throws Exception;

    public void firepoint(Member member) throws Exception;

    public void updateMember(Member member) throws Exception;

    public void updatePw(Member member) throws Exception;

    public void removeMember(String id) throws Exception;

}