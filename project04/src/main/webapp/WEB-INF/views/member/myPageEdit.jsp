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
                                <li><a href="${path }/user/myPageLectList.do" class="px-4 py-2">나의 강의실</a></li>
                                <li><a href="${path }/user/myPagePaylistMem.do" class="px-4 py-2">나의 결제정보</a></li>
                                <li><a href="${path }/academy/myPageReservation.do" class="px-4 py-2">나의 예약정보</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-10 p-2">
                        <div class="d-flex flex-column align-items-center justify-content-center right_side">
                            <h5 class="my-4" style="font-size:2.5em;font-weight:600;">회원 정보 수정</h5>
                            <form action="${path }/user/myPageEdit.do" method="post" style="width:100%;">

                                <div class="container px-5">
                                    <table class="table table-bordered mx-3">
                                        <colgroup>
                                            <col style="width:20%;">
                                            <col style="width:auto;">
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th class="text-center">이름</th>
                                            <td>${member.nm }</td>
                                        </tr>
                                        <tr>
                                            <th class="text-center">아이디</th>
                                            <td>${member.id }</td>
                                        </tr>
                                        <tr>
                                            <th class="text-center">이메일</th>
                                            <td><input type="email" name="email" id="email" class="form-control" value="${member.email }" /></td>
                                        </tr>
                                        <tr>
                                            <th class="text-center">전화번호</th>
                                            <td><input type="text" name="tel" id="tel" class="form-control" value="${member.tel }" /></td>
                                        </tr>
                                        <tr>
                                            <th class="text-center">주소</th>
                                            <td>
                                                <input type="text" name="addr1" id="address1" value="${member.addr1 }" class="form-control mb-1" />
                                                <input type="text" name="addr2" id="address2" value="${member.addr2 }" class="form-control mb-1" />
                                                <input type="text" name="postcode" id="postcode" value="${member.postcode }" class="form-control">
                                                <button type="button" id="post_btn" onclick="findAddr()" class="btn">우편번호 검색</button>
                                                <label class="form-label blind" for="address1">주소</label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="text-center">생일</th>
                                            <td><input type="date" name="birth" id="birth" class="form-control" value="${member.birth }" /></td>
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
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>