<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP</title>
    <jsp:include page="../layout/adminHead.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/admin.css" />
    <link rel="stylesheet" href="${path }/resources/css/owl.carousel.css" />
</head>
<body>
    <jsp:include page="../layout/adminHeader.jsp" />
    <div class="pcoded-main-container">
        <div class="pcoded-content">
            <!-- [ breadcrumb ] start -->
            <div class="page-header">
                <div class="page-block">
                    <div class="row align-items-center">
                        <div class="col-md-12">
                            <div class="page-header-title">
                                <h5 class="m-b-10">게시판 등록</h5>
                            </div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${path }/admin/"><i class="feather icon-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="#!" onclick="return false;">게시판 설정</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- [ breadcrumb ] end -->
            <!-- [ Main Content ] start -->
            <form action="${path }/admin/boardMgnAdd.do" method="post" name="frm1" onsubmit="return checkVal(this)">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card">
                            <div class="card-header">
                                <h5>게시판 등록</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">게시판 타입 설정</label>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="boardType0" name="boardType" class="custom-control-input" value="0" checked>
                                                <label class="custom-control-label" for="boardType0">게시판</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="boardType1" name="boardType" class="custom-control-input" value="1">
                                                <label class="custom-control-label" for="boardType1">문의하기</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label" for="boardNm">게시판 이름</label>
                                            <input type="text" class="form-control" name="boardNm" id="boardNm" aria-describedby="게시판 이름 도움" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">게시판 뎁스</label>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="depth0" name="depth" class="custom-control-input" value="1" checked onclick="changeType(this)">
                                                <label class="custom-control-label" for="depth0">메인</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="depth1" name="depth" class="custom-control-input" value="2" onclick="changeType(this)">
                                                <label class="custom-control-label" for="depth1">서브</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row forSub">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block" for="parNm">게시판 사용 강의 아이디</label>
                                            <input type="text" class="form-control d-inline-block" name="parNm" id="parNm" readonly style="width:calc(100% - 170px)">
                                            <input type="hidden" name="par" id="par">
                                            <button type="button" class="form-control ml-2 wid-150 d-inline-block" onclick="findLecture()">찾기</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">게시판 글 등록, 수정, 삭제 관련 설정</label>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="aboutAuth0" name="aboutAuth" class="custom-control-input" value="0" checked>
                                                <label class="custom-control-label" for="aboutAuth0">관리자</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="aboutAuth1" name="aboutAuth" class="custom-control-input" value="1">
                                                <label class="custom-control-label" for="aboutAuth1">선생님</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="aboutAuth2" name="aboutAuth" class="custom-control-input" value="2">
                                                <label class="custom-control-label" for="aboutAuth2">회원</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">댓글 설정</label>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="commentUse1" name="commentUse" class="custom-control-input" value="true">
                                                <label class="custom-control-label" for="commentUse1">사용</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="commentUse2" name="commentUse" class="custom-control-input" value="false" checked>
                                                <label class="custom-control-label" for="commentUse2">사용안함</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">파일 설정</label>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="fileUse1" name="fileUse" class="custom-control-input" value="true">
                                                <label class="custom-control-label" for="fileUse1">사용</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="fileUse2" name="fileUse" class="custom-control-input" value="false" checked>
                                                <label class="custom-control-label" for="fileUse2">사용안함</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-md-end">
                    <div class="col-md-1">
                        <button type="submit" class="btn btn-primary" style="width:100%;">등록</button>
                    </div>
                </div>
            </form>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
    <script>
        $(function (){
            $(".forSub").hide();
        });

        function findLecture() {
            let popupOption = "width=650px, height=550px, top=150px, left=300px, scrollbar=yes";
            let popupUrl = "${path }/admin/findLecture.do";
            window.open(popupUrl, 'child', popupOption);
        }

        function changeType(obj){
            let type = $(obj).val();

            if(type == 1) {
                $("#par").val(0);
                $("#parNm").val("");
                $(".forSub").hide();
            } else {
                $(".forSub").show();
            }
        }

        function checkVal(obj) {

            if(obj.depth.value == 1) {
                obj.parNm.value = "";
                obj.par.value = 0;
            }

            if(obj.depth.value == 2 && obj.par.value == 0){
                alert("게시판 사용 강의 아이디를 확인하세요!");
                obj.parNm.focus();
                return false;
            }

        }
    </script>
</body>
</html>