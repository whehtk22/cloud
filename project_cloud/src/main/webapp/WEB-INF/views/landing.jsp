<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- <meta charset="EUC-KR"> -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>Welcome to FileRoom</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/landing.css">
	<script src="/resources/js/jquery-1.12.4.min.js"></script>
	<script src="/resources/js/landing.js"></script>
</head>
<body>
	<div id="wrapper">
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
						<li><a href="/about" title="greeting">Greeting</a></li>
						<li><a href="#none" title="contact">Contact</a></li>
						<li><a href="#none" title="location">Location</a></li>
					</ul>	
				</nav>
			</header>	
		</div>
		<div id="container">
			<section id="linksOuter">
				<h2>FileRoom 홈</h2>
				<article id="linksInner" class="innerArticle">
					<h3>
						<a href="/index" title="FileRoom 홈으로">
							FileRoom Home
						</a>
					</h3>
				</article>
			</section>
		</div>
	</div>
</body>
</html>