package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.FileDTO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface FilesMapper {

    @Select("SELECT * FROM files WHERE par = #{par}")
    public List<FileDTO> fileListByPar(int par) throws Exception;

    @Select("SELECT * FROM files WHERE fno = #{fno}")
    public FileDTO fileListByFno(int par) throws Exception;

    @Insert("INSERT INTO files VALUES (DEFAULT, #{par}, #{saveFolder}, #{originNm}, #{saveNm}, #{fileType}, DEFAULT)")
    public void filesInsert(FileDTO fileDTO) throws Exception;

}