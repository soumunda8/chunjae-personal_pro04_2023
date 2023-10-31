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
    <style>
        .lectureWrap .lectureThumbnail {width:40%;}
        .lectureWrap .lectureInfo {width:60%;margin-left:-3px;}
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container-fluid bg-primary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 400px">
            <h3 class="display-3 font-weight-bold text-white">강의</h3>
            <div class="d-inline-flex text-white">
                <p class="m-0"><a class="text-white" href="${path }/">Home</a></p>
                <p class="m-0 px-2">/</p>
                <p class="m-0">강의</p>
            </div>
        </div>
    </div>

    <div class="container mb-5 align-items-center justify-content-center">
        <div class="column">
            <section class="latest-podcast-section section-padding pb-0">
                <ul class="nav nav-tabs nav-fill">
                    <li class="nav-item">
                        <a class="flex-sm-fill text-sm-center nav-link<c:if test="${empty cateNo || cateNo eq '' }"> active</c:if>" href="${path }/lecture/list.do">전체</a>
                    </li>
                    <c:forEach var="category" items="${categoryList }">
                        <li class="nav-item">
                            <a class="nav-link<c:if test="${category.cateNo eq cateNo }"> active</c:if>" href="${path }/lecture/list.do?cateNo=${category.cateNo }">${category.CName }</a>
                        </li>
                    </c:forEach>
                </ul>

                <div class="row justify-content-md-end my-5">
                    <div class="col-md-4 searchArea">
                        <form action="${path }/lecture/list.do" method="get" class="field has-addons has-addons-right">
                            <input type="hidden" name="cateNo" value="${cateNo }" />
                            <div class="input-group">
                                <div class="input-group-append">
                                    <select id="inputState" name="type" class="form-control rounded-0 border-right-0">
                                        <option value="title"<c:if test="${type eq 'title'}"> selected="selected"</c:if>>강의명</option>
                                        <option value="nm"<c:if test="${type eq 'nm'}"> selected="selected"</c:if>>강사</option>
                                    </select>
                                </div>
                                <input type="text" class="form-control" id="keyword" name="keyword" placeholder="검색어를 입력하세요" value="${keyword }" aria-label="Recipient's username" aria-describedby="basic-addon2">
                                <div class="input-group-append">
                                    <button class="btn btn-primary rounded-0" type="submit">검색</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </section>
        </div>

        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach var="lecture" items="${lectureList }" varStatus="status">
                <div class="col">
                    <div class="card">
                        <img src="${path }/resources/upload/lecture/lect_sample.png" class="card-img-top" alt="${lecture.title } 썸네일">
                        <div class="card-body">
                            <h5 class="card-title">${lecture.title }</h5>
                            <p class="card-text">${lecture.subTitle }</p>
                            <a href="${path }/lecture/get.do?lno=${lecture.lno }" class="btn btn-primary">상세보기</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <c:if test="${empty lectureList}">
            <p class="my-5" style="text-align:center">등록된 강의가 없습니다!</p>
        </c:if>

        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center mt-5">
                <c:if test="${curPage > page.pageCount }">
                    <li class="page-item"><a class="page-link" href="${path }/lecture/list.do?page=${page.blockStartNum - 1 }<c:if test="${not empty cateNo }">&cateNo=${cateNo }</c:if><c:if test="${not empty keyword }">&type=${type }&keyword=${keyword }</c:if>" aria-label="Previous"><span aria-hidden="true">«</span><span class="sr-only">Previous</span></a></li>
                </c:if>
                <c:forEach var="i" begin="${page.blockStartNum }" end="${page.blockLastNum }">
                    <c:choose>
                        <c:when test="${i == curPage }">
                            <li class="page-item active"><a class="page-link" href="${path }/lecture/list.do?page=${i }<c:if test="${not empty cateNo }">&cateNo=${cateNo }</c:if><c:if test="${not empty keyword }">&type=${type }&keyword=${keyword }</c:if>">1</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a class="page-link" href="${path }/lecture/list.do?page=${i }<c:if test="${not empty cateNo }">&cateNo=${cateNo }</c:if><c:if test="${not empty keyword }">&type=${type }&keyword=${keyword }</c:if>">1</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${page.blockLastNum < page.totalPageCount }">
                    <li class="page-item"><a class="page-link" href="${path }/lecture/list.do?page=${page.blockLastNum + 1 }<c:if test="${not empty cateNo }">&cateNo=${cateNo }</c:if><c:if test="${not empty keyword }">&type=${type }&keyword=${keyword }</c:if>" aria-label="Next"><span aria-hidden="true">»</span><span class="sr-only">Next</span></a></li>
                </c:if>
            </ul>
        </nav>
    </div>

    <%--<div class="container-fluid mb-5">
        <div class="container">
            <h3 class="mb-5 text-center py-2">강의</h3>
            <div class="d-flex flex-column align-items-center justify-content-center">
                <table class="table mb-5">
                    <tbody>
                    <tr>
                        <th class="text-center" scope="col">제목</th>
                        <td class="text-center">${lecture.title }</td>
                    </tr>
                    <tr>
                        <th class="text-center" scope="col">내용</th>
                        <td class="text-center">${lecture.subTitle }</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="d-flex flex-column align-items-center justify-content-center mb-5">
                <ul class="nav nav-tabs justify-content-center subTab">
                    <li class="nav-item">
                        <a href="#detail" class="nav-link detailTab active" aria-current="page" data-status="detail">상세보기</a>
                    </li>
                    <c:if test="${!empty boardList }">
                        <li class="nav-item">
                            <a href="#board${boardMgn.bmNo }" class="nav-link detailTab board${boardMgn.bmNo }Tab" data-status="board${boardMgn.bmNo }">${boardMgn.boardNm }</a>
                        </li>
                    </c:if>
                    &lt;%&ndash;<li class="nav-item">
                        <a class="nav-link" href="#">Link</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" aria-disabled="true">Disabled</a>
                    </li>&ndash;%&gt;
                </ul>
            </div>
            <div class="flex-column align-items-center justify-content-center lectureSubCon" id="detail">
                ${lecture.content }
            </div>
            <c:if test="${!empty boardList }">
            <div class="flex-column align-items-center justify-content-center lectureSubCon" id="board${boardMgn.bmNo }">
                <jsp:include page="../board/boardListForm.jsp" />
            </div>
            </c:if>
        </div>
    </div>--%>
    <jsp:include page="../layout/footer.jsp" />
</body>
</html>