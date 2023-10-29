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
                                <h5 class="m-b-10">카테고리 내역</h5>
                            </div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${path }/admin/"><i class="feather icon-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="#!" onclick="return false;">카테고리 설정</a></li>
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
                            <h5>카테고리 내역</h5>
                        </div>
                        <c:if test="${not empty categoryList }">
                            <div class="card-body table-border-style">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th class="text-center">#</th>
                                            <th class="text-center">카테고리 이름</th>
                                            <th class="text-center">비고</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${categoryList }" var="category" varStatus="status">
                                            <tr>
                                                <td class="text-center">${status.count }</td>
                                                <td class="text-center"><a href="${path }/admin/getCategory.do?no=${category.cateNo }">${category.CName }</a></td>
                                                <td class="text-center"></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${empty categoryList }">
                            <p class="f-18 f-w-600 text-center mt-3">등록된 카테고리가 없습니다.</p>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="row justify-content-md-end">
                <div class="col-md-1">
                    <a href="${path }/admin/categoryAdd.do" class="btn btn-primary" style="width:100%;">등록</a>
                </div>
            </div>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
</body>
</html>