<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Join FileRoom Service</title>
<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<script src="/resources/js/jquery-1.12.4.min.js"></script>
<script src="/resources/js/common.js"></script>
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
function idCheck(id,callback,error){//아이디체크
	console.log(" idcheck")
	console.log(id)
$.get('/register/idcheck/'+id,function(result){
		alert(result)
	}).fail(function(xhr,status,err){
		if(error){
			error()
		}
})
}
function emailCheck(email1,email2,callback,error){//아이디체크
	console.log("emailcheck")
$.get('/register/emailcheck/'+email1+"/"+email2,function(result){
		alert(result)
	}).fail(function(xhr,status,err){
		if(error){
			error()
		}
})
}
$(document).on("ready",function(){
	$("#idCheck").on("click",function(){
		console.log($("#userid1").val())
		idCheck($("#userid1").val())
	})
	$("#emailCheck").on("click",function(){
		console.log($("#useremail").val())
		emailCheck($("#useremail").val())
	})
})
</script>
</head>
<body>
	<div id="wrapper">
		<!-- header starts -->
		<jsp:include page="./include/header.jsp" />
		<!-- header ends -->
		<div id="container">
			<div id="mainVisualWrap">
				<div id="mainVisual">
					<p class="imgArea">
					<h2>메인비쥬얼</h2>
					<!-- <img src="./images/bg_landing.jpg" alt="메인비주얼"/> -->
					</p>
					<p class="textArea">
						Welcome to our <span>Mini&nbsp;Cloud</span>, <strong>FileRoom</strong>
					</p>
				</div>
			</div>
			<div class="contentsWrap">
				<section id="formArea">
					<h2>통합회원가입 감싸는 영역</h2>
					<h3 class="hide">FileRoom 클라우드 회원가입</h3>
					<div id="registWrap">
						<h2>통합회원가입 감싸는 영역</h2>
						<h3>FileRoom Service 회원가입</h3>
						<div id="registArea">
							<h2>통합회원가입 영역</h2>
							<div id="registerBox">
								<h2>가입양식 작성영역</h2>
								<form action="/member/join" method="post">
									<fieldset id="membership">
										<legend>
											Member's Information<span>(필수항목)</strong></span>
										</legend>
										<ul id="signUp">
											<li><label for="userid1">USERID</label><input
												id="userid1" type="text" name="userid"
												placeholder="Your ID to use" required="required"
												maxlength="13" autofocus="on" autocomplete="off" /> <input
												id="idCheck" type="button" name="idCheck" title="ID중복확인"
												value="ID 중복확인" required="required" /></li>
											<li><label for="userpw1">PASSWORD</label><input
												id="userpw1" type="password" name="userpw1"
												placeholder="Your PW to use" required="required"
												maxlength="13" autocomplete="off" /></li>
											<li><label for="userpw2">PASSWORD Check</label><input
												id="userpw2" type="password" name="userpw2"
												placeholder="Your PW again" required="required"
												maxlength="13" autocomplete="off" /></li>
											<li><label for="userName">이름</label><input id="userName"
												type="text" name="username" placeholder="성명"
												required="required" maxlength="10" min="2" /></li>
											<li class="email specific">
												<label for="useremail">Email</label><!-- 
											 --><p class="emailInputArea">
													<input
													id="useremail" type="text" name="useremail1"
													placeholder="yourEmailID" required="required" /><!--
												 --><span>@</span><!-- 
												 --><input
													id="useremail2" type="text" name="useremail2"
													placeholder="yourEmailHost" required="required" />
												</p>
												<input
													id="emailCheck" type="button" name="emailCheck"
													title="email중복확인" value="Email 중복확인" required="required" />
												<span class="caution">아이디 비밀번호 분실 시 필요한 정보이므로, 정확하게
													기입해 주십시오.</span>
												<p class="agree">
													<input type="checkbox" name="emailAgree"
														title="정보성,이벤트 메일 수신동의" /><label for="emailAgree"
														class="normal">정보,이벤트 메일 수신동의</label>
												</p></li>
											<li class="phone specific"><label for="phone">휴대전화</label><input
												id="phone" type="tel" name="phone"
												pattern="\d{3}-\d{3,4}-\{4}"
												placeholder="010-1234-5678, (-)하이픈 포함" />
												<p class="agree">
													<input type="checkbox" name="smsAgree"
														title="정보성,이벤트 SMS 수신동의" /><label for="smsAgree"
														class="normal">정보,이벤트 SMS 수신동의</label>
												</p></li>
										</ul>
									</fieldset>
									<div id="buttonArea">
										<input id="join" type="submit" title="회원가입양식제출버튼"
											value="Sign Up" /><!-- 
									 --><input id="reset" type="reset" title="reset버튼"
											value="다시 작성하기" /><!-- 
								     --><input id="prev" type="button" title="뒤로가기버튼"
												value="이전으로" />
									</div>
									<fieldset id="termsPrivacy">
										<legend>이용약관 및 개인정보 취급방침</legend>
										<div class="agreeText">
											<p class="terms">
												<span>이용약관 : </span>
												<!--
  								   -->
												<input id="conditionAgree" type="checkbox"
													name="conditionAgree" />
												<!--
  									 -->
												<label for="conditionAgree">이용약관에 동의합니다.</label>
												<!--
  									 -->
												<a href="termsandpriv.html" title="이용약관 확인 페이지로">이용약관
													확인하기</a>
											</p>
											<p class="privacy">
												<span>개인정보 취급방침 : </span>
												<!--
  									 -->
												<input id="privacyAgree" type="checkbox" name="privacyAgree" />
												<!--
  									 -->
												<label for="privacyAgree">개인정보 취급방침에 동의합니다.</label>
												<!--
  									 -->
												<a href="termsandpriv.html" title="개인정보 취급방침 확인 페이지로">개인정보
													취급방침 확인하기</a>
											</p>
										</div>
									</fieldset>
									<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> 
								</form>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
		<!-- footer starts -->
		<jsp:include page="./include/footer.jsp" />
		<!-- footer ends -->
	</div>
</body>
</html>