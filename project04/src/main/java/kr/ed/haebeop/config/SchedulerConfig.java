package kr.ed.haebeop.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

@Configuration
@EnableScheduling
public class SchedulerConfig {

    @Scheduled(cron = "0/10 * * * * *")
    public void test() {
        System.out.println("Hello, World");
    }

}