package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Payment {

    private int payNo;
    private String author;
    private int sno;
    private String pMethod;
    private String pCom;
    private String pNum;
    private int payPrice;
    private int payStatus;
    private int dno;
    private String resDate;

}