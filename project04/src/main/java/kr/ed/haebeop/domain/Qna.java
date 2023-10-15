package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Qna {

    private int qno;
    private String title;
    private String content;
    private String answer;
    private String author;
    private String resDate;
    private String answerDate;
    private boolean answerYn;

}