package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {

    private int bno;
    private int bmNo;
    private String title;
    private String content;
    private String author;
    private String resDate;
    private String answerAuthor;
    private String answer;
    private String answerDate;
    private boolean answerYn;
    private int visited;

}