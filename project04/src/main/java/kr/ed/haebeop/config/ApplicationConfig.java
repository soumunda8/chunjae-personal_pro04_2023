package kr.ed.haebeop.config;

import kr.ed.haebeop.service.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan(basePackages = "kr.ed.haebeop")
public class ApplicationConfig {

    @Bean
    public BoardService boardService() {return new BoardServiceImpl();}

    public MemberService memberService() {return new MemberServiceImpl();}

    public BoardMgnService boardMgnService() {return new BoardMgnServiceImpl();}

}