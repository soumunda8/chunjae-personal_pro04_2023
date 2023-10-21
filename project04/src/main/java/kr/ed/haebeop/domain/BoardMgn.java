package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardMgn {

    private int bmNo;
    private int boardType;
    private String boardNm;
    private int depth;
    private int par = 0;
    private String parNm = "";
    private int aboutAuth;
    private boolean commentUse = false;
    private boolean fileUse = false;

}