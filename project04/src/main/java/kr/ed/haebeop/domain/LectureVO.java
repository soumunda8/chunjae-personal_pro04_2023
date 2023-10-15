package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LectureVO {

    private int lno;
    private String title;
    private String subTitle;
    private String content;
    private int lectureType;
    private int studentCnt;
    private String startDate;
    private String endDate;
    private String daily;
    private int prono;
    private String teacherId;
    private int thumbnail;
    private boolean useYn;
    private String nm;

}