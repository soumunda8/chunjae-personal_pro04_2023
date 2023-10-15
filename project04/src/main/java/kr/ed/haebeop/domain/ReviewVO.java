package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {

    private int rno;
    private int par;
    private String author;
    private String content;
    private int star;
    private String resDate;
    private String nm;

}