<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<div class="container-fluid mb-5">
    <div class="container">
        <h3 class="mb-5 text-center py-2">${board.boardNm } 자세히보기</h3>

        <div class="mb-5 board_area">
            <div class="board_top py-3 pl-4">
                <p class="board_title position-relative mb-0"><c:if test="${board.boardType == 1 }">[문의 제목] </c:if>${board.title }<span class="view ico position-absolute"><i class="fas fa-eye"></i>&nbsp;${board.visited }</span></p>
                <p class="board_info position-relative mb-0 mt-3">
                    <fmt:parseDate value="${board.resDate }" var="resDate" pattern="yyyy-MM-dd HH:mm:ss" />
                    <span class="date"><fmt:formatDate value="${resDate }" pattern="yyyy-MM-dd" /></span>
                    <span class="m-0 px-2">&#124;</span>
                    <span class="writer">${board.nm }</span>
                </p>
            </div>
            <div class="board_view py-3 pl-4">${board.content }</div>
            <c:if test="${board.fileUse && !empty fileList }">
                <div class="board_files py-3 pl-4">
                    <ul class="mb-0">
                        <c:forEach var="files" items="${fileList }">
                            <li>
                                <a href="${path }/util/fileDownload.do?no=${files.fno }">
                                    <c:choose>
                                        <c:when test="${files.fileType eq 'image' }"><i class="fas fa-image pr-1"></i></c:when>
                                        <c:when test="${files.fileType eq 'application' }"><i class="fas fa-file-alt pr-1"></i></c:when>
                                    </c:choose>
                                        ${files.originNm }
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
        </div>

        <c:if test="${board.boardType == 1 }">
            <div class="mb-5 pt-3 px-4 comment_area">
                <c:if test="${!board.answerYn }">
                    <c:if test="${sid eq 'admin' || (boardMgn.depth == 2 && cnt > 0) }">
                        <div class="mb-3 qna_form">
                            <div class="control-group d-inline-block comment_input">
                                <input type="hidden" name="bno" id="bno" value="${board.bno }"/>
                                <textarea class="form-control" rows="2" name="answer" id="answer" placeholder="답변을 입력하세요." required></textarea>
                            </div>
                            <div class="d-inline-block comment_btn">
                                <button class="btn btn-primary py-2 px-4" type="button" onclick="answerAdd()">답변하기</button>
                            </div>
                        </div>
                        <div class="mb-3 qna_answer"></div>
                    </c:if>
                    <c:if test="${sid ne 'admin' }">
                        <div class="mb-3 qna_answer">
                            <p class="text-center">등록된 답변이 없습니다.</p>
                        </div>
                    </c:if>
                </c:if>
                <c:if test="${board.answerYn }">
                    <div class="mb-3 qna_answer">
                        <p><span class="pr-3">[답변내용]</span>${board.answer }</p>
                    </div>
                </c:if>
            </div>
        </c:if>

        <c:if test="${board.commentUse }">
            <div class="mb-5 pt-3 px-4 comment_area only_comment">
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
                    <div class="text-center pb-3 no_comment">등록된 댓글이 없습니다.</div>
                </c:if>
            </div>
        </c:if>

        <div class="btn-group d-block text-right mt-5 board_btn">
            <a href="${path }${pathUrl }" class="btn btn-primary px-4">목록</a>
            <c:if test="${board.boardType == 0 && (addCheck == true || (sid ne null && sid eq 'admin')) }">
                <a href="${path }${pathUpdateUrl }" class="btn btn-danger px-4">수정</a>
                <a href="${path }/board/delete.do?bno=${board.bno }" class="btn btn-primary px-4">삭제</a>
            </c:if>
            <c:if test="${board.boardType == 1 && addCheck == true }">
                <a href="${path }/board/delete.do?bno=${board.bno }" class="btn btn-danger px-4">삭제</a>
                <c:if test="${!board.answerYn }">
                    <a href="${path }${pathUpdateUrl }" class="btn btn-primary px-4" id="updateBtn">수정</a>
                </c:if>
            </c:if>
        </div>
    </div>
</div>
<c:if test="${!empty msg }">
    <script>
        $(function() {
            alert("삭제할 권한이 없습니다!");
        });
    </script>
</c:if>
<script>

    <c:if test="${board.boardType == 1 && (sid eq 'admin' || (boardMgn.depth == 2 && cnt > 0)) }">
    function answerAdd() {
        let bno = parseInt($("#bno").val());
        let answer = $("#answer").val();

        let params = {"bno" : bno, "answer" : answer};
        $.ajax({
            url:"${path }/board/answerAdd.do",
            type:"post",
            data:params,
            success : function(result) {
                location.reload();
            },
        });
    }
    </c:if>

    <c:if test="${board.commentUse && !empty sid }">
    function commentAdd() {
        let par = parseInt($("#par").val());
        let content = $("#content").val();
        let num = $("#commentListArea > li").length + 1;

        let params = {"par" : par, "content" : content};
        $.ajax({
            url:"${path }/board/commentAdd.do",
            type:"post",
            data:params,
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
                if(num > 1) {
                    $("#commentListArea").append(htmlStr);
                } else {
                    $(".no_comment").remove();
                    let newHtmlStr = "<ul id='commentListArea' class='mb-0'>";
                    newHtmlStr += htmlStr;
                    newHtmlStr += "</ul>";
                    $(".only_comment").append(newHtmlStr);
                }
            },
        });
    }

    function commentDelete(cno, cnt){
        let params = {"cno" : parseInt(cno)};
        let num = $("#commentListArea > li").length;
        $.ajax({
            url:"${path }/board/commentRemove.do",
            type:"post",
            data:params,
            success : function(result) {
                if(result) {
                    $("#comm" + cnt).remove();
                    if(num == 1) {
                        $("#commentListArea").remove();
                        $(".only_comment").append("<div class='text-center pb-3 no_comment'>등록된 댓글이 없습니다.</div>");
                    }
                }
            },
        });
    }

    /*function commentModify(cno, cnt){}*/
    </c:if>
</script>