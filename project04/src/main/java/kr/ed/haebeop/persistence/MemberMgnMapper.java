package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.MemberMgn;
import kr.ed.haebeop.domain.MemberMgnVO;
import kr.ed.haebeop.util.Page;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface MemberMgnMapper {

    @Select("SELECT * FROM memberMgnList WHERE mStatus IN (1, 2, 4) LIMIT #{postStart}, #{postCount}")
    public List<MemberMgnVO> memberMgnList(Page page) throws Exception;

    @Select("SELECT COUNT(*) FROM memberMgnList WHERE mStatus IN (1, 2, 4)")
    public int memberMgnCount() throws Exception;

    @Select("SELECT * FROM memberMgnList WHERE author = #{author}")
    public MemberMgnVO memberMgnGet(String author) throws Exception;

    @Insert("INSERT INTO memberMgn VALUES(DEFAULT, #{author}, DEFAULT, 1, NULL)")
    public void memberMgnInsert(String id) throws Exception;

    @Update("UPDATE memberMgn SET mStatus = #{mStatus} WHERE author = #{author}")
    public void memberMgnStatusUpdate(MemberMgn memberMgn) throws Exception;

    @Update("UPDATE memberMgn SET approveYn = false, mStatus = 2, content = #{content} WHERE mmNo = #{mmNo}")
    public void memberMgnUpdate(MemberMgn memberMgn) throws Exception;

    @Update("UPDATE memberMgn SET mStatus = 3, approveYn = true, content = '' WHERE author = #{author}")
    public void memberMgnUpdateAccept(String author) throws Exception;

}