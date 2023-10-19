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
        .lectureSubCon {display:none;}

        .star-icon {
            background-image:url("${path }/resources/image/common/heart0.png");
            background-repeat:no-repeat;
            width:20px;
            height:20px;
            background-size:cover;
        }
        .star-icon.click-star {
            cursor:pointer;
        }
        /* 색칠된 상태 */
        .star-icon.filled {
            background-image:url("${path }/resources/image/common/heart1.png");
        }
        .star-rating {
            display:flex;
            align-items:center;
        }
        .star-rating label {
            margin-right:10px;
        }
        .star-icons {
            display:flex;
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container-fluid bg-primary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 400px">
            <h3 class="display-3 font-weight-bold text-white">커뮤니티</h3>
            <div class="d-inline-flex text-white">
                <p class="m-0"><a class="text-white" href="${path }/">Home</a></p>
                <p class="m-0 px-2">/</p>
                <p class="m-0">강의</p>
            </div>
        </div>
    </div>

    <div class="container-fluid mb-5">
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
                    <%--<li class="nav-item">
                        <a class="nav-link" href="#">Link</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" aria-disabled="true">Disabled</a>
                    </li>--%>
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
    </div>
    <jsp:include page="../layout/footer.jsp" />
    <script>
        $(function(){
            let urlTag = window.location.href.split("#");
            if(urlTag[1] == null || urlTag[1] == "detail") {
                $("#detail").show();
            } else {
                $(".subTab a").removeClass("active");
                $("." + urlTag[1] + "Tab").addClass("active");
                $("#" + urlTag[1]).show();
            }

            $(".detailTab").on("click", function(){
                $(".subTab a").removeClass("active");
                $(".lectureSubCon").hide();
                $(this).addClass("active");
                let status = $(this).data('status');
                $("#" + status).show();
            });
        });
    </script>
</body>
</html>