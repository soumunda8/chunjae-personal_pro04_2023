package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Payment;
import kr.ed.haebeop.domain.PaymentVO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface PaymentMapper {

    @Select("SELECT * FROM studyPayList ORDER BY dStatus ASC")
    public List<PaymentVO> paymentList() throws Exception;

    @Select("SELECT * FROM studyPayList WHERE author = #{author} ORDER BY dStatus ASC")
    public PaymentVO paymentGet(String author) throws Exception;
        
    // 구매 확정 추후 추가 예정 [ 1 -> DEFAULT ]
    @Insert("INSERT INTO payment VALUES(DEFAULT, #{author}, #{sno}, #{pMethod}, #{pCom}, #{pNum}, #{payPrice}, 1, #{dno}, DEFAULT)")
    public void paymentInsert(Payment payment) throws Exception;

    @Update("UPDATE payment SET payStatus = 1 WHERE payNo = #{payNo}")
    public void paymentStatusUpdate(int payNo) throws Exception;

}