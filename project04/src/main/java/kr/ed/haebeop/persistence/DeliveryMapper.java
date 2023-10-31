package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Delivery;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface DeliveryMapper {

    @Insert("INSERT INTO delivery VALUES(DEFAULT, #{cusNm}, #{cusTel}, #{cusAddr}, #{dTel}, DEFAULT, DEFAULT, NULL, #{dCode}, #{author})")
    public void deliveryInsert(Delivery delivery) throws Exception;

    @Select("SELECT * FROM delivery ORDER BY resDate DESC LIMIT 1")
    public Delivery deliveryLast() throws Exception;

    @Update("UPDATE delivery SET dStatus = #{dStatus} WHERE dno = #{dno}")
    public void deliveryStatusUpdate(Delivery delivery) throws Exception;

    @Update("UPDATE delivery SET deliveryDate = CURRENT_TIMESTAMP WHERE dno = #{dno}")
    public void deliveryDeliveryDateUpdate(int dno) throws Exception;


}