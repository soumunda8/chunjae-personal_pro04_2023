package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Study {

    private int sno;
    private int lno;
    private String studentId;
    private boolean studyYn;
    private int totalTime;
    private boolean canYn;

}