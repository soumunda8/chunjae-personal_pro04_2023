<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<!-- [ Pre-loader ] start -->
<div class="loader-bg">
    <div class="loader-track">
        <div class="loader-fill"></div>
    </div>
</div>
<!-- [ Pre-loader ] End -->
<!-- [ navigation menu ] start -->
<nav class="pcoded-navbar  ">
    <div class="navbar-wrapper  ">
        <div class="navbar-content scroll-div " >
            <ul class="nav pcoded-inner-navbar ">
                <li class="nav-item pcoded-menu-caption">
                    <label>기본 관리</label>
                </li>
                <li class="nav-item">
                    <a href="${path }/admin/" class="nav-link "><span class="pcoded-micon"><i class="feather icon-home"></i></span><span class="pcoded-mtext">대시보드</span></a>
                </li>
                <li class="nav-item pcoded-menu-caption">
                    <label>회원 관리</label>
                </li>
                <li class="nav-item">
                    <a href="${path }/admin/memberConf.do" class="nav-link "><span class="pcoded-micon"><i class="feather icon-user"></i></span><span class="pcoded-mtext">회원</span></a>
                </li>
                <li class="nav-item pcoded-menu-caption">
                    <label>게시판 관리</label>
                </li>
                <li class="nav-item">
                    <a href="${path }/admin/boardMgnConf.do" class="nav-link "><span class="pcoded-micon"><i class="feather icon-box"></i></span><span class="pcoded-mtext">게시판 설정</span></a>
                </li>
                <li class="nav-item pcoded-menu-caption">
                    <label>강의 관리</label>
                </li>
                <li class="nav-item">
                    <a href="${path }/admin/lectureConf.do" class="nav-link "><span class="pcoded-micon"><i class="feather icon-box"></i></span><span class="pcoded-mtext">강의 설정</span></a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- [ navigation menu ] end -->
<!-- [ Header ] start -->
<header class="navbar pcoded-header navbar-expand-lg navbar-light header-dark">
    <div class="m-header">
        <a class="mobile-menu" id="mobile-collapse" href="#!"><span></span></a>
        <a href="${path }/" class="b-brand font-weight-bold" style="font-size:25px">
            <span>해법</span>
        </a>
        <a href="#!" class="mob-toggler">
            <i class="feather icon-more-vertical"></i>
        </a>
    </div>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto">
            <li>
                <div class="dropdown drp-user">
                    <a href="${path }/user/logout.do" class="dud-logout" title="Logout">로그아웃<i class="feather icon-log-out pl-2"></i></a>
                </div>
            </li>
        </ul>
    </div>
</header>