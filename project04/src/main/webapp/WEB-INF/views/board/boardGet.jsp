<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::${board.boardNm }</title>
    <jsp:include page="../layout/head.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/sub.css">
    <script type="text/javascript" src="${path }/resources/ckeditor/ckeditor.js"></script>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container-fluid bg-primary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 400px">
            <h3 class="display-3 font-weight-bold text-white">커뮤니티</h3>
            <div class="d-inline-flex text-white">
                <p class="m-0"><a class="text-white" href="${path }/">Home</a></p>
                <p class="m-0 px-2">/</p>
                <p class="m-0"><a class="text-white" href="${path }/board/list.do?no=1">커뮤니티</a></p>
                <p class="m-0 px-2">/</p>
                <p class="m-0">${board.boardNm }</p>
            </div>
        </div>
    </div>

    <div class="container-fluid mb-5">
        <div class="container">
            <h3 class="mb-5 text-center py-2">${board.boardNm } 자세히보기</h3>

            <div class="mb-5 board_area">
                <div class="board_top py-3 pl-4">
                    <p class="board_title position-relative mb-0">${board.title }<span class="view ico position-absolute"><i class="fas fa-eye"></i>&nbsp;${board.visited }</span></p>
                    <p class="board_info position-relative mb-0 mt-3">
                        <fmt:parseDate value="${board.resDate }" var="resDate" pattern="yyyy-MM-dd HH:mm:ss" />
                        <span class="date"><fmt:formatDate value="${resDate }" pattern="yyyy-MM-dd" /></span>
                        <span class="m-0 px-2">&#124;</span>
                        <span class="writer">${board.nm }</span>
                    </p>
                </div>
                <div class="board_view pt-3 pl-4">${board.content }</div>
                <c:if test="${board.fileUse && !empty fileList }">
                    <div class="board_files py-3 pl-4">
                        <ul class="mb-0">
                            <c:forEach var="files" items="${fileList }">
                                <li>
                                    <a href="${path }/util/fileDownload.do?no=${files.fno }"><i class="fas fa-image pr-1"></i>${files.originNm }</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
            </div>

            <c:if test="${board.commentUse }">
                <div class="mb-5 pt-3 px-4 comment_area">
                    <c:if test="${!empty sid }">
                        <div class="mb-3">
                            <input type="hidden" name="par" id="par" value="${board.bno }"/>
                            <div class="control-group d-inline-block comment_input">
                                <textarea class="form-control" rows="2" name="content" id="content" placeholder="댓글을 입력하세요." required></textarea>
                            </div>
                            <div class="d-inline-block comment_btn">
                                <button class="btn btn-primary py-2 px-4" type="button" onclick="commentAdd()">등록하기</button>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${!empty commentList }">
                        <ul id="commentListArea" class="mb-0">
                            <c:forEach var="comment" items="${commentList }" varStatus="status">
                                <li id="comm${status.count }" class="mb-3">
                                    <div class="comment_top">
                                        <p class="comment_writer mb-0">${status.count}. ${comment.nm }<span class="comment_date ml-2">${comment.resDate }</span></p>
                                        <c:if test="${!empty sid && (sid.equals('admin') || sid.equals(comment.author))}">
                                            <button class="btn p-0 mr-1 deleteBtn" onclick="commentDelete(${comment.cno }, ${status.count })">삭제</button>
                                            <%--<button class="btn p-0 modifyBtn" onclick="commentModify(${comment.cno }, ${status.count })">수정</button>--%>
                                        </c:if>
                                    </div>
                                    <div class="comment_con">
                                        ${comment.content }
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${empty commentList }">
                        <div class="text-center pb-3">등록된 댓글이 없습니다.</div>
                    </c:if>
                </div>
            </c:if>

            <div class="btn-group d-block text-right mt-5">
                <a href="${path }/board/list.do?no=${board.bmNo }" class="btn btn-primary px-4">목록</a>
                <c:if test="${addCheck == true || (sid ne null && sid eq 'admin')}">
                    <a href="${path }/board/update.do?bno=${board.bno }" class="btn btn-danger px-4">수정</a>
                    <a href="${path }/board/delete.do?bno=${board.bno }" class="btn btn-primary px-4">삭제</a>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
    <script>
        function commentAdd() {
            let par = $("#par").val();
            let content = $("#content").val();
            let num = $("#commentListArea > li").length + 1;

            let params = {"par" : par, "content" : content};
            $.ajax({
                url:"${path }/board/commentAdd.do",
                type:"post",
                data:JSON.stringify(params),
                dataType:"json",
                contentType:"application/json",
                success : function(result) {
                    $("#content").val("");
                    let htmlStr = "<li id='comm" + num + "' class='mb-3'>";
                    htmlStr += "<div class='comment_top'>";
                    htmlStr += "<p class='comment_writer mb-0'>" + num + ". " + result.nm + "<span class='comment_date ml-2'>" + result.resDate + "</span></p>";
                    htmlStr += "<button class='btn p-0 mr-1 deleteBtn' onclick='commentDelete(" + result.cno + ")'>삭제</button>";
                    /*htmlStr += "<button class='btn p-0 modifyBtn' onclick='commentModify(" + result.cno + ")'>수정</button>";*/
                    htmlStr += "</div>";
                    htmlStr += "<div class='comment_con'>";
                    htmlStr += result.content;
                    htmlStr += "</div>";
                    htmlStr += "</li>";
                    $("#commentListArea").append(htmlStr);
                },
            });
        }

        function commentDelete(cno, cnt){
            let params = {"cno" : cno};
            $.ajax({
                url:"${path }/board/commentRemove.do",
                type:"post",
                data:JSON.stringify(params),
                dataType:"json",
                contentType:"application/json",
                success : function(result) {
                    $("#comm" + cnt).remove();
                },
            });
        }

        /*function commentModify(cno, cnt){}*/
    </script>
</body>
</html>