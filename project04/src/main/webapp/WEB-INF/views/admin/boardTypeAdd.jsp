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
                                <h5 class="m-b-10">게시판 등록</h5>
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
            <form action="${path }/admin/boardMgnAdd.do" method="post">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card">
                            <div class="card-header">
                                <h5>게시판 등록</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label" for="boardNm">게시판 이름</label>
                                            <input type="text" class="form-control" name="boardNm" id="boardNm" aria-describedby="게시판 이름 도움" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">게시판 글 설정</label>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="aboutAuth1" name="aboutAuth" class="custom-control-input" value="0">
                                                <label class="custom-control-label" for="aboutAuth1">관리자</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="aboutAuth2" name="aboutAuth" class="custom-control-input" value="2">
                                                <label class="custom-control-label" for="aboutAuth2">회원</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">댓글 설정</label>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="commentUse1" name="commentUse" class="custom-control-input" value="true">
                                                <label class="custom-control-label" for="commentUse1">사용</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="commentUse2" name="commentUse" class="custom-control-input" value="false">
                                                <label class="custom-control-label" for="commentUse2">사용안함</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">파일 설정</label>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="fileUse1" name="fileUse" class="custom-control-input" value="true">
                                                <label class="custom-control-label" for="fileUse1">사용</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="fileUse2" name="fileUse" class="custom-control-input" value="false">
                                                <label class="custom-control-label" for="fileUse2">사용안함</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-md-end">
                    <div class="col-md-1">
                        <button type="submit" class="btn btn-primary" style="width:100%;">등록</button>
                    </div>
                </div>
            </form>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
</body>
</html>