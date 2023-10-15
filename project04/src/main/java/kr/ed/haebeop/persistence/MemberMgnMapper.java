package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.MemberMgn;
import kr.ed.haebeop.util.Page;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface MemberMgnMapper {

    @Select("SELECT * FROM MemberMgn WHERE !approveYn AND content IS NULL LIMIT #{postStart}, #{postCount}")
    public List<MemberMgnMapper> memberMgnList(Page page) throws Exception;

    @Select("SELECT COUNT(*) FROM MemberMgn WHERE !approveYn AND content IS NULL")
    public int memberMgnCount() throws Exception;

    @Insert("INSERT INTO memberMgn VALUES(DEFAULT, #{author}, DEFAULT, NULL)")
    public void memberMgnInsert(String id) throws Exception;

    @Update("UPDATE memberMgn SET approveYn = #{approveYn}, content = #{content} WHERE author = #{author}")
    public void memberMgnUpdate(MemberMgn memberMgn) throws Exception;

}