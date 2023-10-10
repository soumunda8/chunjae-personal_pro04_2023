package kr.ed.haebeop.config;

import kr.ed.haebeop.service.BoardService;
import kr.ed.haebeop.service.BoardServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan(basePackages = "kr.ed.haebeop")
public class ApplicationConfig {

    @Bean
    public BoardService boardService() {return new BoardServiceImpl();}

}