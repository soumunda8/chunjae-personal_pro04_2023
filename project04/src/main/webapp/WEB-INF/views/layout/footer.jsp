<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<footer id="footerArea" class="footer">
    <div class="ft_top">
        <div class="inner">
            <nav class="ft_link inner">
                <ul class="fnb">
                    <li><a href="#">개인정보취급방침</a></li>
                    <li><a href="#">이메일무단수집거부</a></li>
                    <li><a href="#">오시는길</a></li>
                </ul>
            </nav>
        </div>
    </div>
    <div class="ft_con">
        <div class="inner">
            <div class="ft_list">
                <ul class="ft_list">
                    <li>해법</li>
                    <li>소재지 : 서울시 금천구 가산로9길 54</li>
                </ul>
                <ul class="ft_list">
                    <li>대표전화 : XXX-XXX-XXXX</li>
                    <li>FAX : XXX-XXX-XXXX</li>
                    <li>e-mail : admin@haebeop.ed.kr</li>
                </ul>
                <p class="cp">COPYRIGHT ©2023 HAEBEOP. ALL RIGHTS RESERVED.</p>
            </div>
            <div class="ft_logo">
                <img src="${path }/resources/image/common/logo_ft.png" alt="해법 푸터 로고"><p>해법</p>
            </div>
        </div>
    </div>
</footer>