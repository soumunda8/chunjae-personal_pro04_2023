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
                                <h5 class="m-b-10">게시판 상세보기</h5>
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
                            <h5>게시판 상세보기</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block">게시판 타입 설정</label>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="boardType0" name="boardType" class="custom-control-input" value="0" onclick="return false" <c:if test="${boardMgn.boardType == 0 }">checked</c:if>>
                                            <label class="custom-control-label" for="boardType0">게시판</label>
                                        </div>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="boardType1" name="boardType" class="custom-control-input" value="1" onclick="return false" <c:if test="${boardMgn.boardType == 1 }">checked</c:if>>
                                            <label class="custom-control-label" for="boardType1">문의하기</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label" for="boardNm">게시판 이름</label>
                                        <input type="text" class="form-control" name="boardNm" id="boardNm" value="${boardMgn.boardNm }" aria-describedby="게시판 이름 도움" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block">게시판 뎁스</label>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="depth0" name="depth" class="custom-control-input" value="1" onclick="return false"<c:if test="${boardMgn.depth == 1 }"> checked</c:if>>
                                            <label class="custom-control-label" for="depth0">메인</label>
                                        </div>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="depth1" name="depth" class="custom-control-input" value="2" onclick="return false"<c:if test="${boardMgn.depth == 2 }"> checked</c:if>>
                                            <label class="custom-control-label" for="depth1">서브</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${boardMgn.depth == 2 }">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block" for="parNm">게시판 사용 강의 아이디</label>
                                        <input type="text" class="form-control d-inline-block" name="parNm" id="parNm" value="${boardMgn.parNm }" readonly>
                                    </div>
                                </div>
                            </div>
                            </c:if>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block">게시판 글 설정</label>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="aboutAuth0" name="aboutAuth" class="custom-control-input" value="0" onclick="return false" <c:if test="${boardMgn.aboutAuth == 0 }">checked</c:if>>
                                            <label class="custom-control-label" for="aboutAuth0" onclick="return false">관리자</label>
                                        </div>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="aboutAuth1" name="aboutAuth" class="custom-control-input" value="1" onclick="return false" <c:if test="${boardMgn.aboutAuth == 1 }">checked</c:if>>
                                            <label class="custom-control-label" for="aboutAuth1" onclick="return false">선생님</label>
                                        </div>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="aboutAuth2" name="aboutAuth" class="custom-control-input" value="2" onclick="return false" <c:if test="${boardMgn.aboutAuth == 2 }">checked</c:if>>
                                            <label class="custom-control-label" for="aboutAuth2" onclick="return false">회원</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block">댓글 설정</label>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="commentUse1" name="commentUse" class="custom-control-input" value="true" onclick="return false" <c:if test="${boardMgn.commentUse }">checked</c:if>>
                                            <label class="custom-control-label" for="commentUse1" onclick="return false">사용</label>
                                        </div>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="commentUse2" name="commentUse" class="custom-control-input" value="false" onclick="return false" <c:if test="${!boardMgn.commentUse }">checked</c:if>>
                                            <label class="custom-control-label" for="commentUse2" onclick="return false">사용안함</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block">파일 설정</label>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="fileUse1" name="fileUse" class="custom-control-input" value="true" onclick="return false" <c:if test="${boardMgn.fileUse }">checked</c:if>>
                                            <label class="custom-control-label" for="fileUse1" onclick="return false">사용</label>
                                        </div>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="fileUse2" name="fileUse" class="custom-control-input" value="false" onclick="return false" <c:if test="${!boardMgn.fileUse }">checked</c:if>>
                                            <label class="custom-control-label" for="fileUse2" onclick="return false">사용안함</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row justify-content-md-end">
                <div class="col-md-2 text-right">
                    <a href="${path }/admin/boardMgnDel.do?no=${boardMgn.bmNo }" class="btn btn-primary d-inline-block">삭제</a>
                    <a href="${path }/admin/boardMgnModify.do?no=${boardMgn.bmNo }" class="btn btn-success d-inline-block ml-2">수정</a>
                </div>
            </div>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
</body>
</html>