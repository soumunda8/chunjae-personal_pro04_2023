<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<div class="container-fluid bg-secondary text-white py-3 px-sm-3 px-md-5">
    <div class="container-fluid text-center">
        <ul class="btn-group">
            <li class="col-auto"><a class="text-white mb-2" href="#">회원약관</a></li>
            <li class="col-auto"><a class="text-white mb-2" href="#">개인정보처리방침</a></li>
            <li class="col-auto"><a class="text-white mb-2" href="#">이메일수집거부</a></li>
            <li class="col-auto"><a class="text-white mb-2" href="#">고객센터</a></li>
        </ul>
    </div>
    <div class="container-fluid" style="border-top: 1px solid rgba(23, 162, 184, 0.2) ;">
        <p class="m-0 text-center text-white pt-3">©
            <a class="text-primary font-weight-bold" href="#">Haebeop</a> .All Rights Reserved. Designed by
            <a class="text-primary font-weight-bold" href="https://htmlcodex.com">HTML Codex</a>
            <br>Distributed By: <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
        </p>
    </div>
</div>
<a href="#" class="btn btn-primary p-3 back-to-top"><i class="fa fa-angle-double-up"></i></a>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${path }/resources/js/common.js"></script>