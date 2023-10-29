<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <jsp:include page="../layout/adminHead.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/admin.css" />
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
            <form action="${path }/admin/categoryEdit.do" name="frm1" method="post">
                <input type="hidden" name="cateNo" id="cateNo" value="${category.cateNo}" />
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card">
                            <div class="card-header">
                                <h5>카테고리 수정</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label" for="cName">카테고리 이름</label>
                                            <input type="text" class="form-control" name="cName" id="cName" placeholder="카테고리 이름을 입력하세요." value="${category.CName }" aria-describedby="카테고리 이름 도움" required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-md-end">
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-primary" style="width:45%;">수정</button>
                        <a href="${path }/admin/categoryConf.do" class="btn btn-success" style="width:45%;">목록</a>
                    </div>
                </div>
            </form>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
</body>
</html>