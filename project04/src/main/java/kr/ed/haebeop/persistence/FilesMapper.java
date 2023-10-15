package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.FileDTO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface FilesMapper {

    @Select("SELECT * FROM files WHERE par = #{par} and toUse = #{toUse}")
    public List<FileDTO> fileListByPar(FileDTO fileDTO) throws Exception;

    @Select("SELECT * FROM files WHERE fno = #{fno}")
    public FileDTO fileByFno(int fno) throws Exception;

    @Insert("INSERT INTO files VALUES (DEFAULT, #{par}, #{saveFolder}, #{originNm}, #{saveNm}, #{fileType}, DEFAULT, #{toUse})")
    public void filesInsert(FileDTO fileDTO) throws Exception;

    @Update("UPDATE files SET par = #{par}, toUse = #{toUse} WHERE fno = #{fno}")
    public void filesUpdateForTeacher(FileDTO fileDTO) throws Exception;

    @Delete("DELETE FROM files WHERE fno = #{fno}")
    public void filesDelete(int fno) throws Exception;

    @Delete("DELETE FROM files WHERE par = #{par}")
    public void filesDeleteAll(int par) throws Exception;

}