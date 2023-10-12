<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::회원가입</title>
    <jsp:include page="../layout/head.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/sub.css">
</head>
<body>
<section class="bg-image join_finish my-5">
    <div class="mask d-flex align-items-center">
        <div class="container h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                    <div class="card">
                        <div class="card-body p-5">
                            <a class="logo text-center font-weight-bold text-secondary" href="${path }/" style="font-size:35px;"><img src="${path }/resources/image/common/logo.png" title="해법 로고" alt="해법 로고" />HAEBEOP</a>

                            <h2 class="text-uppercase text-center mt-3 mb-5">회원가입완료</h2>

                            <p class="text-center text-muted mt-4 mb-0">회원가입을 축하드립니다!</p>

                            <p class="text-center text-muted mt-4 mb-0">
                                <a href="${path }/">홈으로</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>