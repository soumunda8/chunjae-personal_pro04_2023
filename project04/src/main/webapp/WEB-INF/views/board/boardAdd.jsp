<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::${boardMgn.boardNm }</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <jsp:include page="../layout/head.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/sub.css">
    <script type="text/javascript" src="${path }/resources/ckeditor/ckeditor.js"></script>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container-fluid bg-primary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 400px">
            <h3 class="display-3 font-weight-bold text-white">커뮤니티</h3>
            <div class="d-inline-flex text-white">
                <p class="m-0"><a class="text-white" href="${path }/">Home</a></p>
                <p class="m-0 px-2">/</p>
                <p class="m-0"><a class="text-white" href="${path }/board/list.do?no=1">커뮤니티</a></p>
                <p class="m-0 px-2">/</p>
                <p class="m-0">${boardMgn.boardNm }</p>
            </div>
        </div>
    </div>

    <div class="container-fluid mb-5">
        <form action="${path }/board/add.do" method="post" enctype="multipart/form-data">
            <div class="container">
                <h3 class="mb-5 text-center py-2">${boardMgn.boardNm } 등록</h3>
                <input type="hidden" name="no" value="${boardMgn.bmNo }" />

                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" class="form-control" name="title" id="title" required>
                </div>

                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea name="content" id="content" class="textarea" rows="8" cols="100" maxlength="1400" required></textarea>
                    <script>
                        CKEDITOR.replace('content',	{filebrowserUploadUrl:'${path }/util/imageUpload.do'});
                    </script>
                </div>

                <c:if test="${boardMgn.fileUse == true }">
                    <div class="form-group file_area">
                        <label>파일 업로드(10MB 이하) <span class="btn pt-0 px-0" onclick="addFile()">(<i class="fas fa-plus px-1"></i>)</span></label>
                        <input type="file" class="form-control uploadFiles" name="uploadFiles1" id="formFileMultiple" multiple>
                    </div>
                </c:if>

                <div class="btn-group d-block text-right mt-5">
                    <a href="${path }/board/list.do?no=${boardMgn.bmNo }" class="btn btn-primary px-4">목록</a>
                    <button type="submit" class="btn btn-danger px-4">등록</button>
                </div>
            </div>
        </form>
    </div>

    <jsp:include page="../layout/footer.jsp" />
    <script>
        function addFile() {
            let num = $(".uploadFiles").length + 1;
            $(".form-group.file_area").append("<input type='file' class='form-control uploadFiles mt-1' name='uploadFiles" + num + "' id='uploadFiles" + num + "' multiple>");
        }
    </script>
</body>
</html>