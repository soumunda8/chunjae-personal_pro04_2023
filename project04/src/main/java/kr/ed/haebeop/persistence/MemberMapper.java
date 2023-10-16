package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Member;
import kr.ed.haebeop.util.Page;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface MemberMapper {

    public List<Member> memberList(Page page) throws Exception;
    public int memberCount(Page page) throws Exception;
    public List<Member> memberTeacherList(Page page) throws Exception;
    public int memberTeacherCount(Page page) throws Exception;
    public Member getMember(String id) throws Exception;
    public int idCheck(String id) throws Exception;
    public void insert(Member member) throws Exception;

}