<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>에러</title>
    <jsp:include page="../../layout/head.jsp" />
    <style>
        html,body {overflow:hidden;}
        body {background-image:url(${path }/resources/image/common/error.png);background-position:center center;position:relative;background-repeat:no-repeat;background-size:contain;}
        a {position:absolute;top:80%;left:50%;width:200px;margin-left:-100px;text-align:center;padding:20px 0;background-color:var(--main-color);color:#fff;font-size:20px;font-weight:600;border-radius:30px;}
    </style>
</head>
<body>
<a href="${path }/">홈으로</a>
</body>
</html>