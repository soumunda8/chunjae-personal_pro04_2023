package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Category;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CategoryMapper {

    @Select("SELECT * FROM category ORDER BY cateNo ASC")
    public List<Category> categoryList() throws Exception;

    @Select("SELECT * FROM category WHERE cateNo LIKE concat(#{keyword}, '%') ORDER BY cateNo ASC")
    public List<Category> categoryKeywordList(String keyword) throws Exception;

    @Select("SELECT * FROM category WHERE cateNo = #{cateNo}")
    public Category categoryGet(String cateNo) throws Exception;

    @Insert("INSERT INTO category VALUES(#{cateNo}, #{cName})")
    public void categoryInsert(Category category) throws Exception;

    @Update("UPDATE category SET cName = #{cName} WHERE cateNo = #{cateNo}")
    public void categoryUpdate(Category category) throws Exception;

    @Delete("DELETE FROM category WHERE cateNo = #{cateNo}")
    public void categoryDelete(String cateNo) throws Exception;

}