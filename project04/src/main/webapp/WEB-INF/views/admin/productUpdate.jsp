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
            <form action="${path }/admin/productEdit.do" name="frm1" method="post" enctype="multipart/form-data">
                <input type="hidden" name="proNo" id="proNo" value="${product.proNo }" />
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card">
                            <div class="card-header">
                                <h5>제품 수정</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label" for="proNm">제품 이름</label>
                                            <input type="text" class="form-control" name="proNm" id="proNm" placeholder="제품 이름을 입력하세요." value="${product.proNm }" aria-describedby="제품 이름 도움" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label" for="proPrice">제품 가격</label>
                                            <input type="number" class="form-control" name="proPrice" id="proPrice" placeholder="제품 가격을 입력하세요." value="${product.proPrice }" aria-describedby="제품 가격 도움" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">제품 썸네일 업로드(10MB 이하)</label>
                                            <c:forEach var="files" items="${fileList }">
                                                <p id="files">${files.originNm } <button type="button" class="btn btn-primary px-2 py-0 ml-2" onclick="removeFiles(${files.fno })" style="font-size:0.8rem;">삭제</button></p>
                                            </c:forEach>
                                            <input type="file" class="form-control uploadThumbnail" name="uploadThumbnail" id="uploadThumbnail" multiple required>
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
                        <a href="${path }/admin/productConf.do" class="btn btn-success" style="width:45%;">목록</a>
                    </div>
                </div>
            </form>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
    <script>
        function removeFiles(fno) {
            if(!confirm("해당 파일을 삭제하시겠습니까?")) {return false;}

            let params = {"fno" : fno};
            $.ajax({
                url:"${path }/util/fileRemove.do",
                type:"post",
                data:JSON.stringify(params),
                dataType:"json",
                contentType:"application/json",
                success : function(result) {
                    if(result === true) {
                        $("#files").remove();
                    }
                },
            });
        }
    </script>
</body>
</html>