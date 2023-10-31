<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP</title>
    <jsp:include page="./layout/head.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/main.css">
    <link rel="stylesheet" href="${path }/resources/css/owl.carousel.css" />
</head>
<body>
    <jsp:include page="./layout/header.jsp" />
    <div class="container-fluid bg-primary px-0 px-md-5 mb-5">
        <div class="row align-items-center px-3">
            <div class="col-lg-6 text-center">
                <h4 class="text-white mb-4 mt-5 mt-lg-0">에듀 강의 교육 센터</h4>
                <h1 class="display-4 font-weight-bold text-white">새로운 학습 관련 홈페이지</h1>
                <p class="text-white mb-4">
                    많은 강의를 확인해보세요.<br />
                    새롭고 신기한 강의들이 많이 있습니다.<br />
                    많이 활용하세요.<br />
                </p>
            </div>
            <div class="col-lg-6 text-center">
                <img class="img-fluid2 my-5" src="${path }/resources/image/main/header.png" alt="메인 썸네일 이미지" />
            </div>
        </div>
    </div>

    <div class="container text-center mb-5" style="height:30vh;line-height:30vh;font-size:5rem;font-weight:bold;">
        홈페이지 준비중입니다.
    </div>

    <%--<div class="container-fluid mb-5">
        <div class="container">
            <div class="text-center pb-2">
                <p class="section-title px-5"><span class="px-2">AN UPCOMING LECTURE</span></p>
                <h1 class="mb-4">많은 강의들을 확인하세요.</h1>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="card border-0 bg-light shadow-sm pb-2">
                        <img class="card-img-top mb-2" src="${path }/resources/image/main/class-1.jpg" alt="강의1 이미지" />
                        <div class="card-body text-center">
                            <h4 class="card-title">강의1</h4>
                            <p class="card-text">
                                강의1에 관한 설명입니다.<br />
                                강의1은 이것저것입니다.
                            </p>
                        </div>
                        <div class="card-footer bg-transparent py-4 px-5">
                            <div class="row border-bottom">
                                <div class="col-6 py-1 text-right border-right">
                                    <strong>교육 인원</strong>
                                </div>
                                <div class="col-6 py-1">40명</div>
                            </div>
                            <div class="row border-bottom">
                                <div class="col-6 py-1 text-right border-right">
                                    <strong>교육 강사</strong>
                                </div>
                                <div class="col-6 py-1">김리자 강사</div>
                            </div>
                            <div class="row">
                                <div class="col-6 py-1 text-right border-right">
                                    <strong>교육 가격</strong>
                                </div>
                                <div class="col-6 py-1">10000원</div>
                            </div>
                        </div>
                        <a href="#" class="btn btn-primary px-4 mx-auto mb-4">신청하기</a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card border-0 bg-light shadow-sm pb-2">
                        <img class="card-img-top mb-2" src="${path }/resources/image/main/class-2.jpg" alt="강의2 이미지" />
                        <div class="card-body text-center">
                            <h4 class="card-title">강의2</h4>
                            <p class="card-text">
                                강의2에 관한 설명입니다<br />
                                강의2은 이것저것입니당.
                            </p>
                        </div>
                        <div class="card-footer bg-transparent py-4 px-5">
                            <div class="row border-bottom">
                                <div class="col-6 py-1 text-right border-right">
                                    <strong>교육 인원</strong>
                                </div>
                                <div class="col-6 py-1">40명</div>
                            </div>
                            <div class="row border-bottom">
                                <div class="col-6 py-1 text-right border-right">
                                    <strong>교육 강사</strong>
                                </div>
                                <div class="col-6 py-1">최리자 강사</div>
                            </div>
                            <div class="row">
                                <div class="col-6 py-1 text-right border-right">
                                    <strong>교육 가격</strong>
                                </div>
                                <div class="col-6 py-1">10000원</div>
                            </div>
                        </div>
                        <a href="#" class="btn btn-primary px-4 mx-auto mb-4">신청하기</a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card border-0 bg-light shadow-sm pb-2">
                        <img class="card-img-top mb-2" src="${path }/resources/image/main/class-3.jpg" alt="강의3 이미지" />
                        <div class="card-body text-center">
                            <h4 class="card-title">강의3</h4>
                            <p class="card-text">
                                강의3에 관한 설명입니다<br />
                                강의3은 이것저것입니당.
                            </p>
                        </div>
                        <div class="card-footer bg-transparent py-4 px-5">
                            <div class="row border-bottom">
                                <div class="col-6 py-1 text-right border-right">
                                    <strong>교육 인원</strong>
                                </div>
                                <div class="col-6 py-1">40명</div>
                            </div>
                            <div class="row border-bottom">
                                <div class="col-6 py-1 text-right border-right">
                                    <strong>교육 강사</strong>
                                </div>
                                <div class="col-6 py-1">박리자 강사</div>
                            </div>
                            <div class="row">
                                <div class="col-6 py-1 text-right border-right">
                                    <strong>교육 가격</strong>
                                </div>
                                <div class="col-6 py-1">10000원</div>
                            </div>
                        </div>
                        <a href="#" class="btn btn-primary px-4 mx-auto mb-4">신청하기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid mb-5">
        <div class="container">
            <div class="text-center pb-2">
                <p class="section-title px-5">
                    <span class="px-2">Our Teachers</span>
                </p>
                <h1 class="mb-4">강사님들을 만나보세요.</h1>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-3 text-center team">
                    <div class="position-relative overflow-hidden mb-4" style="border-radius: 100%">
                        <img class="img-fluid w-100" src="${path }/resources/image/main/team-1.jpg" alt="선생님1의 이미지" />
                        <div class="team-social d-flex align-items-center justify-content-center w-100 h-100 position-absolute">
                            <a class="btn btn-outline-light text-center mr-2 px-0" style="width: 38px; height: 38px" href="#"><i class="fas fa-phone-alt"></i></a>
                            <a class="btn btn-outline-light text-center px-0" style="width: 38px; height: 38px" href="#" ><i class="fas fa-envelope"></i></a>
                        </div>
                    </div>
                    <h4 class="mb-0">최리자</h4>
                </div>
                <div class="col-md-6 col-lg-3 text-center team">
                    <div class="position-relative overflow-hidden mb-4" style="border-radius: 100%">
                        <img class="img-fluid w-100" src="${path }/resources/image/main/team-2.jpg" alt="선생님2의 이미지" />
                        <div class="team-social d-flex align-items-center justify-content-center w-100 h-100 position-absolute">
                            <a class="btn btn-outline-light text-center mr-2 px-0" style="width: 38px; height: 38px" href="#"><i class="fas fa-phone-alt"></i></a>
                            <a class="btn btn-outline-light text-center px-0" style="width: 38px; height: 38px" href="#" ><i class="fas fa-envelope"></i></a>
                        </div>
                    </div>
                    <h4 class="mb-0">박리자</h4>
                </div>
                <div class="col-md-6 col-lg-3 text-center team">
                    <div class="position-relative overflow-hidden mb-4" style="border-radius: 100%">
                        <img class="img-fluid w-100" src="${path }/resources/image/main/team-3.jpg" alt="선생님3의 이미지" />
                        <div class="team-social d-flex align-items-center justify-content-center w-100 h-100 position-absolute">
                            <a class="btn btn-outline-light text-center mr-2 px-0" style="width: 38px; height: 38px" href="#"><i class="fas fa-phone-alt"></i></a>
                            <a class="btn btn-outline-light text-center px-0" style="width: 38px; height: 38px" href="#" ><i class="fas fa-envelope"></i></a>
                        </div>
                    </div>
                    <h4 class="mb-0">김리자</h4>
                </div>
                <div class="col-md-6 col-lg-3 text-center team">
                    <div class="position-relative overflow-hidden mb-4" style="border-radius: 100%">
                        <img class="img-fluid w-100" src="${path }/resources/image/main/team-4.jpg" alt="선생님4의 이미지" />
                        <div class="team-social d-flex align-items-center justify-content-center w-100 h-100 position-absolute">
                            <a class="btn btn-outline-light text-center mr-2 px-0" style="width: 38px; height: 38px" href="#"><i class="fas fa-phone-alt"></i></a>
                            <a class="btn btn-outline-light text-center px-0" style="width: 38px; height: 38px" href="#" ><i class="fas fa-envelope"></i></a>
                        </div>
                    </div>
                    <h4 class="mb-0">이리자</h4>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid py-5">
        <div class="container p-0">
            <div class="text-center pb-2">
                <p class="section-title px-5">
                    <span class="px-2">Testimonial</span>
                </p>
                <h1 class="mb-4">최고의 리뷰를 확인하세요.</h1>
            </div>
            <div class="owl-carousel testimonial-carousel">
                <div class="testimonial-item px-3">
                    <div class="bg-light shadow-sm rounded mb-4 p-4">
                        <h3 class="fas fa-quote-left text-primary mr-3"></h3>
                        이걸 내가 쓰면 누간가가 볼까요?내생각엔 안볼것 같은데, 오타작살나도 모르고그냥 이렇게 쓰면되겠ㅈ?
                    </div>
                    <div class="d-flex align-items-center pl-4">
                        <h5 class="d-inline mb-0">작성자</h5>
                        <p class="d-inline pl-4 mb-0" style="font-size:1.25rem;">김이름</p>
                    </div>
                </div>
                <div class="testimonial-item px-3">
                    <div class="bg-light shadow-sm rounded mb-4 p-4">
                        <h3 class="fas fa-quote-left text-primary mr-3"></h3>
                        이걸 내가 쓰면 누간가가 볼까요?내생각엔 안볼것 같은데, 오타작살나도 모르고그냥 이렇게 쓰면되겠ㅈ?
                    </div>
                    <div class="d-flex align-items-center pl-4">
                        <h5 class="d-inline mb-0">작성자</h5>
                        <p class="d-inline pl-4 mb-0" style="font-size:1.25rem;">박이름</p>
                    </div>
                </div>
                <div class="testimonial-item px-3">
                    <div class="bg-light shadow-sm rounded mb-4 p-4">
                        <h3 class="fas fa-quote-left text-primary mr-3"></h3>
                        이걸 내가 쓰면 누간가가 볼까요?내생각엔 안볼것 같은데, 오타작살나도 모르고그냥 이렇게 쓰면되겠ㅈ?
                    </div>
                    <div class="d-flex align-items-center pl-4">
                        <h5 class="d-inline mb-0">작성자</h5>
                        <p class="d-inline pl-4 mb-0" style="font-size:1.25rem;">최이름</p>
                    </div>
                </div>
                <div class="testimonial-item px-3">
                    <div class="bg-light shadow-sm rounded mb-4 p-4">
                        <h3 class="fas fa-quote-left text-primary mr-3"></h3>
                        언제하지 개인프로젝트..?ㅎㅎ
                    </div>
                    <div class="d-flex align-items-center pl-4">
                        <h5 class="d-inline mb-0">작성자</h5>
                        <p class="d-inline pl-4 mb-0" style="font-size:1.25rem;">이이름</p>
                    </div>
                </div>
            </div>
        </div>
    </div>--%>

    <jsp:include page="./layout/footer.jsp" />
    <script src="${path }/resources/js/owl.carousel.min.js"></script>
    <script src="${path }/resources/js/main.js"></script>
</body>
</html>