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
                                <h5 class="m-b-10">회원 등급 승인 관리</h5>
                            </div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${path }/admin/"><i class="feather icon-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="#!" onclick="return false;">회원 등급 승인 관리</a></li>
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
                            <h5>회원 내역</h5>
                        </div>
                        <c:if test="${!empty memberMgnList }">
                            <div class="card-body table-border-style">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th class="text-center">#</th>
                                            <th class="text-center">이름</th>
                                            <th class="text-center">승인 여부</th>
                                            <th class="text-center">승인 상태</th>
                                            <th class="text-center">첨부 파일</th>
                                            <th class="text-center">비고</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${memberMgnList }" var="member" varStatus="status">
                                            <tr>
                                                <td class="text-center">${status.count }</td>
                                                <td class="text-center">${member.nm }</td>
                                                <td class="text-center">
                                                    <c:if test="${member.approveYn }">승인</c:if>
                                                    <c:if test="${!member.approveYn }">미승인</c:if>
                                                </td>
                                                <td class="text-center statusType">
                                                    <c:if test="${member.MStatus != 3 }">
                                                        <c:choose>
                                                            <c:when test="${member.MStatus == 1 }">승인 대기</c:when>
                                                            <c:when test="${member.MStatus == 2 }">승인 취소</c:when>
                                                            <c:when test="${member.MStatus == 4 }">승인 재대기</c:when>
                                                        </c:choose>
                                                    </c:if>
                                                    <c:if test="${member.MStatus == 3 }"> - </c:if>
                                                </td>
                                                <td class="text-center">
                                                    <c:if test="${member.fno != 0}">
                                                        <a href="${path }/util/fileDownload.do?no=${member.fno }"><i class="far fa-file-alt"></i></a>
                                                    </c:if>
                                                </td>
                                                <td class="text-center">
                                                    <c:if test="${!member.approveYn }">
                                                        <div class="buttons are-small is-centered">
                                                            <a href="${path }/user/memberMgnAccept.do?id=${member.author }" class="btn btn-primary btn-sm">등급 승인</a>
                                                            <button class="btn btn-success btn-sm ml-1" onclick="refuse(${status.count })">등급 취소</button>
                                                        </div>
                                                    </c:if>
                                                </td>
                                            </tr>
                                            <c:if test="${!member.approveYn }">
                                                <tr class="refuseArea refuseArea${status.count }">
                                                    <td colspan="6">
                                                        <input type="hidden" name="no" id="no" value="${member.mmNo }"/>
                                                        <textarea class="form-control d-inline-block" rows="1" name="content" id="content" placeholder="취소 사유를 입력하세요." style="width: calc(100% - 100px);margin-right: 25px;vertical-align: top;">${member.content }</textarea>
                                                        <button type="button" class="d-inline-block btn btn-success btn-sm" onclick="refusePro()" style="vertical-align:top;height: 45px;">등급 취소</button>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${empty memberMgnList }">
                            <p class="f-18 f-w-600 text-center mt-3">등급 신청한 회원이 없습니다.</p>
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
            $(".refuseArea").hide();
        });

        function refuse(idx) {
            $(".refuseArea").hide();
            $(".refuseArea"+idx).show();
        }

        function refusePro(num) {
            let content = $("#content").val();
            let no = parseInt($("#no").val());

            let params = {"no" : no, "content" : content};
            $.ajax({
                url:"${path }/user/memberMgnRefuse.do",
                type:"post",
                data:params,
                success : function(result) {
                    $(".statusType").text("승인 취소");
                },
            });
        }
    </script>
</body>
</html>