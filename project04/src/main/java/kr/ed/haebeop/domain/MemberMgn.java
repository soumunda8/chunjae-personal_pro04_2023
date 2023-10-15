package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberMgn {

    private int mmNo;
    private String author;
    private boolean approveYn;
    private String content;

}