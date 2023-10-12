package kr.ed.haebeop.config;

import kr.ed.haebeop.service.BoardService;
import kr.ed.haebeop.service.BoardServiceImpl;
import kr.ed.haebeop.service.MemberService;
import kr.ed.haebeop.service.MemberServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan(basePackages = "kr.ed.haebeop")
public class ApplicationConfig {

    @Bean
    public BoardService boardService() {return new BoardServiceImpl();}

    public MemberService memberService() {return new MemberServiceImpl();}

}