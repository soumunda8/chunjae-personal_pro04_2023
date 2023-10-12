<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::로그인</title>
    <jsp:include page="../layout/head.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/sub.css">
</head>
<body>
<section class="bg-image join_area my-5">
    <div class="mask d-flex align-items-center">
        <div class="container h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                    <div class="card">
                        <div class="card-body p-5">

                            <a class="logo text-center font-weight-bold text-secondary" href="${path }/" style="font-size:35px;"><img src="${path }/resources/image/common/logo.png" title="해법 로고" alt="해법 로고" />HAEBEOP</a>

                            <h2 class="text-uppercase text-center mt-3 mb-5">로그인</h2>

                            <form name="frm1" id="frm1" action="${path }/user/loginPro.do" method="post">

                                <div class="form-outline mb-4">
                                    <input type="text" name="id" id="id" placeholder="아이디 입력" class="form-control" autofocus required />
                                    <label class="form-label blind" for="id">아이디</label>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="password" name="pw" id="pw" placeholder="비밀번호 입력" class="form-control" required />
                                    <label class="form-label blind" for="pw">비밀번호</label>
                                </div>

                                <c:if test="${msg eq 'fail' }">
                                    <div class="d-flex justify-content-md-center align-items-center">
                                        <p class="login_err text-danger"><i class="fas fa-exclamation-circle"></i> 아이디나 비밀번호가 맞지 않습니다.</p>
                                    </div>
                                </c:if>

                                <div class="d-flex justify-content-center">
                                    <button type="submit" class="btn px-3">로그인하기</button>
                                </div>

                                <div class="d-flex justify-content-center mt-1">
                                    <p class="small fw-bold my-0">회원이 아니신가요? <a href="${path }/user/term.do" class="link-danger">회원가입</a></p>
                                </div>

                            </form>

                            <script src="${path }/resources/js/jquery-3.7.1.min.js"></script>
                            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
                            <script src="${path }/resources/js/common.js"></script>
                            <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>