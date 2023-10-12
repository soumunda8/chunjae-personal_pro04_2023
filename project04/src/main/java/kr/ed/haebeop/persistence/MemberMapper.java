package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Member;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface MemberMapper {

    public List<Member> memberList() throws Exception;
    public Member getMember(String id) throws Exception;
    public int idCheck(String id) throws Exception;
    public void insert(Member member) throws Exception;

}