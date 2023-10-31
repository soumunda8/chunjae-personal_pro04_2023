package kr.ed.haebeop.util;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        String sid = (String) session.getAttribute("sid");
        String uri = request.getRequestURI().toLowerCase();

        boolean flag = false;
        if(uri.contains("admin")){
            if(sid==null || !sid.equals("admin")){flag = true;}
        }

        if(flag){
            request.setAttribute("msg", "관리자만 이용 가능합니다.");
            request.setAttribute("url", "/");
            RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/layout/alert.jsp");
            view.forward(request, response);
            return false;
        }
        return true;
    }
}
