package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LectureList {

    private int llno;
    private int lno;
    private String title;
    private int totalTIme;
    private boolean studyYn;

}