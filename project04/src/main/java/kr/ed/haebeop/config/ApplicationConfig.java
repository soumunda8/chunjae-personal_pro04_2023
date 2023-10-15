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

    @Bean
    public MemberService memberService() {return new MemberServiceImpl();}

    @Bean
    public BoardMgnService boardMgnService() {return new BoardMgnServiceImpl();}

    @Bean
    public FilesService filesService() {return new FilesServiceImpl();}

    @Bean
    public CommentService commentService() {return new CommentServiceImpl();}

    @Bean
    public LectureService lectureService() {return new LectureServiceImpl();}

}