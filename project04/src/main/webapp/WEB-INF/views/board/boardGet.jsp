<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::${board.boardNm }</title>
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
                <p class="m-0">${board.boardNm }</p>
            </div>
        </div>
    </div>

    <div class="container-fluid mb-5">
        <div class="container">
            <h3 class="mb-5 text-center py-2">${board.boardNm } 자세히보기</h3>

            <div class="btn-group d-block text-right mt-5">
                <a href="${path }/board/list.do?no=${board.bmNo }" class="btn btn-primary px-4">목록</a>
                <a href="${path }/board/update.do?bno=${board.bno }" class="btn btn-danger px-4">수정</a>
                <a href="${path }/board/delete.do?bno=${board.bno }" class="btn btn-primary px-4">삭제</a>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
</body>
</html>