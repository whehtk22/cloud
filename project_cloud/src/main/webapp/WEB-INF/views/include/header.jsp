<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
				<li><a href="about.jsp" title="greeting">Greeting</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="/index" title="home">Home</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="fileroom.jsp" title="cloud">Cloud</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="login.jsp" title="login">Sign In</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="/member/join" title="register">Register</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="mypage.jsp" title="register">My Page</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="storage_market.jsp" title="market">Market</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="/board/list" title="board">Board</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="qna.jsp" title="qna">QnA</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="contact.jsp" title="contact">Contact</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="location.jsp" title="location">Location</a><span class="divLine">&nbsp;&nbsp;|&nbsp;</span></li>
				<li><a href="sitemap.jsp" title="sitemap">Site Map</a></li>
			</ul>	
		</nav>
	</header>
</div>
<!-- <div id="page-wrapper">

</div> -->