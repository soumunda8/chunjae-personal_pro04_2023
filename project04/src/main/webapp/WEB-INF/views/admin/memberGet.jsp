<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP</title>
    <jsp:include page="../layout/adminHead.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/admin.css" />
    <link rel="stylesheet" href="${path }/resources/css/owl.carousel.css" />
</head>
<body>
<jsp:include page="../layout/adminHeader.jsp" />
<div class="pcoded-main-container">
    <div class="pcoded-content">
        <!-- [ breadcrumb ] start -->
        <div class="page-header">
            <div class="page-block">
                <div class="row align-items-center">
                    <div class="col-md-12">
                        <div class="page-header-title">
                            <h5 class="m-b-10">회원</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${path }/admin/"><i class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item"><a href="#!" onclick="return false;">회원</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- [ breadcrumb ] end -->
          <div class="row">
            <div class="col-xl-12">
                <div class="card">
                    <div class="card-header">
                        <h5>회원 내역</h5>
                    </div>
                        <div class="card-body table-border-style">

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
                                            </c:choose> - <c:if test="${checkTeacher eq 'ing' }"><span style="color:var(--main-color);">선생님 신청 진행 중</span></c:if><c:if test="${checkTeacher eq 'fail' || checkTeacher eq 'noApply' }"><a href="${path }/user/mypageChangeGrade.do">선생님 신청하기</a></c:if>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                </div>
            </div>


        </div>
        <!-- [ Main Content ] end -->
    </div>
</div>
<jsp:include page="../layout/adminFooter.jsp" />
</body>
</html>