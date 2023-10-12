<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>HEABEOP::회원가입</title>
    <jsp:include page="../layout/head.jsp" />
    <link rel="stylesheet" href="${path }/resources/css/sub.css">
</head>
<body>
<section class="bg-image join_area join my-5">
    <div class="mask d-flex align-items-center">
        <div class="container h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                    <div class="card">
                        <div class="card-body p-5">

                            <a class="logo text-center font-weight-bold text-secondary" href="${path }/" style="font-size:35px;"><img src="${path }/resources/image/common/logo.png" title="해법 로고" alt="해법 로고" />HAEBEOP</a>

                            <h2 class="text-uppercase text-center mt-3 mb-5">회원가입</h2>

                            <form name="frm1" id="frm1" action="${path }/user/joinPro.do" method="post" onsubmit="return joinCheck(this)">

                                <div class="form-outline mb-4">
                                    <input type="text" name="id" id="id" placeholder="영문소문자 및 숫자를 혼용하여 아이디 입력" class="form-control" pattern="^[a-z0-9]{8,16}" maxlength="16" autofocus required />
                                    <label class="form-label blind" for="id">아이디</label>
                                    <input type="button" class="btn check_btn" value="아이디 중복 확인" onclick="idCheck()">
                                    <input type="hidden" name="idCk" id="idCk" value="no">
                                    <c:if test="${empty qid }">
                                        <p id="msg" class="no_check"><i class="fas fa-times-circle"></i> 아직 아이디 중복 체크를 하지 않으셨습니다.</p>
                                    </c:if>
                                    <c:if test="${not empty qid }">
                                        <p id="msg"><i class="fas fa-check"></i> 아이디 중복 체크후 수정하였습니다.</p>
                                    </c:if>
                                </div>

                                <div class="form-outline mb-1">
                                    <input type="password" name="pw" id="pw" placeholder="비밀번호 입력" class="form-control" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$" maxlength="16" required />
                                    <label class="form-label blind" for="pw">비밀번호</label>
                                    <p class="info mb-0"><i class="fas fa-check"></i> 비밀번호는 최소 8자리에서 최대 16자리까지 숫자, 영문, 특수문자 각 1개 이상 포함</p>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="password" name="pw2" id="pw2" placeholder="비밀번호  확인 입력" class="form-control" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$" maxlength="16" required />
                                    <label class="form-label blind" for="pw2">비밀번호 확인</label>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="text" name="nm" id="nm" placeholder="이름 입력" class="form-control" required />
                                    <label class="form-label blind" for="nm">이름</label>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="email" name="email" id="email" placeholder="이메일 입력" class="form-control" required>
                                    <label class="form-label blind" for="email">이메일</label>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="date" name="birth" id="birth" placeholder="생년월일 입력" class="form-control" required>
                                    <label class="form-label blind" for="birth">생년월일</label>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="tel" name="tel" id="tel" maxlength="13" placeholder="전화번호 숫자만 입력 000-0000-0000" class="form-control" required>
                                    <label class="form-label blind" for="tel">전화번호</label>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="text" name="address1" id="address1" placeholder="기본 주소 입력" class="form-control" required />
                                    <input type="text" name="address2" id="address2" placeholder="상세 주소 입력" class="form-control" required />
                                    <input type="text" name="postcode" id="postcode" placeholder="우편번호" class="form-control">
                                    <button type="button" id="post_btn" onclick="findAddr()" class="btn">우편번호 검색</button>
                                    <label class="form-label blind" for="address1">주소</label>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <button type="submit" class="btn px-5 py-2 mt-4" style="font-size:20px">회원가입</button>
                                </div>

                            </form>

                            <script src="${path }/resources/js/jquery-3.7.1.min.js"></script>
                            <script>
                                $(document).ready(function(){
                                    $("#id").keyup(function(){
                                        $("#idCk").val("no");
                                        if($(this).val()!=""){
                                            if($("#msg").hasClass("no_check")) {
                                                $("#msg").removeClass("no_check");
                                            }
                                            $("#msg").html("아이디 입력중입니다.");
                                            $("#id").focus();
                                        } else {
                                            $("#msg").addClass("no_check").html("<i class='fas fa-times-circle'></i> 아직 아이디 중복 체크를 하지 않으셨습니다.");
                                        }
                                    });
                                });
                                function idCheck(){
                                    if($("#id").val()==""){
                                        alert("아이디를 입력하지 않았습니다.");
                                        $("#id").focus();
                                        return false;
                                    }

                                    var params = {"id" : $("#id").val()};
                                    $.ajax({
                                        url:"${path }/user/idCheckPro.do",	//아이디가 전송되어질 곳
                                        type:"post",
                                        data:JSON.stringify(params),
                                        dataType:"json",
                                        contentType:"application/json",
                                        success : function(result) {
                                            var idPass = result;
                                            if(idPass == false){
                                                $("#idCk").val("no");
                                                $("#msg").addClass("no_check").html("<i class='fas fa-times-circle'></i> 기존에 사용되고 있는 아이디입니다. 다시 입력하시기 바랍니다.");
                                                $("#id").focus();
                                            } else if(idPass == true){
                                                $("#idCk").val("yes");
                                                if($("#msg").hasClass("no_check")) {
                                                    $("#msg").removeClass("no_check");
                                                }
                                                $("#msg").html("<i class='fas fa-check'></i> 사용 가능한 아이디입니다.");
                                            } else if(idPass==""){
                                                $("#msg").addClass("no_check").text("<i class='fas fa-times-circle'></i> 아이디가 확인되지 않았습니다. 다시 시도하시기 바랍니다.");
                                            }
                                        }
                                    });
                                }

                                function joinCheck(f){
                                    if(f.pw.value!=f.pw2.value){
                                        alert("비밀번호와 비밀번호 확인이 서로 다릅니다.");
                                        f.pw.focus();
                                        return false;
                                    }
                                    if(f.idCk.value!="yes"){
                                        alert("아이디 중복 체크를 하지 않으셨습니다.");
                                        return false;
                                    }
                                }
                            </script>

                            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
                            <script src="${path }/resources/js/common.js"></script>
                            <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>