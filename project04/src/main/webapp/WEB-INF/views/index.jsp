<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="./layout/head.jsp" />
    <title>해법</title>
    <link rel="stylesheet" href="${path }/resources/css/main.css">
</head>
<body>
<jsp:include page="./layout/header.jsp" />
<section class="hero is-large is-info">
    <div class="container is-fullhd">
        <div class="hero-body">
            <p class="title">${title }</p>
            <p class="subtitle">${titleSub }</p>
        </div>
    </div>
</section>
<div class="container is-fullhd">
    <h2>${title }</h2>
    <div class="contents">
        이름 : ${name }
        <hr>
        현재 : ${today }
    </div>
</div>
<jsp:include page="./layout/footer.jsp" />
</body>
</html>