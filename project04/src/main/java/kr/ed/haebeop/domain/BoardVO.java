package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardVO {

    private int bno;
    private int bmNo;
    private String title;
    private String content;
    private String author;
    private String resDate;
    private String answer;
    private String answerDate;
    private boolean answerYn;
    private int visited;
    private int boardType;
    private String boardNm;
    private String nm;
    private int aboutAuth;
    private boolean commentUse;
    private boolean fileUse;

}