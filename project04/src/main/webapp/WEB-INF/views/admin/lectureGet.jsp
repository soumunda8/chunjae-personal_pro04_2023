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
            <div class="row">
                <div class="col-xl-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>강의 상세보기</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label" for="title">강의 제목</label>
                                        <input type="text" class="form-control" name="title" id="title" placeholder="강의 제목을 입력하세요." aria-describedby="강의 제목 도움" value="${lecture.title }" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label" for="subTitle">강의 소제목</label>
                                        <input type="text" class="form-control" name="subTitle" id="subTitle" placeholder="강의 소제목을 입력하세요." aria-describedby="강의 소제목 도움" value="${lecture.subTitle }" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label">내용</label>
                                        <div style="border:3px solid #ccc;border-radius:10px;" class="p-1">
                                            ${lecture.content }
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block">강의 설정</label>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="lectureType0" name="lectureType" class="custom-control-input" value="0" onclick="return false"<c:if test="${lecture.lectureType == 0 }"> checked</c:if>>
                                            <label class="custom-control-label" for="lectureType0">온라인</label>
                                        </div>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="lectureType1" name="lectureType" class="custom-control-input" value="1" onclick="return false"<c:if test="${lecture.lectureType == 1 }"> checked</c:if>>
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
                                                <input type="radio" id="category${status.count }" name="cateNo" class="custom-control-input" value="${category.cateNo }" onclick="return false"<c:if test="${lecture.cateNo eq category.cateNo }"> checked</c:if>>
                                                <label class="custom-control-label" for="category${status.count }">${category.CName }</label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${lecture.lectureType == 1 }">
                            <div class="row forOffline">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block" for="studentCnt">강의 인원수</label>
                                        <input type="number" class="form-control wid-150 d-inline-block" name="studentCnt" id="studentCnt" aria-describedby="인원수 입력" value="${lecture.studentCnt }" readonly min="0" max="999"><p class="ml-2 d-inline-block">명</p>
                                    </div>
                                </div>
                            </div>
                            <div class="row forOffline">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block">강의 일정</label>
                                        <fmt:parseDate value="${lecture.startDate }" var="startDate" pattern="yyyy-MM-dd HH:mm:ss" />
                                        <fmt:parseDate value="${lecture.endDate }" var="endDate" pattern="yyyy-MM-dd HH:mm:ss" />
                                        <fmt:formatDate value="${startDate }" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${endDate }" pattern="yyyy-MM-dd" />
                                    </div>
                                </div>
                            </div>
                            <div class="row forOffline">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label" for="daily">강의 하루 일정</label>
                                        <input type="text" class="form-control" placeholder="ex) 08:00 - 10:00" value="${lecture.daily }" readonly name="daily" id="daily">
                                    </div>
                                </div>
                            </div>
                            </c:if>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block" for="proNm">강의 서적</label>
                                        <input type="text" class="form-control d-inline-block" name="proNm" id="proNm" value="${lecture.proNm }" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block" for="teacherNm">강의 강사</label>
                                        <input type="text" class="form-control d-inline-block" name="teacherNm" id="teacherNm" value="${lecture.nm }" readonly>
                                    </div>
                                </div>
                            </div>
                            <c:forEach var="files" items="${fileList }">
                                <c:if test="${files.fileType eq 'image' }">
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-group">
                                                <label class="floating-label d-block">강의 썸네일 업로드(10MB 이하)</label>
                                                <img src="${path }/resources/upload/${files.saveFolder }/${files.saveNm }" alt="${files.originNm }" />
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${files.fileType eq 'video' }">
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-group">
                                                <label class="floating-label d-block">강의 맛보기 영상 업로드(10MB 이하)</label>
                                                <video height="180" width="300" controls>
                                                    <source src="${path }/resources/upload/${files.saveFolder }/${files.saveNm }" type="video/mp4">
                                                    이 문장은 여러분의 브라우저가 video 태그를 지원하지 않을 때 화면에 표시됩니다!
                                                </video>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block" for="lPrice">강의 가격</label>
                                        <input type="number" class="form-control wid-150 d-inline-block" name="lPrice" id="lPrice" value="${lecture.LPrice }" aria-describedby="강의 가격 입력" min="0" readonly><p class="ml-2 d-inline-block">원</p>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label class="floating-label d-block">사용 설정</label>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="useYn1" name="useYn" class="custom-control-input" value="true" onclick="return false"<c:if test="${lecture.useYn }"> checked</c:if>>
                                            <label class="custom-control-label" for="useYn1">사용</label>
                                        </div>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" id="useYn2" name="useYn" class="custom-control-input" value="false" onclick="return false"<c:if test="${!lecture.useYn }"> checked</c:if>>
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
                <div class="col-md-4">
                    <a href="${path }/admin/lectureConf.do" class="btn btn-primary" style="width:32%;">목록</a>
                    <a href="${path }/admin/lectureEdit.do?no=${lecture.lno }" class="btn btn-success" style="width:32%;">수정</a>
                    <a href="${path }/admin/lectureDel.do?no=${lecture.lno }" class="btn btn-primary" style="width:32%;">삭제</a>
                </div>
            </div>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <jsp:include page="../layout/adminFooter.jsp" />
</body>
</html>