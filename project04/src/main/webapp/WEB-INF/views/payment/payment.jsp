<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::</title>
    <jsp:include page="../layout/head.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/sub.css">
    <%--<script type="text/javascript" src="${path }/resources/ckeditor/ckeditor.js"></script>--%>
    <style>
        .table th, .table td {
            vertical-align:middle;
        }
    </style>
</head>

<body id="body">
<jsp:include page="../layout/header.jsp" />

<div class="container">
    <div class="row d-flex justify-content-center">
        <div class="col-md-8 my-5">
            <div class="box_wrap my-5 p-5 border">
                <form action="${path }/payment/pay.do" method="post" onsubmit="return checkPay()">
                    <input type="hidden" name="lno" id="lno" value="${lecture.lno }" />
                    <input type="hidden" name="payPrice" id="payPrice" value="${sumPrice }" />
                    <input type="hidden" id="myOriginPt" value="${member.pt }" />
                    <c:if test="${sumPrice == 0 }"><input type="hidden" name="payCk" id="payCk" value="true"></c:if>
                    <c:if test="${sumPrice != 0 }"><input type="hidden" name="payCk" id="payCk" value="false"></c:if>

                    <h3>강의 정보</h3>
                    <table class="table table-bordered">
                        <colgroup>
                            <col style="width:30%" />
                            <col style="width:auto" />
                        </colgroup>
                        <tr>
                            <th class="text-center py-2">강의 이름</th>
                            <td class="pl-1 py-2">${lecture.title }</td>
                        </tr>
                        <tr>
                            <th class="text-center py-2">강의 선생님</th>
                            <td class="pl-1 py-2">${lecture.nm } 선생님</td>
                        </tr>
                        <tr>
                            <th class="text-center py-2">강의 가격<br ><span style="font-size:0.8em;color:#666;">서적 포함 가격</span></th>
                            <td class="pl-1 py-2">
                                <fmt:formatNumber value="${sumPrice }" pattern="#,###" /> 원
                                <input type="hidden" id="lecturePrice" value="${sumPrice }" />
                            </td>
                        </tr>
                        <tr>
                            <th class="text-center py-2">포인트 사용</th>
                            <td class="pl-1 py-2">
                                <button type="button" class="btn btn-primary py-1" onclick="userPoint()">전액 사용</button>
                                <button type="button" class="btn btn-success ml-2 py-1" onclick="cancelPoint()">취소</button>
                            </td>
                        </tr>
                        <tr>
                            <th class="text-center py-2">사용가능한 포인트</th>
                            <td class="pl-1 py-2"><span id="myPoint">${member.pt }</span> 점</td>
                        </tr>
                        <tr>
                            <th class="text-center py-2">총 가격</th>
                            <td class="pl-1 py-2"><span id="totalPrice"><fmt:formatNumber value="${sumPrice }" pattern="#,###" /></span> 원</td>
                        </tr>
                    </table>
                    <hr class="my-3" />

                    <h3>주문자 정보</h3>
                    <table class="table table-bordered">
                        <colgroup>
                            <col style="width:30%" />
                            <col style="width:auto" />
                        </colgroup>
                        <tr>
                            <th class="text-center py-2">주문자 이름</th>
                            <td class="pl-1 py-2">${member.nm }</td>
                        </tr>
                        <tr>
                            <th class="text-center py-2">주문자 전화번호</th>
                            <td class="pl-1 py-2">${member.tel }</td>
                        </tr>
                        <tr>
                            <th class="text-center py-2">주문자 이메일</th>
                            <td class="pl-1 py-2">${member.email }</td>
                        </tr>
                        <tr>
                            <th class="text-center py-2">주문자 주소</th>
                            <td class="pl-1 py-2">
                                <input type="text" name="cusPostcode" id="postcode" class="form-control mb-1" value="${member.postcode }" required/>
                                <input type="text" name="cusAddr1" id="address1" class="form-control mb-1" value="${member.addr1 }" required/>
                                <input type="text" name="cusAddr2" id="address2" class="form-control mb-1" value="${member.addr2 }" required/>
                                <button type="button" onclick="findAddr()" class="btn btn-primary">우편번호 검색</button>
                            </td>
                        </tr>
                        <script src="${path }/resources/js/common.js"></script>
                        <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                    </table>
                    <hr class="my-3" />

                    <c:if test="${sumPrice != 0}">
                        <h3 class="payInfo">결제 정보</h3>
                        <table class="table table-bordered payInfo">
                            <colgroup>
                                <col style="width:30%" />
                                <col style="width:auto" />
                            </colgroup>
                            <tr>
                                <th class="text-center py-2"><label for="pMethod">결제 수단</label></th>
                                <td class="pl-1 py-2">
                                    <select name="pMethod" id="pMethod" class="form-control" required>
                                        <option value="">선택</option>
                                        <option value="1">신용카드</option>
                                        <option value="2">체크카드</option>
                                        <option value="3">계좌이체</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th class="text-center py-2"><label for="pCom">결제 회사</label></th>
                                <td class="pl-1 py-2">
                                    <select name="pCom" id="pCom" class="form-control" required>
                                        <option value="">선택</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th class="text-center py-2"><label for="pNum" id="pNumLabel">카드번호</label></th>
                                <td class="pl-1 py-2">
                                    <input type="text" name="pNum" id="pNum" class="form-control" placeholder=" - 는 제외하고 적어주세요." required/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="text-center">
                                    <input type="button" value="결제하기" id="payBtn" class="btn btn-primary" onclick="payApi()">
                                </td>
                            </tr>
                        </table>
                    </c:if>
                    <div class="btn-group d-block text-center">
                        <input type="submit" id="buy" value="구매" class="btn btn-primary">
                        <a href="${path }/lecture/get.do?lno=${lecture.lno }" class="btn btn-success">돌아가기</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />
</body>
</html>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
    $(function() {
        let cardArr1 = ["현대카드", "농협카드", "BC카드"];
        let cardArr2 = ["농협카드", "BC카드", "KB카드"];
        let bankArr = ["카카오뱅크", "농협은행", "신한은행", "기업은행", "국민은행"];
        $("#pMethod").on("change", function() {
            let type = $("#pMethod").val();
            let check = "";
            $("#pCom").html("<option value=''>선택</option>");
            $("#pNum").val("");
            $("#pNumLabel").text("카드번호");
            if(type === "1"){
                check = cardArr1;
            } else if(type === "2") {
                check = cardArr2;
            } else if(type === "3") {
                check = bankArr;
                $("#pNum").val("XXXX-XXXX-XXXX");
                $("#pNumLabel").text("계좌번호");
            } else {
                alert("잘못된 결제 수단입니다!");
                return false;
            }
            for (var i = 0; i < check.length; i++) {
                $("#pCom").append("<option value='" + check[i] + "'>" + check[i] + "</option>");
            }
        });
    });

    function userPoint() {
        let myPoint = $("#myPoint");
        if(myPoint.text() === "0") return false;
        let lecturePrice = $("#lecturePrice").val();
        let totalPrice = lecturePrice - parseInt(myPoint.text());
        if(totalPrice === 0) {
            $(".payInfo").hide();
        }
        $("#payPrice").val(totalPrice);
        totalPrice = totalPrice.toLocaleString();
        $("#totalPrice").text(totalPrice);
        myPoint.text(0);
    }

    function cancelPoint() {
        let payPrice = $("#payPrice");
        let lecturePrice = $("#lecturePrice").val();
        $("#totalPrice").text(lecturePrice.toLocaleString());
        payPrice.val(lecturePrice);
        $("#myPoint").text($("#myOriginPt").val());
        if(payPrice.val() !== "0") {
            $(".payInfo").show();
        }
    }

    function payApi() {
        var d = new Date();
        var date = d.getFullYear()+''+(d.getMonth()+1)+''+d.getDate()+''+d.getHours()+''+d.getMinutes()+''+d.getSeconds();
        var IMP = window.IMP;               // 생략가능
        IMP.init('imp73810516');            // 결제 API를 사용하기 위한 코드 입력!
        IMP.request_pay({                 //결제 요청
            pg: 'kicc',
            merchant_uid : '${lecture.title }_' + date, //상점 거래 ID
            name :"${lecture.title }",               // 결제 명
            amount : $("#payPrice").val(),                  // 결제금액
            buyer_email : "${member.email }",  // 구매자 email
            buyer_name : "${member.nm }",      // 구매자 이름
            buyer_tel : "${member.tel }"     // 구매자 전화번호
        }, function(rsp){
            if(rsp.success){
                $("#payCk").val("true");
                $("#payBtn").hide();
            } else{
                alert('결제에 실패했습니다. 에러 내용: ' + rsp.error_msg);
                $("#payCk").val("true");
                $("#payBtn").hide();
            }
        });
    }

    function checkPay() {

        if($("#payCk").val() === "false") {
            alert("결제하기를 완료해주세요.");
            return false;
        }

    }
</script>