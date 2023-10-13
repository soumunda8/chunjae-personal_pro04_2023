<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- 메타포 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=dege"> <!-- 인터넷익스프로러로 접근시 엣지로 연결되게 함 -->
<meta http-equiv="Author" content="해법 콘텐츠 제작팀">
<meta http-equiv="Publisher" content="해법 제작자">
<meta http-equiv="Copyright" content="Copyright@haebeop.ed.kr">

<!-- 검색엔진 최적화(SEO:Search Engeen) -->
<meta name="Subject" content="해법 - 관리자">
<meta name="Keyword" content="해법 - 관리자">
<meta name="Description" content="해법 - 관리자 사이트">
<meta name="robots" content="noindex,nofollow">

<!-- 파비콘 설정 :32X32 자주 사용 -->
<!-- 표준 파비콘 -->
<link rel="shortcut icon" href="${path }/resources/image/common/logo.ico">
<!-- 애플 계열 모바일 -->
<link rel="apple-touch-ico-precomposed" href="${path }/resources/image/common/logo_64.png">
<!-- IE 계열 브라우저 -->
<meta name="msapplication-TileColor" content="#fff">
<meta name="msapplication-TileImage" content="${path }/resources/image/common/logo_48.png">

<!-- 파이어폭스, 오페라 또는 구형 크롬/사파리 -->
<link rel="icon" href="${path }/resources/image/common/logo_32.png" sizes="32x32">
<link rel="icon" href="${path }/resources/image/common/logo_48.png" sizes="48x48">
<link rel="icon" href="${path }/resources/image/common/logo_64.png" sizes="64x64">

<link rel="stylesheet" href="${path }/resources/css/common.css">
<link rel="stylesheet" href="${path }/resources/css/all.css">
<link rel="stylesheet" href="${path }/resources/css/adminStyle.css">

<!--
<script>
    document.oncontextmenu = function () {return false;}
    document.ondragstart = function () {return false;}
    document.onselectstart = function () {return false;}
</script>
-->