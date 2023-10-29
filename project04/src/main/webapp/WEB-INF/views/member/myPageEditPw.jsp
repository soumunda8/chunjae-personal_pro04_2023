<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::마이페이지</title>
    <jsp:include page="../layout/head.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/sub.css">
</head>
<body class="myPage">
    <jsp:include page="../layout/header.jsp" />

    <div class="container-fluid">
        <div class="row justify-content-md-center my-5">
            <div class="col-8">
                <div class="row">
                    <div class="col-2 p-2">
                        <div class="d-flex flex-column align-items-center justify-content-center border left_side">
                            <div class="left_top">
                                <p>마이페이지</p>
                            </div>
                            <ul class="my-2" style="width:100%;">
                                <li><a href="${path }/user/myPage.do" class="active px-4 py-2">나의 정보</a></li>
                                <li><a href="${path }/user/mypageLectList.do" class="px-4 py-2">나의 강의실</a></li>
                                <li><a href="${path }/user/mypagePaylistMem.do" class="px-4 py-2">나의 결제정보</a></li>
                                <li><a href="${path }/academy/mypageReservation.do" class="px-4 py-2">나의 예약정보</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-10 p-2">
                        <div class="d-flex flex-column align-items-center justify-content-center right_side">
                            <h5 class="my-4" style="font-size:2.5em;font-weight:600;">회원 비밀번호 수정</h5>
                            <form action="${path }/user/mypageChangePw.do" method="post" style="width:100%;" onsubmit="return pwCheck(this)">

                                <div class="container px-5">
                                    <table class="table table-bordered mx-3">
                                        <colgroup>
                                            <col style="width:20%;">
                                            <col style="width:auto;">
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th class="text-center">현재 비밀번호 입력</th>
                                            <td><input type="password" name="checkPw" id="checkPw" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <th class="text-center">새로운 비밀번호 입력</th>
                                            <td><input type="password" name="pw" id="pw" class="form-control" required /></td>
                                        </tr>
                                        <tr>
                                            <th class="text-center">새로운 비밀번호 확인</th>
                                            <td><input type="password" name="pw2" id="pw2" class="form-control" required /></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <a href="${path }/user/myPage.do" class="btn btn-primary px-5 py-2 my-4 mr-2">취소</a>
                                    <button type="submit" class="btn btn-success px-5 py-2 my-4">수정</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />
    <script>
        <c:if test="${msg eq 'fail' }">
        alert("현재 비밀번호가 맞지 않습니다.\n다시 한번 확인해주세요.");
        </c:if>
        function pwCheck(data){
            if(data.pw.value != data.pw2.value){
                alert("새로운 비밀번호와 새로운 비밀번호 확인이 서로 다릅니다.");
                data.pw.focus();
                return false;
            }
        }
    </script>
</body>
</html>