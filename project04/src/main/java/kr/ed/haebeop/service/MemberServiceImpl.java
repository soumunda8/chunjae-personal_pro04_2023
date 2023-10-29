package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Member;
import kr.ed.haebeop.persistence.MemberMapper;
import kr.ed.haebeop.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;

    BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();

    @Override
    public List<Member> memberList(Page page) throws Exception {
        return memberMapper.memberList(page);
    }

    @Override
    public int memberCount(Page page) throws Exception {
        return memberMapper.memberCount(page);
    }

    @Override
    public List<Member> memberTeacherList(Page page) throws Exception {
        return memberMapper.memberTeacherList(page);
    }

    @Override
    public int memberTeacherCount(Page page) throws Exception {
        return memberMapper.memberTeacherCount(page);
    }

    @Override
    public boolean loginPro(String id, String pw) throws Exception {
        boolean pass = false;
        Member member = memberMapper.getMember(id);
        if(member != null) {
            pass = pwEncoder.matches(pw, member.getPw());
        }
        return pass;
    }

    @Override
    public boolean idCheck(String id) throws Exception {
        boolean pass = true;
        int cnt = memberMapper.idCheck(id);
        if(cnt > 0) pass = false;
        return pass;
    }

    @Override
    public Member memberGet(String id) throws Exception {
        return memberMapper.getMember(id);
    }

    @Override
    public List<Member> getTeacherMain() throws Exception {
        return memberMapper.getTeacherMain();
    }

    @Override
    public void insert(Member member) throws Exception {
        String ppw = member.getPw();
        String pw = pwEncoder.encode(ppw);
        member.setPw(pw);
        memberMapper.insert(member);
    }

    @Override
    public void updateMemberForTeacher(String id) throws Exception {
        memberMapper.updateMemberForTeacher(id);
    }

    @Override
    public void firepoint(Member member) throws Exception {
        memberMapper.firepoint(member);
    }

    @Override
    public void updateMember(Member member) throws Exception {
        memberMapper.updateMember(member);
    }

    @Override
    public void updatePw(Member member) throws Exception {
        String ppw = member.getPw();
        String pw = pwEncoder.encode(ppw);
        member.setPw(pw);
        memberMapper.updatePw(member);
    }

    @Override
    public void removeMember(String id) throws Exception {
        memberMapper.removeMember(id);
    }
}