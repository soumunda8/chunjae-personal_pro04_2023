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
                                <h5 class="m-b-10">제품 내역</h5>
                            </div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${path }/admin/"><i class="feather icon-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="#!" onclick="return false;">제품 설정</a></li>
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
                            <h5>제품 상세보기</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label" for="proNm">제품 이름</label>
                                        <input type="text" class="form-control" name="proNm" id="proNm" value="${product.proNm }" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label" for="proPrice">제품 가격</label>
                                        <input type="text" class="form-control" name="proPrice" id="proPrice" value="<fmt:formatNumber value="${product.proPrice }" pattern="#,###" /> 원" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label" for="proPrice">제품 썸네일</label>
                                        <c:forEach var="files" items="${fileList }">
                                            <img src="${path }/resources/upload/${files.saveFolder }/${files.saveNm }" alt="${files.originNm }" class="ml-5" />
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row justify-content-md-end">
                <div class="col-md-4">
                    <a href="${path }/admin/productConf.do" class="btn btn-primary" style="width:32%;">목록</a>
                    <a href="${path }/admin/productEdit.do?no=${product.proNo }" class="btn btn-success" style="width:32%;">수정</a>
                    <a href="${path }/admin/productDel.do?no=${product.proNo }" class="btn btn-primary" style="width:32%;">삭제</a>
                </div>
            </div>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
</body>
</html>