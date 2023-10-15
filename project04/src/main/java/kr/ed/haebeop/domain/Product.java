package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {

    private int prono;
    private String proNm;
    private int proPrice;
    private String proComment;
    private String proList;
    private int thumbnail;
    private boolean useyn;
    private String resDate;

}