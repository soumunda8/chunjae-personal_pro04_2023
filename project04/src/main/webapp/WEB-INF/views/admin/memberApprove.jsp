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
                                <h5 class="m-b-10">회원 등급 승인 관리</h5>
                            </div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${path }/admin/"><i class="feather icon-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="#!" onclick="return false;">회원 등급 승인 관리</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- [ breadcrumb ] end -->
            <!-- [ Main Content ] start -->
            <div class="row">
                <div class="col-xl-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>회원 내역</h5>
                        </div>
                        <c:if test="${!empty memberList }">
                            <div class="card-body table-border-style">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th class="text-center">#</th>
                                            <th class="text-center">아이디</th>
                                            <th class="text-center">이름</th>
                                            <th class="text-center">승인 여부</th>
                                            <th class="text-center">첨부 파일</th>
                                            <th class="text-center">비고</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${memberList }" var="member" varStatus="status">
                                            <tr>
                                                <td class="text-center">${status.count }</td>
                                                <td class="text-center">${member.id }</td>
                                                <td class="text-center">${member.nm }</td>
                                                <td class="text-center">
                                                    미승인
                                                    <%--<c:if test="${member.approveYn == true}">승인</c:if>
                                                    <c:if test="${member.approveYn == false}">미승인</c:if>--%>
                                                </td>
                                                <td class="text-center"><i class="far fa-file-alt"></i></td>
                                                <td class="text-center">
                                                    <c:if test="${member.useYn == true}">
                                                        <div class="buttons are-small is-centered">
                                                            <a href="${path }/user/deletePro.do?id=${member.id }" class="btn btn-primary btn-sm">회원탈퇴</a>
                                                        </div>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${empty memberList }">
                            <p class="f-18 f-w-600 text-center mt-3">가입한 회원이 없습니다.</p>
                        </c:if>
                    </div>
                </div>


            </div>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
</body>
</html>