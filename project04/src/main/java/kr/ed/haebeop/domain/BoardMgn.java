package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardMgn {

    private int bmNo;
    private String boardNm;
    private int aboutAuth;
    private boolean commentUse = false;
    private boolean fileUse = false;

}