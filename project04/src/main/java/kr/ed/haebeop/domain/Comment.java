package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment {

    private int cno;
    private String author;
    private String content;
    private String resDate;
    private int par;

}