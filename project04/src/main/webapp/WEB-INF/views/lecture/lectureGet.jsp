<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::강의</title>
    <jsp:include page="../layout/head.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/sub.css">
    <link rel="stylesheet" href="${path }/resources/css/lecture.css">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <!-- 상단 강의 소개-->
    <div class="bg-dark py-5">
        <div class="container px-5">
            <div class="row gx-5 justify-content-center">
                <div class="col-lg-6">
                    <img src="${path }/resources/upload/lecture/lect_sample.png" />
                </div>
                <div class="col-lg-6">
                    <h3 style="color: var(--main-color);">${lecture.title } </h3>
                    <h1 class="display-5 fw-bolder text-white mb-2">${lecture.title }</h1>
                    <h3 class="lead text-white-50 mb-4">${lecture.subTitle }</h3>
                    <h3 class="lead text-white-50 mb-4">${lecture.nm } 선생님</h3>
                    <a class="btn btn-danger btn-lg px-4 me-sm-3" id="vvv" href="${path }/resources/upload/lecture/lectvideo_sample.mp4" target="_blank" >강의 맛보기</a>
                    <a class="btn btn-warning btn-lg px-4 ml-2" href="#lect_review" >수강생 후기</a>
                </div>
            </div>
        </div>
    </div>
    </div>

    <!-- Page content-->
    <div class="container mt-5">
        <div class="row">
            <div class="col-lg-8">
                <!-- 내부탭 -->
                <nav>
                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                        <button class="nav-link active" id="tab-content" data-bs-toggle="tab" data-bs-target="#tab-content" type="button" role="tab" aria-selected="true">강의내용</button>
                        <button class="nav-link" id="tab-curri" data-bs-toggle="tab" data-bs-target="#tab-curri" type="button" role="tab" aria-selected="false">커리큘럼</button>
                        <button class="nav-link" id="tab-book" data-bs-toggle="tab" data-bs-target="#tab-book" type="button" role="tab" aria-selected="false">강의 교재</button>
                        <button class="nav-link" id="tab-review" data-bs-toggle="tab" data-bs-target="#tab-review" type="button" role="tab" aria-selected="false">수강후기</button>
                        <c:if test="${not empty boardMgnList }">
                            <c:forEach var="boardMgn" items="${boardMgnList }">
                                <a href="${path }/lecture/boardList.do?no=${boardMgn.bmNo }&lno=${lecture.lno }" class="nav-link">${boardMgn.boardNm }</a>
                            </c:forEach>
                        </c:if>
                    </div>
                </nav>
                <!-- 강의 내용 -->
                <article id="lect_con">
                    <header class="mb-4">
                        <h1 class="fw-bolder mb-1" style="margin-top: 2rem;">${lecture.title }</h1>
                        <div class="text-muted fst-italic mb-2">${lecture.subTitle }</div>
                    </header>
                    <section class="mb-5">
                        ${lecture.content }
                    </section>
                </article>
                <!-- 목차 -->
                <div id="lect_book">
                    <ul class="list-group">
                        <h2> 강의 교재 </h2>
                        <div class="mt-1">
                            <img src="${path }/resources/upload/lecture/book_sample.jpg" width="300px">
                        </div>
                    </ul>
                </div>
                <!-- 목차 -->
                <div id="lect_list">
                    <ul class="list-group">
                        <h2> 목차 </h2>
                        <c:if test="${not empty curriList }">
                            <c:forEach var="curri" items="${curriList }">
                                <li class="list-group-item">${curri.content}</li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>
                <!-- 수강후기(review) 영역 -->
                <section class="mb-5" id="lect_review">
                    <h2> 수강후기 </h2>
                    <div class="card bg-light">
                        <div class="card-body">
                            <!-- 수강후기 리스트 -->
                            <div>
                                <c:if test="${not empty reviewList }">
                                    <c:forEach var="review" items="${reviewList }">
                                        <div class="d-flex">
                                            <div class="review_mem">
                                                <p style="margin: 0 auto;">${review.memId}</p>
                                            </div>
                                            <div class="riview_list">
                                                <div class="star-rating">
                                                        <%-- 별점 출력 --%>
                                                    <c:forEach begin="1" end="${review.star}" var="i">
                                                        <span class="star-icon filled"></span>
                                                    </c:forEach>
                                                    <c:forEach begin="${review.star + 1}" end="5" var="i">
                                                        <span class="star-icon"></span>
                                                    </c:forEach>
                                                </div>
                                                <div>${review.content } </div>
                                                <div id="reg">
                                                    <fmt:parseDate value="${review.regdate }" var="regdate" pattern="yyyy-MM-dd HH:mm:ss" />
                                                    <fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd" />
                                                </div>
                                            </div>
                                            <div>
                                            </div>

                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <c:if test="${empty reviewList }">
                                <tr>
                                    <td colspan="4">수강후기가 존재하지 않습니다.</td>
                                </tr>
                            </c:if>
                        </div>
                    </div>
                </section>
            </div>
            <!-- 우측 탭-->
            <div class="col-lg-4" id="lect_tab">
                <div class="card mb-4">
                    <div class="card-header">
                        <h2><fmt:formatNumber value="${lecture.LPrice }" pattern="#,###" />원</h2>
                        <a href="${path}/payment/payinsert.do?lno=${lecture.lno }" class="btn btn-primary" id="button-search" >바로 수강신청 하기</a>
                    </div>
                    <div class="card-body">
                        <div class="input-group">
                            <ul>
                                <li>난이도 : 입문</li>
                                <li>1개의 코딩 연습</li>
                                <li>수강기한 : 무제한</li>
                                <li>수료증 : 발급</li>
                            </ul>
                            <div>지식공유자 답변이 제공되는 강의입니다</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
    <script>
        window.addEventListener("scroll", function() {
            const scrollingDiv = document.querySelector(".col-lg-4");
            const scrollY = window.scrollY;
            if (scrollY >= 500) {
                // 스크롤 위치가 500px 이상이면 div를 상단에 고정
                scrollingDiv.style.top = 100 + scrollY + "px";
            } else {
                // 스크롤 위치가 500px 미만이면 초기 위치로 이동
                scrollingDiv.style.top = "500px";
            }
        });

        // tab click 하면 지정 구역으로 이동
        document.addEventListener('DOMContentLoaded', function() {
            const lectureTab = document.getElementById('tab-content');
            const lectureContent = document.getElementById('lect_con');
            lectureTab.addEventListener('click', function() {
                const scrollPosition = lectureContent.offsetTop - 50;
                window.scrollTo({ top: scrollPosition, behavior: 'smooth' });
            });
        });
        document.addEventListener('DOMContentLoaded', function() {
            const lectureTab = document.getElementById('tab-curri');
            const lectureContent = document.getElementById('lect_list');
            lectureTab.addEventListener('click', function() {
                const scrollPosition = lectureContent.offsetTop - 50;
                window.scrollTo({ top: scrollPosition, behavior: 'smooth' });
            });
        });
        document.addEventListener('DOMContentLoaded', function() {
            const lectureTab = document.getElementById('tab-review');
            const lectureContent = document.getElementById('lect_review');
            lectureTab.addEventListener('click', function() {
                const scrollPosition = lectureContent.offsetTop - 50;
                window.scrollTo({ top: scrollPosition, behavior: 'smooth' });
            });
        });
        document.addEventListener('DOMContentLoaded', function() {
            const lectureTab = document.getElementById('tab-book');
            const lectureContent = document.getElementById('lect_book');
            lectureTab.addEventListener('click', function() {
                const scrollPosition = lectureContent.offsetTop - 50;
                window.scrollTo({ top: scrollPosition, behavior: 'smooth' });
            });
        });
    </script>
</body>
</html>