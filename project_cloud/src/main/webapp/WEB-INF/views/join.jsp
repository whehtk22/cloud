<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>Join FileRoom Service</title>
	<link rel="stylesheet" type="text/css" href="./css/reset.css">
	<link rel="stylesheet" type="text/css" href="./css/common.css">
	<script src="./js/jquery-1.12.4.min.js"></script>
	<script src="./js/common.js"></script>
</head>
<body>
	<div id="wrapper">
		<!-- header starts -->
		<jsp:include page="./include/header.jsp"/>
		<!-- header ends -->
		<div id="container">
			<div id="mainVisualWrap">
				<div id="mainVisual">
					<p class="imgArea">
						<h2>메인비쥬얼</h2>
						<!-- <img src="./images/bg_landing.jpg" alt="메인비주얼"/> -->
					</p>
					<p class="textArea">
						Welcome to our
						<span>Mini&nbsp;Cloud</span>,
						<strong>FileRoom</strong>
					</p>
				</div>
			</div>
			<div id="contentsWrap">
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
								<form action="#none" method="post">
									<fieldset id="membership">
										<legend>Member's Information<span>(필수항목)</strong></span></legend>
										<ul id="signUp">
											<li>
												<label for="userid1">USERID</label><input id="userid1" type="text" name="userid" placeholder="Your ID to use" required="required" maxlength="13" autofocus="on" autocomplete="off"/>
												<input id="idCheck" type="button" name="idCheck" title="ID중복확인" value="ID 중복확인" required="required"/>
											</li>
											<li>
												<label for="userpw1">PASSWORD</label><input id="userpw1" type="password" name="userpw1" placeholder="Your PW to use" required="required" maxlength="13" autocomplete="off"/>
											</li>
											<li>
												<label for="userpw2">PASSWORD Check</label><input id="userpw2" type="password" name="userpw2" placeholder="Your PW again" required="required" maxlength="13" autocomplete="off"/>
											</li>
											<li>
												<label for="userName">이름</label><input id="userName" type="password" name="userName" placeholder="성명" required="required" maxlength="4" min="2"/>
											</li>
											<li class="email">
												<label for="useremail">Email</label><input id="useremail" type="email" name="useremail" placeholder="yourEmail@email.com" required="required"/>
												<input id="emailCheck" type="button" name="emailCheck" title="email중복확인" value="Email 중복확인" required="required"/><br/>
												<span class="caution">아이디 비밀번호 분실 시 필요한 정보이므로, 정확하게 기입해 주십시오.</span><br/>
												<input id="emailAgree" type="checkbox" name="emailAgree" title="정보성,이벤트 메일 수신동의"/><label for="emailAgree" class="normal">정보,이벤트 메일 수신동의</label>
											</li>
											<li class="phone">
												<label for="phone">휴대전화</label><input id="phone" type="tel" name="phone" pattern="\d{3}-\d{3,4}-\{4}" placeholder="010-1234-5678, (-)하이픈 포함"/><br/><input id="smsAgree" type="checkbox" name="smsAgree" title="정보성,이벤트 SMS 수신동의"/><label for="smsAgree" class="normal">정보,이벤트 SMS 수신동의</label>
											</li>
										</ul>
									</fieldset>
									<div id="buttonArea">
										<p>
											<input id="join" type="submit" name="join" title="회원가입양식제출버튼" value="Sign Up"/>
										</p>
										<p>
											<input id="reset" type="reset" name="reset" title="reset버튼" value="다시 작성하기"/>
										</p>
										<p>
											<input id="prev" type="submit" name="prev" title="뒤로가기버튼" value="이전으로"/>
										</p>
									</div>
									<fieldset id="termsCondition">
										<legend>이용약관</legend>
										<p class="agreeText">
											<input id="conditionAgree" type="checkbox" name="conditionAgree"/>
											<label for="conditionAgree">아래 사항에 동의합니다.</label>
											<a href="termsandpriv.jsp" title="이용약관 페이지로"><span>이용약관 확인하기</span></a>
										</p>
									</fieldset>
									<fieldset id="privacy">
										<legend>개인정보 취급방침</legend>
										<p class="agreeText">
											<input id="privacyAgree" type="checkbox" name="privacyAgree"/>
											<label for="privacyAgree">아래 사항에 동의합니다.</label>
											<a href="termsandpriv.jsp" title="이용약관 페이지로"><span>이용약관 확인하기</span></a>
										</p>
									</fieldset>
								</form>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
		<!-- footer starts -->
		<jsp:include page="./include/footer.jsp"/>
		<!-- footer ends -->
	</div>
</body>
</html>