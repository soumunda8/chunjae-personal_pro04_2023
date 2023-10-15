package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Receive {

    private int rno;
    private int prono;
    private int amount;
    private int rPrice;
    private String resDate;

}