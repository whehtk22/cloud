<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>Login</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
	<script src="/resources/js/jquery-1.12.4.min.js"></script>
</head>
<body>
	<div id="wrapper" class="subpageWrapBgColor">
	<!-- header starts -->
    <div id="headWrap">
      <header id="header">
        <h1 id="logo">
          <a href="index.html" title="메인페이지로">LOGO</a>
        </h1>
        <a id="menuWrap" href="#none" title="menu contents 링크">
          <dl id="menuBtn">
            <dt>
              <strong>menu</strong>
            </dt><!--
           --><dd>
              <p class="btnBox">
                <span class="topBar"></span>
                <span class="midBar">menu</span>
                <span class="btmBar"></span>
              </p>
            </dd>
          </dl>
        </a>
        <nav id="gnb">
          <h2>헤더 내 gnb</h2>
          <ul>
            <li><a href="about.jsp" title="greeting">Greeting</a><span
					class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="/index" title="home">Home</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="/file/fileroom" title="cloud">Cloud</a><span
					class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
					<sec:authorize access="isAnonymous()">
				<li><a href="/customLogin" title="login">Sign In</a><span
					class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
					</sec:authorize>
				<li><a href="/member/join" title="register">Register</a><span
					class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="mypage.jsp" title="register">My Page</a><span
					class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="storage_market.jsp" title="market">Market</a><span
					class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="/board/list" title="board">Board</a><span
					class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="qna.jsp" title="qna">QnA</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="contact.jsp" title="contact">Contact</a><span
					class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="location.jsp" title="location">Location</a><span
					class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="sitemap.jsp" title="sitemap">Site Map</a><span
					class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<sec:authorize access="isAuthenticated()">
				<li><a href="/customLogout" title="sitemap">Sign Out</a></li>
				</sec:authorize>
          </ul>
        </nav>
      </header>
    </div>
		<!-- header ends -->
    <div id="loginWrap">
      <h3>FileRoom Service 로그인</h3>
      <form role="form" method="post" action="/login">
        <p class="logArea">
            <input type="text" name="username" class="text_field" placeholder="User ID">
            <input type="password" name="password" class="text_field" placeholder="User Password">
           <!--  <input type="submit" value="로그인" class="submit-btn"> -->
           <a href="index.html" class="submit-btn btn-success">로그인</a>
        </p>
        <p class="autoLogArea">
            <input type="checkbox" id="autoLogCheck" name="remember-me"/><label for="autoLogCheck">자동로그인</label>
        </p>
        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
      </form>
      <div class="links">
        <a href="findaccount.html" title="비밀번호 찾기">비밀번호를 잊어버리셨나요?</a>
        <span class="divLine">&nbsp;|&nbsp;</span>
        <a href="/member/join" title="비밀번호 찾기">회원가입</a>
      </div>
    </div>
		<!-- footer starts : 로그인 페이지에서는 푸터 없앰-->
		<!-- footer ends -->
	</div>
</body>
<script>
$(".btn-success").on("click",function(e){
	e.preventDefault()
	console.log("로그인")
	$("form").submit()
})
</script>
<c:if test="${param.logout!=null}">
<script>
$(document).ready(function(){
	alert("로그아웃하였습니다.")
})
</script>
</c:if>
</html>