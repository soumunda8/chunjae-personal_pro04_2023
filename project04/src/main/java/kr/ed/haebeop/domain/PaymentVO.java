package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaymentVO {
    
    private int payNo;
    private String author;
    private int sno;
    private String pMethod;
    private String pCom;
    private String pNum;
    private int payPrice;
    private int payStatus;
    private String lectureTitle;
    private int dno;
    private String cusNm;
    private String cusTel;
    private String cusAddr;
    private String dTel;
    private String dStatus;
    private String resDate;          // 배송 등록일
    private String DeliveryDate;     // 배송 완료일
    private String dCode;

}