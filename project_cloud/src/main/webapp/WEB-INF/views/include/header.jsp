<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<head>
</head>
<div id="headWrap">
	<header id="header">
		<h1 id="logo">
			<a href="/index" title="메인페이지로">LOGO</a>
		</h1>
		<a id="menuWrap" href="#none" title="menu contents 링크">
			<dl id="menuBtn">
				<dt>
					<strong>menu</strong>
				</dt>
				<!--
			 -->
				<dd>
					<p class="btnBox">
						<span class="topBar"></span> <span class="midBar">menu</span> <span
							class="btmBar"></span>
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
<div id="page-wrapper"></div>
