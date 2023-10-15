package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Delivery {

    private int dno;
    private String cusNm;
    private String cusTel;
    private String cusAddr;
    private String dTel;
    private int dStatus;
    private String resDate;
    private String DeliveryDate;
    private String dCode;
    private String author;

}