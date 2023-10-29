<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<div class="container-fluid bg-light position-relative shadow">
    <nav class="navbar navbar-expand-lg bg-light navbar-light py-3 py-lg-0 px-0 px-lg-5">
        <a href="${path }/" class="navbar-brand font-weight-bold text-secondary" style="font-size: 50px"><i class="flaticon-043-teddy-bear"></i><span class="text-primary">해법</span></a>

        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
            <div class="navbar-nav font-weight-bold mx-auto py-0">
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">소개</a>
                    <div class="dropdown-menu rounded-0 m-0">
                        <a href="#" class="dropdown-item">인사말</a>
                        <a href="#" class="dropdown-item">연혁</a>
                        <a href="#" class="dropdown-item">오시는 길</a>
                    </div>
                </div>
                <a href="${path }/lecture/list.do" class="nav-item nav-link">강의</a>
                <div class="nav-item dropdown board_drop_menu">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">커뮤니티</a>
                    <div class="dropdown-menu rounded-0 m-0" id="boardMenuArea"></div>
                </div>
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">이벤트</a>
                    <div class="dropdown-menu rounded-0 m-0">
                        <a href="#" class="dropdown-item">출석체크</a>
                        <a href="#" class="dropdown-item">설문조사</a>
                    </div>
                </div>
            </div>
            <c:if test="${sid != null}">
                <a href="${path }/user/logout.do" class="btn btn-primary px-4 mr-2"><i class="fas fa-sign-out-alt pr-2" style="color:#ffffff;"></i> 로그아웃</a>
                <c:if test="${sid eq 'admin'}">
                    <a href="${path }/admin/" class="btn btn-success px-4"><i class="fas fa-user-cog pr-2" style="color:#ffffff;"></i></i>관리자페이지</a>
                </c:if>
                <c:if test="${sid ne 'admin'}">
                    <a href="${path }/user/myPage.do" class="btn btn-success px-4"><i class="fas fa-user-circle pr-2" style="color:#ffffff;"></i></i>마이페이지</a>
                </c:if>
            </c:if>
            <c:if test="${sid == null}">
                <a href="${path }/user/term.do" class="btn btn-primary px-4 mr-2"><i class="fas fa-user-plus pr-2" style="color:#ffffff;"></i>회원가입</a>
                <a href="${path }/user/login.do" class="btn btn-success px-4"><i class="fas fa-sign-in-alt pr-2" style="color:#ffffff;"></i>로그인</a>
            </c:if>
        </div>
    </nav>
</div>
<script>
    $(function (){
        $.ajax({
            url:"${path }/util/getBoardMgnList.do",
            type:"post",
            contentType:"application/json",
            success : function(result) {
                if(result == "") {
                    $(".board_drop_menu").remove();
                }
                for(let i in result) {
                    $("#boardMenuArea").append("<a href='${path }/board/list.do?no=" + result[i].bmNo + "' class='dropdown-item'>" + result[i].boardNm + "</a>");
                }
            },
        });
    });
</script>