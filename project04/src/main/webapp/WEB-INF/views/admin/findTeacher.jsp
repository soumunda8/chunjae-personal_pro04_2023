<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::강사찾기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <jsp:include page="../layout/adminHead.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/admin.css" />
</head>
<body>
    <div class="container p-5">
        <div class="row justify-content-md-end mb-3">
            <div class="col-md-3 searchArea">
                <form action="${path }/admin/findTeacher.do" method="get" class="field has-addons has-addons-right">
                    <div class="input-group">
                        <div class="input-group-append">
                            <select id="inputState" name="type" class="form-control">
                                <option value="name"<c:if test="${type eq 'name'}"> selected="selected"</c:if>>이름</option>
                            </select>
                        </div>
                        <input type="text" class="form-control" id="keyword" name="keyword" placeholder="검색어를 입력하세요" value="${keyword }" aria-label="Recipient's username" aria-describedby="basic-addon2">
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="submit">검색</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div>
            <table class="table">
                <thead>
                <tr>
                    <th class="text-center">#</th>
                    <th class="text-center">이름</th>
                    <th class="text-center">비고</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty teacherList}">
                    <c:forEach var="teacher" items="${teacherList }" varStatus="status">
                        <tr>
                            <td class="text-center">${status.count }</td>
                            <td class="text-center">${teacher.nm }</td>
                            <td class="text-center"><button class="btn btn-primary py-0" onclick="choose('${teacher.nm }', '${teacher.id }');">선택</button></td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty teacherList}">
                    <tr>
                        <td colspan="3" class="text-center">등록된 선생님이 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
            <c:if test="${!empty teacherList}">
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-center">
                        <c:if test="${curPage > page.pageCount }">
                            <li class="page-item"><a class="page-link" href="${path }/admin/findTeacher.do?page=${page.blockStartNum - 1 }" aria-label="Previous"><span aria-hidden="true">«</span><span class="sr-only">Previous</span></a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.blockStartNum }" end="${page.blockLastNum }">
                            <c:choose>
                                <c:when test="${i == curPage }">
                                    <li class="page-item active"><a class="page-link" href="${path }/admin/findTeacher.do?page=${i }">1</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="${path }/admin/findTeacher.do?page=${i }">1</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${page.blockLastNum < page.totalPageCount }">
                            <li class="page-item"><a class="page-link" href="${path }/admin/findTeacher.do?page=${page.blockLastNum + 1 }" aria-label="Next"><span aria-hidden="true">»</span><span class="sr-only">Next</span></a></li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
            <c:if test="${empty teacherList}">
                <div class="row text-center">
                    <div class="col-md-1 p-0">
                        <button type="button" class="btn btn-primary" onclick="return window.close();">닫기</button>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    <script>
        function choose(nm, id) {
            opener.document.frm1.teacherNm.value = nm;
            opener.document.frm1.teacherId.value = id;
            window.close();
        }
    </script>
</body>
</html>