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
                                <h5 class="m-b-10">게시판 설정</h5>
                            </div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${path }/admin/"><i class="feather icon-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="#!" onclick="return false;">게시판 설정</a></li>
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
                            <h5>게시판 내역</h5>
                        </div>
                        <c:if test="${!empty boardMgnList }">
                            <div class="card-body table-border-style">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th class="text-center">#</th>
                                            <th class="text-center">게시판 이름</th>
                                            <th class="text-center">게시판 설정</th>
                                            <th class="text-center">댓글 사용여부</th>
                                            <th class="text-center">파일 사용여부</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${boardMgnList }" var="boardMgn" varStatus="status">
                                            <tr>
                                                <td class="text-center">${status.count }</td>
                                                <td class="text-center">
                                                    <a href="${path }/admin/getBoardMgn.do?no=${boardMgn.bmNo }">
                                                    <c:choose>
                                                        <c:when test="${boardMgn.depth eq 1 }">[메인]</c:when>
                                                        <c:when test="${boardMgn.depth eq 2 }">[${boardMgn.parNm }]</c:when>
                                                    </c:choose>
                                                    ${boardMgn.boardNm }
                                                    </a>
                                                </td>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${boardMgn.aboutAuth == 0}">관리자</c:when>
                                                        <c:when test="${boardMgn.aboutAuth == 1}">선생님</c:when>
                                                        <c:otherwise>회원</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">
                                                    <c:if test="${boardMgn.commentUse == true}">사용중</c:if>
                                                    <c:if test="${boardMgn.commentUse == false}">사용안함</c:if>
                                                </td>
                                                <td class="text-center">
                                                    <c:if test="${boardMgn.fileUse == true}">사용중</c:if>
                                                    <c:if test="${boardMgn.fileUse == false}">사용안함</c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${curPage > page.pageCount }">
                                            <li class="page-item"><a class="page-link" href="${path }/admin/boardMgnConf.do?page=${page.blockStartNum - 1 }" aria-label="Previous"><span aria-hidden="true">«</span><span class="sr-only">Previous</span></a></li>
                                        </c:if>
                                        <c:forEach var="i" begin="${page.blockStartNum }" end="${page.blockLastNum }">
                                            <c:choose>
                                                <c:when test="${i == curPage }">
                                                    <li class="page-item active"><a class="page-link" href="${path }/admin/boardMgnConf.do?page=${i }">1</a></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="page-item"><a class="page-link" href="${path }/admin/boardMgnConf.do?page=${i }">1</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <c:if test="${page.blockLastNum < page.totalPageCount }">
                                            <li class="page-item"><a class="page-link" href="${path }/admin/boardMgnConf.do?page=${page.blockLastNum + 1 }" aria-label="Next"><span aria-hidden="true">»</span><span class="sr-only">Next</span></a></li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </c:if>
                        <c:if test="${empty boardMgnList }">
                            <p class="f-18 f-w-600 text-center mt-3">등록된 게시판이 없습니다.</p>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="row justify-content-md-end">
                <div class="col-md-1">
                    <a href="${path }/admin/boardMgnAdd.do" class="btn btn-primary" style="width:100%;">추가</a>
                </div>
            </div>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
</body>
</html>