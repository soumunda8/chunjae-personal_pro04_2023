<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::서적찾기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <jsp:include page="../layout/adminHead.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/admin.css" />
</head>
<body>
<div class="container p-5">
    <div>
        <table class="table">
            <thead>
            <tr>
                <th class="text-center">#</th>
                <th class="text-center">이름</th>
                <th class="text-center">가격</th>
                <th class="text-center">비고</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${not empty proList}">
                <c:forEach var="pro" items="${proList }" varStatus="status">
                    <tr>
                        <td class="text-center">${status.count }</td>
                        <td class="text-center">${pro.proNm }</td>
                        <td class="text-center">${pro.proPrice }</td>
                        <td class="text-center"><button class="btn btn-primary py-0" onclick="choose('${pro.proNm }', '${pro.proNo }');">선택</button></td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${empty proList}">
                <tr>
                    <td colspan="4" class="text-center">등록된 교재가 없습니다.</td>
                </tr>
            </c:if>
            </tbody>
        </table>
        <c:if test="${empty proList}">
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
        opener.document.frm1.proNm.value = nm;
        opener.document.frm1.proNo.value = id;
        window.close();
    }
</script>
</body>
</html>