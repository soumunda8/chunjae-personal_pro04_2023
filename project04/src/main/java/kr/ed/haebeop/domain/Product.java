package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {

    private int proNo;
    private String proNm;
    private int proPrice;
    private String resDate;

}