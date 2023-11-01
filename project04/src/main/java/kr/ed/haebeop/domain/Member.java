package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {

    private int mno;
    private String id;
    private String pw;
    private String nm;
    private String email;
    private String tel;
    private String addr1;
    private String addr2;
    private String postcode;
    private String regDate;
    private String birth;
    private int pt;
    private int visited;
    private boolean useYn;
    private int grade = 2;
    private String fileNm = "";
    private String saveFolder = "";

}