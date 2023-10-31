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
                                <li><a href="${path }/user/myPageLectList.do" class="px-4 py-2">나의 강의실</a></li>
                                <li><a href="${path }/user/myPagePaylistMem.do" class="px-4 py-2">나의 결제정보</a></li>
                                <li><a href="${path }/academy/myPageReservation.do" class="px-4 py-2">나의 예약정보</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-10 p-2">
                        <div class="d-flex flex-column align-items-center justify-content-center right_side">
                            <h5 class="my-4" style="font-size:2.5em;font-weight:600;">회원정보</h5>

                            <div class="container px-5">
                                <table class="table table-bordered mx-3">
                                    <colgroup>
                                        <col style="width:20%;">
                                        <col style="width:auto;">
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th class="text-center">이름</th>
                                        <td>${member.nm }</td>
                                    </tr>
                                    <tr>
                                        <th class="text-center">아이디</th>
                                        <td>${member.id }</td>
                                    </tr>
                                    <tr>
                                        <th class="text-center">비밀번호</th>
                                        <td><c:if test="${sid ne 'admin'}"><a href="${path }/user/myPageChangePw.do?id=${member.id }">비밀번호 변경</a></c:if></td>
                                    </tr>
                                    <tr>
                                        <th class="text-center">이메일</th>
                                        <td>${member.email }</td>
                                    </tr>
                                    <tr>
                                        <th class="text-center">전화번호</th>
                                        <td>${member.tel }</td>
                                    </tr>
                                    <tr>
                                        <th class="text-center">주소</th>
                                        <td>[${member.postcode }] ${member.addr1} ${member.addr2}</td>
                                    </tr>
                                    <tr>
                                        <th class="text-center">생일</th>
                                        <td>${member.birth }</td>
                                    </tr>
                                    <tr>
                                        <th class="text-center">포인트</th>
                                        <td>${member.pt }</td>
                                    </tr>
                                    <tr>
                                        <th class="text-center">등급</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${member.grade == 1 }">선생님</c:when>
                                                <c:when test="${member.grade == 2 }">회원</c:when>
                                                <c:otherwise>관리자</c:otherwise>
                                            </c:choose>
                                            <c:if test="${member.grade == 2 }"> -
                                                <c:if test="${!canUpgrade }"><span style="color:var(--main-color);">선생님 신청 진행 중</span></c:if>
                                                <c:if test="${canUpgrade }"><a href="${path }/user/myPageChangeGrade.do">선생님 신청하기</a></c:if>
                                            </c:if>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-end">
                                <a href="${path }/user/myPageEdit.do" class="btn btn-primary px-3 py-2 my-4 mr-2">수정하기</a>
                                <c:if test="${sid ne 'admin'}"><a href="${path }/user/myPageRemoveUser.do?id=${sid }" class="btn btn-success px-3 py-2 my-4">탈퇴하기</a></c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <jsp:include page="../layout/footer.jsp" />
    <script>
        <c:if test="${msg eq 'pwSuccess'}">
        alert("비밀번호가 성공적으로 변경되었습니다.");
        </c:if>
    </script>
</body>
</html>