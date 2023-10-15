package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Serve {
    
    private int sno;
    private int prono;
    private int amount;
    private int sPrice;
    private String resDate;

}