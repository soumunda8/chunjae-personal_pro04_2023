package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Lecture {

    private int lno;
    private String title;
    private String subTitle;
    private String content;
    private int lectureType;
    private int studentCnt;
    private String startDate;
    private String endDate;
    private String daily;
    private int proNo;
    private String cateNo;
    private String teacherId;
    private int lPrice;
    private boolean useYn;

}