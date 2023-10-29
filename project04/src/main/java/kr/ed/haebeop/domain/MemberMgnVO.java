package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberMgnVO {

    private int mmNo;
    private String author;
    private boolean approveYn;
    private int mStatus;
    private int fno = 0;
    private String content;
    private String nm;

}