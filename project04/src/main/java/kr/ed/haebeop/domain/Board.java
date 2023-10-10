package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {

    private int bno;
    private int boardType;
    private String title;
    private String content;
    private String author;
    private String resDate;
    private int visited;

}