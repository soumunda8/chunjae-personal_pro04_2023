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
                <a href="index.html" class="nav-item nav-link active">Home</a>
                <a href="about.html" class="nav-item nav-link">About</a>
                <a href="class.html" class="nav-item nav-link">Classes</a>
                <a href="team.html" class="nav-item nav-link">Teachers</a>
                <a href="gallery.html" class="nav-item nav-link">Gallery</a>
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Pages</a>
                    <div class="dropdown-menu rounded-0 m-0">
                        <a href="blog.html" class="dropdown-item">Blog Grid</a>
                        <a href="single.html" class="dropdown-item">Blog Detail</a>
                    </div>
                </div>
                <a href="contact.html" class="nav-item nav-link">Contact</a>
            </div>
            <c:if test="${sid != null}">
                <a href="${path }/user/logout.do" class="btn btn-primary px-4 mr-2"><i class="fas fa-sign-out-alt pr-2" style="color:#ffffff;"></i> 로그아웃</a>
                <c:if test="${sid eq 'admin'}">
                    <a href="${path }/admin/" class="btn btn-success px-4"><i class="fas fa-user-cog pr-2" style="color:#ffffff;"></i></i>관리자페이지</a>
                </c:if>
                <c:if test="${sid ne 'admin'}">
                    <a href="${path }/user/mypage.do" class="btn btn-success px-4"><i class="fas fa-user-circle pr-2" style="color:#ffffff;"></i></i>마이페이지</a>
                </c:if>
            </c:if>
            <c:if test="${sid == null}">
                <a href="${path }/user/term.do" class="btn btn-primary px-4 mr-2"><i class="fas fa-user-plus pr-2" style="color:#ffffff;"></i>회원가입</a>
                <a href="${path }/user/login.do" class="btn btn-success px-4"><i class="fas fa-sign-in-alt pr-2" style="color:#ffffff;"></i>로그인</a>
            </c:if>
        </div>
    </nav>
</div>

<%--
<header id="headerArea" class="header">
    <div class="hd_wrap hd_top">
        <nav class="tnb inner">
            <ul class="menu clearfix">
                <li class="home none"><a href="${path }/"><i class="fas fa-home"></i>해법</a></li>
                <c:if test="${sid != null}">
                    <li><a href="${path }/user/logout.jsp"><i class="fas fa-sign-out-alt"></i>로그아웃</a></li>

                    <c:if test="${sid eq 'admin'}">
                        <li><a href="${path }/admin/memberList.jsp"><i class="fas fa-user-cog"></i></i>관리자페이지</a></li>
                    </c:if>
                    <c:if test="${sid ne 'admin'}">
                        <li class="none"><a href="${path }/user/mypage.jsp"><i class="fas fa-user-circle"></i>마이페이지</a></li>
                    </c:if>
                </c:if>
                <c:if test="${sid == null}">
                    <li><a href="${path }/user/term.jsp"><i class="fas fa-user-plus"></i>회원가입</a></li>
                    <li class="none"><a href="${path }/user/login.jsp"><i class="fas fa-sign-in-alt"></i>로그인</a></li>
                </c:if>
            </ul>
        </nav>
    </div>
    <div class="hd_wrap hd_con">
        <div class="inner">
            <a href="${path }/" class="logo"><img src="${path }/resources/image/common/logo.png" alt="해법 로고">해법</a>
            <nav class="gnb">
                <ul class="menu">
                    <li class="item1">
                        <a href="#" class="dp1">소개</a>
                        <ul class="sub">
                            <li><a href="#">인사말</a></li>
                            <li><a href="#">연혁</a></li>
                            <li><a href="#">오시는길</a></li>
                        </ul>
                    </li>
                    <li class="item2">
                        <a href="#" class="dp1">강의</a>
                        <ul class="sub">
                            <li><a href="#">강의내역</a></li>
                        </ul>
                    </li>
                    <li class="item3">
                        <a href="#" class="dp1">커뮤니티</a>
                        <ul class="sub">
                            <li><a href="#">공지사항</a></li>
                            <li><a href="#">자유게시판</a></li>
                            <li><a href="#">자주하는질문</a></li>
                            <c:if test="${sid != null && sid ne 'admin'}">
                                <li><a href="#">문의하기</a></li>
                            </c:if>
                            <li><a href="#">학습자료실</a></li>
                        </ul>
                    </li>
                    <li class="item4">
                        <a href="#" class="dp1">이벤트</a>
                        <ul class="sub">
                            <li><a href="#">출석체크</a></li>
                            <li><a href="#">설문조사</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>
--%>