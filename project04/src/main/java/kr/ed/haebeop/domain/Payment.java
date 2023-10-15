package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Payment {

    private int payno;
    private String author;
    private int sno;
    private int amount;
    private String pMethod;
    private String pCom;
    private String pNum;
    private int payPrice;
    private int payStatus;
    private int dno;
    private String resDate;

}