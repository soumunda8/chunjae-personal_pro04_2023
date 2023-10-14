package kr.ed.haebeop.domain;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FileDTO {

    private int fno;
    private int par;
    private String saveFolder;
    private String originNm;
    private String saveNm;
    private String fileType;
    private String uploadDate;

}