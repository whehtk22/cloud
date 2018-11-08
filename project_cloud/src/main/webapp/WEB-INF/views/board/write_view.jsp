<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- <meta charset="EUC-KR"> -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>FileRoom Home</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
	<script src="/resources/js/jquery-1.12.4.min.js" type="text/javascript"></script>
	<script src="/resources/js/floating-ads.js" type="text/javascript"></script>
	<script src="/resources/js/ajax.js" type="text/javascript"></script>
</head>
<body>
	<!-- header starts -->
	<jsp:include page="../include/header.jsp"/>
	<!-- header ends -->
	<div id="container">
		<div id="mainVisualWrap">
			<div id="mainVisual">
				<p class="imgArea">
					<h2>메인비쥬얼</h2>
					<!-- <img src="./images/bg_landing.jpg" alt="메인비주얼"/> -->
				</p>
				<p class="textArea">
					Welcome to our <span>Mini&nbsp;Cloud</span>, <strong>Board</strong>
				</p>
			</div>
		</div>
		<div id="contentsWrap">
			<div class="sideBarArea">
				<nav class="sideNavWrap">
					<h3><span>Board&nbsp;>>&nbsp;</span>자유게시판</h3>
					<!-- 이 부분은 하단의 링크버튼 클릭에 따라 해당 게시판명으로 변경 -->
					<ul class="sideNav">
						<li class="homeLink"><a href="/index" title="홈으로">Home</a></li>
						<li class="freeBLink"><a href="#none" title="자유게시판">Free Board</a></li>
						<li class="marketBLink"><a href="#none" title="마켓게시판">Share Market</a></li>
					</ul>
				</nav>
			</div>
			<div class="formArea">
				<h3>게시판 글 작성</h3>
				<form class="writeForm" action="/board/register" method="post">
					<fieldset id="write_form">
						<div class="formInner">
							<h4 class="hide">자유게시판</h4>
							<p>
								<label for="writer">작성자</label>
								<input type="text" name="writer" required/>
								<%--  <input type="text" name="bName" size="10"> --%>
								<%-- ${user_name}(${user_id}) --%>
								<%-- input을 가려서 파라미터가 없어졌으니 히든으로 이름정보를 DB에 넘겨야--%>
							</p>
							<p>
								<label>글 제목</label>
								<input type="text" name="title" size="20" required/>
							</p>
							<p>
								<label>작성시간</label>
								<span class="wTime">작성시간</span>
							</p>
							<hr/>
							<p>
								<label class="hide">내용</label>
								<textarea name="content"></textarea>
								<!-- <textarea name="content" rows="10" cols="50"></textarea> -->
							</p>
						</div>
						<hr/>
						<div class="attachFiles">
							<p>
								<label for="file">파일첨부</label><!--
							 --><input type="file" name="upload"/><!--
							 --><button class="btn fileUpBtn">파일업로드</button>
							</p>
						</div>
						<div class="btnArea">
							<p>
								<button class="btn btnTempSave">임시저장</button><!--
							 --><input type="submit" class="btn btn-default" value="작성완료" ><!--
							 --><a class="goListBtn" href="/board/list" title="글 목록 보기">글목록</a>
							</p>
						</div>
					</fieldset>
				</form>
			</div>
			<div class="adsArea">
				<ul>
					<li>
						<a href="https://www.wdc.com/ko-kr/products/portable-storage.html" title="광고1" target="_blank">
							<img class="adImg01" src="/resources/images/ads/adimg01.jpg" alt="광고1 western digital 이미지"/>
						</a>
					</li>
					<li>
						<a href="https://www.sandisk.co.kr/home" title="광고2" target="_blank">
							<img class="adImg02" src="/resources/images/ads/adimg02.jpg" alt="광고2 sandisk 이미지"/>
						</a>
					</li>
					<li>
						<a href="https://www.seagate.com/kr/ko/consumer/backup/" title="광고3" target="_blank">
							<img class="adImg03" src="/resources/images/ads/adimg03.jpg" alt="광고3 seagate 이미지"/>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- footer starts -->
	<jsp:include page="../include/footer.jsp"/>
	<!-- footer ends -->
</body>
</html>