<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::마이페이지</title>
    <jsp:include page="../layout/head.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/sub.css">
</head>
<body class="myPage">
    <jsp:include page="../layout/header.jsp" />

    <div class="container-fluid">
        <div class="row justify-content-md-center my-5">
            <div class="col-8">
                <div class="row">
                    <div class="col-2 p-2">
                        <div class="d-flex flex-column align-items-center justify-content-center border left_side">
                            <div class="left_top">
                                <p>마이페이지</p>
                            </div>
                            <ul class="my-2" style="width:100%;">
                                <li><a href="${path }/user/myPage.do" class="active px-4 py-2">나의 정보</a></li>
                                <li><a href="${path }/user/mypageLectList.do" class="px-4 py-2">나의 강의실</a></li>
                                <li><a href="${path }/user/mypagePaylistMem.do" class="px-4 py-2">나의 결제정보</a></li>
                                <li><a href="${path }/academy/mypageReservation.do" class="px-4 py-2">나의 예약정보</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-10 p-2">
                        <div class="d-flex flex-column align-items-center justify-content-center right_side">
                            <h5 class="my-4" style="font-size:2.5em;font-weight:600;">선생님 신청하기</h5>
                            <form action="${path }/user/mypageChangeGrade.do" method="post" style="width:100%;" enctype="multipart/form-data">
                                <div class="container px-5">
                                    <table class="table table-bordered mx-3">
                                        <colgroup>
                                            <col style="width:20%;">
                                            <col style="width:auto;">
                                        </colgroup>
                                        <c:if test="${showFailContent }">
                                            <thead>
                                            <th class="text-center" colspan="2"><p style="color:var(--danger);">[취소 사유]</p> ${memberMgnVO.content }</th>
                                            </thead>
                                        </c:if>
                                        <tbody>
                                        <tr>
                                            <th class="text-center">이름</th>
                                            <td>${member.nm }</td>
                                        </tr>
                                        <tr>
                                            <th class="text-center">아이디</th>
                                            <td>${member.id }</td>
                                        </tr>
                                        <c:if test="${empty memberMgnVO }">
                                        <tr>
                                            <th class="text-center">사진 등록하기</th>
                                            <td>
                                                <input type="file" class="form-control uploadFiles" name="uploadFiles" accept="image/*" multiple required>
                                            </td>
                                        </tr>
                                        </c:if>
                                        <tr>
                                            <th class="text-center">관련 서류 등록하기</th>
                                            <td>
                                                <input type="file" class="form-control uploadFiles" name="uploadFiles" accept="application/pdf" multiple required>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <a href="${path }/user/myPage.do" class="btn btn-primary px-5 py-2 my-4 mr-2">취소</a>
                                    <button type="submit" class="btn btn-success px-5 py-2 my-4">신청하기</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>