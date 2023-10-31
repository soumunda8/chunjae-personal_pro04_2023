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
    <script type="text/javascript" src="${path }/resources/ckeditor/ckeditor.js"></script>
    <style>
        /* Add your custom styles here */
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-header {
            padding: 50px 0;
            background-color: #f5f5f5;
        }

        .page-name {
            font-size: 36px;
            margin: 0;
        }

        .breadcrumb {
            margin: 10px 0;
            padding: 0;
            list-style: none;
        }

        .breadcrumb li {
            display: inline;
            margin-right: 5px;
        }

        .breadcrumb li.active {
            font-weight: bold;
        }

        .box_wrap {
            padding: 20px;
            border: 1px solid #ccc;
            margin-top: 20px;
        }

        .form_row {
            width: 100%;
        }

        table {
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        input[type="number"]{
            width: 120px;
        }

        .form-label {
            font-weight: bold;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
        }

        .form-select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #007BFF;
            color: #fff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        #naverPayBtn {
            background-image: url(${path}/resources/image/main/npay.png);
            background-size: cover;
            background-color: #03c75a;
            width: 120px;
            height: 50px;
            border: none;
        }

        #naverPayBtn {
            background-image: url(${path}/resources/image/main/npay.png);
            background-size: cover;
            background-color: #03c75a;
            width: 120px;
            height: 50px;
            border: none;
        }

        .can1 { width: 30% }
        .can2 { width: 15% }
        .can3 { width: 15% }
        .can4 { width: 40% }

        .row {
            margin-bottom: 5px;
        }

    </style>
</head>

<body id="body">
<jsp:include page="../layout/header.jsp" />

<section class="page-header" style="margin-top:0!important;">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="content">
                    <h1 class="page-name">상품 결제</h1>
                    <ol class="breadcrumb">
                        <li><a href="${path }/">Home</a></li>
                        <li class="active">상품 결제</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="container contents">
    <div class="container">
        <div class="box_wrap">
            <form action="${path }/payment/payinsert.do" method="post" class="form_row" onsubmit="return payCheck(this)">
                <table class="table" id="tb1">
                    <thead>
                    <tr>
                        <th class="can1" >강의 이름</th>
                        <th class="can2" >선생님</th>
                        <th class="can3" >강의 가격</th>
                        <th class="can4" >포인트 사용</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="can1" > ${lecture.title}
                            <input type="hidden" name="plec" id="plec" value="${lecture.title}">
                            <input type="hidden" name="pno" id="pno" value="${lecture.lno}">
                        </td>
                        <td class="can2"  >${lecture.teacherNm}
                            <input type="hidden" name="tecnm" id="tecnm" value="${lecture.teacherNm}">
                            <input type="hidden" name="booknm" id="booknm" value="${lecture.bookname}">
                        </td>
                        <td class="can3" >
                            <input type="number" name="total" id="total" style="border: none; text-align: center;" readonly value="${lecture.cost}">원
                        </td>
                        <td class="can4" style="text-align: center; border: none">
                            <input type="number" name="inpt" id="inpt" style="width: 160px; margin-top: 8px; ">
                            <input type="button" name="ptbtn" id="ptbtn" style="margin-left: 30px;" class="btn btn-primary" value="사용" onclick= "pointuse()">
                            <input type="button" name="ptbre" id="ptbre" class="btn btn-primary" value="취소" style="margin-left: 5px" onclick= "pointreset()">
                        </td>

                    </tr>
                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="2" class="text-center" style="font-weight: bold; font-size: 20px"> 총 계 </td>
                        <td>
                            <input type="number" name="price" id="price" value="" readonly style="border: none; text-align: center; font-weight: bold;"/>원
                        </td>
                        <td>
                            &nbsp&nbsp&nbsp사용가능한 포인트 :<input type="text" name="pt" id="pt" value="" readonly style="border: none; padding-left: 8px;"/>
                        </td>
                    </tr>
                    </tfoot>
                </table>

                <h3 style="display: inline-block">주문자 정보 </h3><p id="closebar1" style="display: inline-block" >▲</p>
                <section id="closebar2" style="display: block">
                <div class="row" >
                    <div class="col-2"><label for="nm" class="form-label">이름</label></div>
                    <div class="col-4"><input type="text" class="form-control" id="nm" name="nm" readonly value="${mem.nm}"></div>
                    <div class="col-2"><label for="tel" class="form-label">전화번호</label></div>
                    <div class="col-4"><input type="tel" class="form-control" id="tel" name="tel" readonly value="${mem.tel}"></div>
                    <input type="hidden" class="form-control" id="id" name="id" readonly value="${mem.id}">
                    <input type="hidden" class="form-control" id="amount" name="amount" readonly value="1">
                </div>
                <div class="row" >
                    <div class="col-2"><label for="email" class="form-label">이메일</label></div>
                    <div class="col-4"><input type="email" class="form-control" id="email" name="email" readonly value="${mem.email}"></div>

                </div>
                    <br>
                    <br>
                <div class="row">
                    <div class="col-2"><label for="addr1" class="form-label">기본 주소</label></div>
                    <div class="col-4"><input type="text" name="addr1" id="addr1" class="form-control" value="${mem.addr1}"  /></div>
                    <div class="col-2"><label for="addr2" class="form-label">상세 주소</label></div>
                    <div class="col-4"><input type="text" name="addr2" id="addr2" class="form-control" value="${mem.addr2}"  /></div>
                </div>
                <div class="row">
                    <div class="col-2"><label for="postcode" class="form-label">우편 번호</label></div>
                    <div class="col-4"><input type="text" name="postcode" id="postcode" value="${mem.postcode}"  class="form-control"></div>
                    <div class="col-2"></div>
                    <div class="col-4"><button type="button" id="post_btn" onclick="findAddr()" class="btn btn-primary">우편번호 검색</button></div>
                </div>
                </section>
                <hr>
                <h3>결제 정보</h3>
                <%--  Payment의 method, pcom, paccount --%>
                <div class="row">
                    <div class="col-2"><label for="pmethod" class="form-label">결제 수단</label></div>
                    <div class="col-4">
                        <select name="pmethod" id="pmethod" class="form-select">
                            <option value="선택">선택</option>
                            <option value="신용카드">신용카드</option>
                            <option value="체크카드">체크카드</option>
                            <option value="계좌이체">계좌이체</option>
                        </select>
                    </div>
                    <div class="col-2"><label for="pcom" class="form-label">결제 회사</label></div>
                    <div class="col-4">
                        <select name="pcom" id="pcom" class="form-select">
                            <option value="선택안함">선택안함</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2" id="labels1" >
                        <label for="pnum" class="form-label" >카드 번호</label></div>
                    <div class="col-2" id="labels2" style="display: none">
                        <label class="form-label" >계좌 번호</label></div>

                    <div class="col-6" id="labels3">
                        <input type="text" class="form-control" id="pnum" name="pnum" value="" required placeholder=" - 제외"></div>
                    <div class="col-6" id="labels4" style="display: none; color: black;">
                        <label class="form-label" >061702 - 04 - 152352</label></div>

                    <div class="col-2">
                        <input type="button" id="paybtn" value="결제하기" class="btn btn-primary">
                    </div>
                    <div class="col-2">
                        <input type="button" id="naverPayBtn" >
                    </div>
                </div>


                <%--  일단은 pay했다고 치기  --%>
                <input type="hidden" name="payCk" id="payCk" value="yes">
                <input type="submit" id="buy" value="구매" class="btn btn-primary">
                <a href="${path }/lecture/list.do" class="btn btn-primary">제품 목록</a>
            </form>

        </div>
    </div>
</div>
<jsp:include page="../layout/footer.jsp" />
</body>
</html>
<script>
    // 주문자 정보 close bar
        $(document).ready(function () {
            var sw = true;
            sw=!sw
            $("#closebar1").click(function () {
                $("#closebar2").slideToggle()
                if(sw==true){
                    $("#closebar1").text('▲');
                    sw = false
                }else if(sw==false) {
                    $("#closebar1").text('▼');
                    sw = true
                }
            });

    });

</script>
<script>
    // 포인트 계산
    $(document).ready(function() {
        let total = 0;
        total = $("#total").val()
        $("#price").val(total);
        $("#pt").val(${mem.pt})
    });
    function pointuse() {
        var total = $("#total").val();
        var inpoint = $("#inpt").val();
        var point = ${mem.pt}
            total = total - inpoint;
        point = point - inpoint;
        //포인트 정산
        if((0 < point) && (0 <= total) ){
            $("#pt").val(point);
            $("#price").val(total);
        }else if((0 > point) && (0 <= total) ) {
            $("#inpt").val(0).focus;
        }else if((0 === point) && (0 <= total) ){
            $("#pt").val(0);
            $("#price").val(total);
        }else{
            return false;
            $("#inpt").focus;
        }
    }
    function pointreset() {
        $("#price").val($("#total").val());
        $("#inpt").val(0);
        var point = ${mem.pt};
        $("#pt").val(point);
    }


</script>

<script>
    $(document).ready(function(){
        var cardArr1 = ["현대카드","농협카드","BC카드","KB카드"];
        var cardArr2 = ["하나카드","농협카드","BC카드"];
        var bankArr = ["카카오뱅크","농협은행","신한은행","기업은행","국민은행"];
            $("#pmethod").change(function(){
                var th = $(this).val();
                if(th==="신용카드"){
                    $("#pcom").val("");
                    for(var i=0;i<cardArr1.length;i++) {
                        $("#pcom").append("<option value='" + cardArr1[i] + "'>" + cardArr1[i] + "</option>");
                    }
                    $("#labels1").css("display", "block");
                    $("#labels3").css("display", "block");
                    $("#labels2").css("display", "none");
                    $("#labels4").css("display", "none");
                    $("#pnum").val("");
                } else if(th==="체크카드"){
                    $("#pcom").val("");
                    for(var i=0;i<cardArr2.length;i++) {
                        $("#pcom").append("<option value='"+cardArr2[i]+"'>"+cardArr2[i]+"</option>");
                    }
                    $("#labels1").css("display", "block");
                    $("#labels3").css("display", "block");
                    $("#labels2").css("display", "none");
                    $("#labels4").css("display", "none");
                    $("#pnum").val("");
                } else if(th==="계좌이체"){
                    $("#pcom").val("");
                    for (var i = 0; i < bankArr.length; i++) {
                        $("#pcom").append("<option value='" + bankArr[i] + "'>" + bankArr[i] + "</option>");
                    }
                    $("#labels1").css("display", "none");
                    $("#labels3").css("display", "none");
                    $("#pnum").val("계좌이체");
                    $("#labels2").css("display", "block");
                    $("#labels4").css("display", "block");
                }
        }).change();
    });
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //주소 연동 API
    function findAddr() {
        new daum.Postcode({
            oncomplete: function(data) {
                console.log(data);
                var roadAddr = data.roadAddress;
                var jibunAddr = data.jibunAddress;
                document.getElementById("postcode").value = data.zonecode;
                if(roadAddr !== '') {
                    document.getElementById("addr1").value = roadAddr;
                } else if(jibunAddr !== ''){
                    document.getElementById("addr1").value = jibunAddr;
                }
                document.getElementById("addr2").focus();
            }
        }).open();
    }
</script>
<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>
<script>
    var oPay = Naver.Pay.create({
        "mode" : "production", // development or production
        "clientId": "u86j4ripEt8LRfPGzQ8", // clientId
    });

    //직접 만드신 네이버페이 결제버튼에 click Event를 할당하세요
    var elNaverPayBtn = document.getElementById("naverPayBtn");
    var totalPayAmount = ${lecture.cost};
    elNaverPayBtn.addEventListener("click", function() {
        oPay.open({
            merchantUserKey: "12341234",
            merchantPayKey: "1524213",
            productName: $("#plec").val(),
            totalPayAmount: totalPayAmount,
            taxScopeAmount: totalPayAmount,
            taxExScopeAmount: "0",
            returnUrl: "${path}/payment/list.do"
        });
    });

</script>


<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
    $(document).ready(function(){
        $("#paybtn").click(function(){
        IMP.init('imp67615784'); // 결제 API를 사용하기 위한 코드 입력!
        IMP.request_pay({
            pg : 'T5102001',
            pay_method : 'card',
            merchant_uid: "order_no_0001", //상점에서 생성한 고유 주문번호
            name : $("#plec").val(),
            amount : $("#price").val(),
            buyer_email : 'iamport@siot.do',
            buyer_name : $('#nm').val(),
            buyer_tel : '010-1234-5678',
            buyer_addr : '서울특별시 강남구 삼성동',
            buyer_postcode : '123-456',
            m_redirect_url : '{모바일에서 결제 완료 후 리디렉션 될 URL}' // 예: https://www.my-service.com/payments/complete/mobile
        }, function(rsp) {
            if ( rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        var msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\n결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;

                        alert(msg);
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;

                alert(msg);
            }
        });
        })})
</script>