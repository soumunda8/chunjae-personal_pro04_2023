package kr.ed.haebeop.config;

import kr.ed.haebeop.exception.UncheckException;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.Filter;
import java.util.Properties;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "kr.ed.haebeop")
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[] {RootConfig.class, SecurityConfig.class};
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] {ServletContext.class};
    }

    @Override
    protected String[] getServletMappings() {
        return new String[] {"/"};
    }

    @Override
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        characterEncodingFilter.setForceEncoding(true);
        return new Filter[] { characterEncodingFilter };
    }

    @Bean
    public SimpleMappingExceptionResolver getExceptionResolver() {
        SimpleMappingExceptionResolver smer = new SimpleMappingExceptionResolver();
        smer.setDefaultErrorView("/common/error/error");
        smer.setDefaultStatusCode(200);
        smer.setExceptionAttribute("exception");
        smer.setExcludedExceptions(UncheckException.class);
        Properties mappings = new Properties();
        mappings.setProperty("kr.ed.haebeop.exception.DatabaseException", "/common/error/databaseError");
        mappings.setProperty("kr.ed.haebeop.exception.SecurityException", "/common/error/securityError");
        mappings.setProperty("kr.ed.haebeop.exception.BusinessException", "/common/error/businessError");
        mappings.setProperty("kr.ed.haebeop.exception.AjaxException", "/common/error/ajaxError");
        smer.setExceptionMappings(mappings);
        Properties statusCodes = new Properties();
        statusCodes.setProperty("/common/error/databaseError", "500");
        statusCodes.setProperty("/common/error/securityError", "403");
        statusCodes.setProperty("/common/error/businessError", "200");
        statusCodes.setProperty("/common/error/ajaxError", "200");
        smer.setStatusCodes(statusCodes);
        return smer;
    }

}