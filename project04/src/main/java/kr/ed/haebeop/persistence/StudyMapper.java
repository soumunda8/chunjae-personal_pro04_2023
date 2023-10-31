package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Study;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface StudyMapper {

    // 구매 확정 추후 추가 예정 [ TRUE -> DEFAULT ]
    @Insert("INSERT INTO study VALUES(DEFAULT, ${lno}, #{studentId}, FALSE, 0, TRUE, DEFAULT)")
    public void studyInsert(Study study) throws Exception;

    @Select("SELECT * FROM study ORDER BY resDate DESC LIMIT 1")
    public Study studyLast() throws Exception;

    @Update("UPDATE study SET totalTime = #{totalTime} WHERE sno = #{sno}")
    public void studyTotalTimeUpdate(Study study) throws Exception;

    @Update("UPDATE study SET studyYn = TRUE WHERE sno = #{sno}")
    public void studyYnUpdate(Study study) throws Exception;

    @Update("UPDATE study SET canYn = TRUE WHERE sno = #{sno}")
    public void studyCanYnUpdate(Study study) throws Exception;

}