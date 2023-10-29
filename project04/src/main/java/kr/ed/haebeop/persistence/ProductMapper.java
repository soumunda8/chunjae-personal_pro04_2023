package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Product;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ProductMapper {

    @Select("SELECT * FROM product")
    public List<Product> productList() throws Exception;

    @Select("SELECT * FROM product WHERE proNo = #{proNo}")
    public Product productGet(int proNo) throws Exception;

    @Select("SELECT * FROM product ORDER BY resDate DESC LIMIT 1")
    public Product productLast() throws Exception;

    @Insert("INSERT INTO product VALUES(DEFAULT, #{proNm}, #{proPrice}, DEFAULT)")
    public void productInsert(Product product) throws Exception;

    @Update("UPDATE product SET proNm = #{proNm}, proPrice = #{proPrice} WHERE proNo = #{proNo}")
    public void productUpdate(Product product) throws Exception;

    @Delete("DELETE FROM product WHERE proNo = #{proNo}")
    public void productDelete(int proNo) throws Exception;

}