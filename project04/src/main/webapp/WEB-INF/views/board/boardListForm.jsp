<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<div class="container">
    <h3 class="mb-5 text-center py-2"${h2Block }>${boardMgn.boardNm }</h3>
    <div class="row justify-content-md-end mb-5">
        <div class="col-md-4 searchArea">
            <form action="${path }/board/list.do" method="get" class="field has-addons has-addons-right">
                <input type="hidden" name="no" value="${boardMgn.bmNo }" />
                <div class="input-group">
                    <div class="input-group-append">
                        <select id="inputState" name="type" class="form-control rounded-0 border-right-0">
                            <option value="title"<c:if test="${type eq 'title'}"> selected="selected"</c:if>>제목</option>
                            <option value="nm"<c:if test="${type eq 'nm'}"> selected="selected"</c:if>>이름</option>
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
    <c:if test="${!empty boardList }">
        <div class="d-flex flex-column align-items-center justify-content-center">
            <table class="table mb-5">
                <thead>
                <tr>
                    <th class="text-center" scope="col">#</th>
                    <th class="text-center" scope="col">제목</th>
                    <th class="text-center" scope="col">작성자</th>
                    <th class="text-center" scope="col">등록일</th>
                    <th class="text-center" scope="col">조회수</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="board" items="${boardList }" varStatus="status">
                    <tr>
                        <td class="text-center">${status.count }</td>
                        <td>
                            <a href="${path }/board/get.do?bno=${board.bno }">
                                <c:if test="${board.boardType == 1 }"><span class="pr-3">[답변 <c:if test="${board.answerYn }">완료</c:if><c:if test="${!board.answerYn }">대기</c:if>]</span></c:if>${board.title }
                            </a>
                        </td>
                        <td class="text-center">${board.nm }</td>
                        <td class="text-center">
                            <fmt:parseDate value="${board.resDate }" var="resDate" pattern="yyyy-MM-dd HH:mm:ss" />
                            <fmt:formatDate value="${resDate }" pattern="yyyy-MM-dd" />
                        </td>
                        <td class="text-center">${board.visited }</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <c:if test="${curPage > page.pageCount }">
                        <li class="page-item"><a class="page-link" href="${path }/admin/memberList.do?page=${page.blockStartNum - 1 }<c:if test="${!empty keyword }">&type=${type }&keyword=${keyword }</c:if>" aria-label="Previous"><span aria-hidden="true">«</span><span class="sr-only">Previous</span></a></li>
                    </c:if>
                    <c:forEach var="i" begin="${page.blockStartNum }" end="${page.blockLastNum }">
                        <c:choose>
                            <c:when test="${i == curPage }">
                                <li class="page-item active"><a class="page-link" href="${path }/admin/memberList.do?page=${i }<c:if test="${!empty keyword }">&type=${type }&keyword=${keyword }</c:if>">1</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="${path }/admin/memberList.do?page=${i }<c:if test="${!empty keyword }">&type=${type }&keyword=${keyword }</c:if>">1</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${page.blockLastNum < page.totalPageCount }">
                        <li class="page-item"><a class="page-link" href="${path }/admin/memberList.do?page=${page.blockLastNum + 1 }<c:if test="${!empty keyword }">&type=${type }&keyword=${keyword }</c:if>" aria-label="Next"><span aria-hidden="true">»</span><span class="sr-only">Next</span></a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </c:if>
    <c:if test="${empty boardList }">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height:20vh;">
            <h5 class="font-weight-bold">등록된 게시글이 없습니다.</h5>
        </div>
    </c:if>

    <c:if test="${addCheck == true}">
        <div class="btn-group d-block text-right mt-3">
            <a href="${path }/board/add.do?no=${boardMgn.bmNo }" class="btn btn-primary px-4"><c:if test="${boardMgn.boardType == 0 }">등록</c:if><c:if test="${boardMgn.boardType == 1 }">문의하기</c:if></a>
        </div>
    </c:if>
</div>