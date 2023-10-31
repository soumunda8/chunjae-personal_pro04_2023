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
                                <h5 class="m-b-10">배송 내역</h5>
                            </div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${path }/admin/"><i class="feather icon-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="#!" onclick="return false;">배송 설정</a></li>
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
                            <h5>배송 내역</h5>
                        </div>
                        <c:if test="${not empty paymentList }">
                            <div class="card-body table-border-style">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th class="text-center">#</th>
                                            <th class="text-center">강의 이름</th>
                                            <th class="text-center">수강 학생</th>
                                            <th class="text-center">결제 상태</th>
                                            <th class="text-center">배송 상태</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${paymentList }" var="payment" varStatus="status">
                                            <tr>
                                                <td class="text-center">${status.count }</td>
                                                <td class="text-center">${payment.lectureTitle }</td>
                                                <td class="text-center">${payment.cusNm }</td>
                                                <td class="text-center">
                                                    <c:if test="${payment.payStatus eq 0}">구매 미확정</c:if>
                                                    <c:if test="${payment.payStatus eq 1}">구매 확정</c:if>
                                                </td>
                                                <td class="text-center">
                                                    <select class="form-select" id="deliverStatus" aria-label="Default select example">
                                                        <option value="0,${payment.dno }"<c:if test="${payment.DStatus eq 0}"> selected</c:if>>배송전</option>
                                                        <option value="1,${payment.dno }"<c:if test="${payment.DStatus eq 1}"> selected</c:if>>배송중</option>
                                                        <option value="2,${payment.dno }"<c:if test="${payment.DStatus eq 2}"> selected</c:if>>도착</option>
                                                        <%--
                                                        <option value="3"<c:if test="${payment.DStatus eq 3}"> selected</c:if>>구매결정</option>
                                                        <option value="4"<c:if test="${payment.DStatus eq 4}"> selected</c:if>>구매취소</option>
                                                        --%>
                                                    </select>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${empty paymentList }">
                            <p class="f-18 f-w-600 text-center mt-3">등록된 결제가 없습니다.</p>
                        </c:if>
                    </div>
                </div>
            </div>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
    <script>
        $(function() {
           $("#deliverStatus").on("change", function() {
               let type = $("#deliverStatus").val();
               let words = type.split(',');
               let params = {"type" : parseInt(words[0]), "no" : parseInt(words[1])};
               $.ajax({
                   url:"${path }/admin/updateDStatus.do",
                   type:"post",
                   data:params,
                   success : function(result) {
                       if(result === true) {
                           location.reload();
                       }
                   },
               });
           });
        });
    </script>
</body>
</html>