<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<script type="text/javascript" src="${path }/resources/cleditor/jquery.cleditor.js"></script>
<link rel="stylesheet" href="${path }/resources/cleditor/jquery.cleditor.css">
<div class="container-fluid mb-5">
    <form action="${path }/board/update.do" method="post" enctype="multipart/form-data">
        <div class="container">
            <h3 class="mb-5 text-center py-2">${board.boardNm }글 수정</h3>
            <input type="hidden" name="bno" value="${board.bno }" />

            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" class="form-control" name="title" id="title" value="${board.title }" required>
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea name="content" id="content" class="textarea" rows="8" cols="100" maxlength="1400" required>${board.content}</textarea>
                <script>
                    $(document).ready(function() {
                        $("#content").cleditor();
                    });
                </script>
            </div>

            <c:if test="${board.fileUse == true }">
                <div class="form-group file_area">
                    <label>파일 업로드(10MB 이하) <span class="btn pt-0 px-0" onclick="addFile()">(<i class="fas fa-plus px-1"></i>)</span></label>
                    <c:forEach var="files" items="${fileList }" varStatus="status">
                        <p id="files${status.count}">${files.originNm } <button type="button" class="btn btn-primary px-2 py-0 ml-2" onclick="removeFiles(${files.fno }, ${status.count })" style="font-size:0.8rem;">삭제</button></p>
                    </c:forEach>
                    <input type="file" class="form-control uploadFiles" name="uploadFiles" id="formFileMultiple" multiple>
                </div>
            </c:if>

            <div class="btn-group d-block text-right mt-5">
                <a href="${path }${pathUrl }" class="btn btn-primary px-4">목록</a>
                <button type="submit" class="btn btn-danger px-4">수정</button>
            </div>
        </div>
    </form>
</div>
<script>
    function addFile() {
        let num = $(".uploadFiles").length + 1;
        $(".form-group.file_area").append("<input type='file' class='form-control uploadFiles mt-1' name='uploadFiles' id='uploadFiles" + num + "' multiple>");
    }

    function removeFiles(fno, cnt) {
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
                    $("#files" + cnt).remove();
                }
            },
        });
    }
</script>