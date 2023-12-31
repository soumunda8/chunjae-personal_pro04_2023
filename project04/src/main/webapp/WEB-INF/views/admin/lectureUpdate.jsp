<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <jsp:include page="../layout/adminHead.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/admin.css" />
    <link rel="stylesheet" href="${path }/resources/cleditor/jquery.cleditor.css">
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
                                <h5 class="m-b-10">강의 설정</h5>
                            </div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${path }/admin/"><i class="feather icon-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="#!" onclick="return false;">강의 설정</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- [ breadcrumb ] end -->
            <!-- [ Main Content ] start -->
            <form action="${path }/admin/lectureEdit.do" name="frm1" method="post" enctype="multipart/form-data">
                <input type="hidden" name="lno" id="lno" value="${lecture.lno }">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card">
                            <div class="card-header">
                                <h5>강의 수정</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label" for="title">강의 제목</label>
                                            <input type="text" class="form-control" name="title" id="title" placeholder="강의 제목을 입력하세요." aria-describedby="강의 제목 도움" value="${lecture.title }" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label" for="subTitle">강의 소제목</label>
                                            <input type="text" class="form-control" name="subTitle" id="subTitle" placeholder="강의 소제목을 입력하세요." aria-describedby="강의 소제목 도움" value="${lecture.subTitle }" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label" for="content">내용</label>
                                            <textarea name="content" id="content" class="form-control" rows="8" cols="100" maxlength="1400" required>${lecture.content }</textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">강의 설정</label>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="lectureType0" name="lectureType" class="custom-control-input" value="0" onchange="changeType(this)"<c:if test="${lecture.lectureType eq 0 }"> checked</c:if>>
                                                <label class="custom-control-label" for="lectureType0">온라인</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="lectureType1" name="lectureType" class="custom-control-input" value="1" onchange="changeType(this)"<c:if test="${lecture.lectureType eq 1 }"> checked</c:if>>
                                                <label class="custom-control-label" for="lectureType1">오프라인</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">강의 설정</label>
                                            <c:forEach var="category" items="${categoryList }" varStatus="status">
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="category${status.count }" name="cateNo" class="custom-control-input" value="${category.cateNo }"<c:if test="${lecture.cateNo eq category.cateNo }"> checked</c:if>>
                                                    <label class="custom-control-label" for="category${status.count }">${category.CName }</label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <div class="row forOffline">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block" for="studentCnt">강의 인원수</label>
                                            <input type="number" class="form-control wid-150 d-inline-block" name="studentCnt" id="studentCnt" aria-describedby="인원수 입력" value="${lecture.studentCnt }" min="0" max="999"><p class="ml-2 d-inline-block">명</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="row forOffline">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">강의 일정</label>
                                            <fmt:parseDate value="${lecture.startDate }" var="startDate" pattern="yyyy-MM-dd HH:mm:ss" />
                                            <fmt:parseDate value="${lecture.endDate }" var="endDate" pattern="yyyy-MM-dd HH:mm:ss" />
                                            <fmt:formatDate value="${startDate }" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${endDate }" pattern="yyyy-MM-dd" /><br />
                                            <input type="hidden" name="originStartDate" value="${lecture.startDate }" />
                                            <input type="hidden" name="originEndDate" value="${lecture.endDate }" />
                                            <input type="date" class="form-control mr-1 wid-150 d-inline-block" name="startDate" value="${lecture.startDate }" id="startDate"> ~ <input type="date" class="form-control ml-1 wid-150 d-inline-block" name="endDate" value="${lecture.endDate }" id="endDate">
                                        </div>
                                    </div>
                                </div>
                                <div class="row forOffline">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label" for="daily">강의 하루 일정</label>
                                            <input type="text" class="form-control" placeholder="ex) 08:00 - 10:00" value="${lecture.daily }" name="daily" id="daily">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block" for="proNo">강의 서적</label>
                                            <input type="text" class="form-control d-inline-block" name="proNm" id="proNm" value="${lecture.proNm }" readonly style="width:calc(100% - 170px)">
                                            <input type="hidden" name="proNo" id="proNo" value="${lecture.proNo }">
                                            <button type="button" class="form-control ml-2 wid-150 d-inline-block" onclick="findPro()">찾기</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block" for="teacherId">강의 강사</label>
                                            <input type="text" class="form-control d-inline-block" name="teacherNm" id="teacherNm" value="${lecture.nm }" readonly style="width:calc(100% - 170px)">
                                            <input type="hidden" name="teacherId" id="teacherId" value="${lecture.teacherId }">
                                            <button type="button" class="form-control ml-2 wid-150 d-inline-block" onclick="findTeacher()">찾기</button>
                                        </div>
                                    </div>
                                </div>

                                <c:forEach var="files" items="${fileList }">
                                    <c:if test="${files.fileType eq 'image' }">
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-group">
                                                    <label class="floating-label d-block">강의 썸네일 업로드(10MB 이하)</label>
                                                    <p id="files1">${files.originNm } <button type="button" class="btn btn-primary px-2 py-0 ml-2" onclick="removeFiles(${files.fno }, 1)" style="font-size:0.8rem;">삭제</button></p>
                                                    <input type="file" class="form-control uploadThumbnail" name="uploadThumbnail" accept="image/*" id="uploadThumbnail" multiple>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${files.fileType eq 'video' }">
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-group">
                                                    <label class="floating-label d-block">강의 맛보기 영상 업로드(10MB 이하)</label>
                                                    <p id="files2">${files.originNm } <button type="button" class="btn btn-primary px-2 py-0 ml-2" onclick="removeFiles(${files.fno }, 2)" style="font-size:0.8rem;">삭제</button></p>
                                                    <input type="file" class="form-control uploadVideo" name="uploadVideo" id="uploadVideo" accept="video/*" multiple>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block" for="lPrice">강의 가격</label>
                                            <input type="number" class="form-control wid-150 d-inline-block" name="lPrice" id="lPrice" value="${lecture.LPrice }" aria-describedby="강의 가격 입력" min="0"><p class="ml-2 d-inline-block">원</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="floating-label d-block">사용 설정</label>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="useYn1" name="useYn" class="custom-control-input" value="true"<c:if test="${lecture.useYn }"> checked</c:if>>
                                                <label class="custom-control-label" for="useYn1">사용</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="useYn2" name="useYn" class="custom-control-input" value="false"<c:if test="${!lecture.useYn }"> checked</c:if>>
                                                <label class="custom-control-label" for="useYn2">사용안함</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-md-end">
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-primary" style="width:45%;">수정</button>
                        <a href="${path }/admin/getLecture.do?no=${lecture.lno }" class="btn btn-success" style="width:45%;">취소</a>
                    </div>
                </div>
            </form>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
    <script type="text/javascript" src="${path }/resources/cleditor/jquery.cleditor.js"></script>
    <script>
        $(document).ready(function() {
            $("#content").cleditor();
            <c:if test="${lecture.lectureType eq 0 }">
                $(".forOffline").hide();
            </c:if>
        });

        function changeType(obj){
            let type = $(obj).val();
            if(type == 0) {
                $("#studentCnt").val(999);
                $(".forOffline").hide();
                $('input[type="date"]').val(new Date().toISOString().substring(0, 10));
            } else {
                $("#studentCnt").val(0);
                $(".forOffline").show();
                $('input[type="date"]').val("");
            }
        }

        function removeFiles(fno, seq) {
            if(!confirm("해당 파일을 삭제하시겠습니까?")) {return false;}

            let params = {"fno" : fno};
            $.ajax({
                url:"${path }/util/fileRemove.do",
                type:"post",
                data:JSON.stringify(params),
                dataType:"json",
                contentType:"application/json",
                success : function(result) {
                    if(result === true) {
                        $("#files" + seq).remove();
                    }
                },
            });
        }

        function findPro() {
            let popupOption = "width=650px, height=550px, top=150px, left=300px, scrollbar=yes";
            let popupUrl = "${path }/admin/findPro.do";
            window.open(popupUrl, 'child', popupOption);
        }
        function findTeacher() {
            let popupOption = "width=650px, height=550px, top=150px, left=300px, scrollbar=yes";
            let popupUrl = "${path }/admin/findTeacher.do";
            window.open(popupUrl, 'child', popupOption);
        }
    </script>
</body>
</html>