<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>FileRoom Home</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
	<script src="/resources/js/jquery-1.12.4.min.js"></script>
	<script src="/resources/js/common.js"></script>
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
				<section id="contents">
					<article id="aboutZone" class="row1">
						<h3>파일룸 서비스 소개</h3>
					</article>
					<article id="mypageZone" class="row1">
						<h3>마이파일룸(클라우드)</h3>
					</article>
					<article id="eventZone" class="row1">
						<h3>이벤트 소식존</h3>
					</article>
					<article id="advZone" class="row2">
						<h3>광고영역</h3>
					</article>					
					<article id="boardZone" class="row2">
						<h3>공지사항 또는 조회수 높은 글 목록</h3>
						<div id="listWrap">
							<ul class="articleArea">
								<li>
									<a href="#none" title="boardList1">
										<span class="aTitle">스탠다드 파일룸 용량은 1G 입니다.</span>
										<span class="aDate">글게시일</span>
									</a>
								</li>
								<li>
									<a href="#none" title="boardList2">
										<span class="aTitle">스탠다드 파일룸 용량은 1G 입니다.</span>
										<span class="aDate">글게시일</span>
									</a>
								</li>
								<li>
									<a href="#none" title="boardList3">
										<span class="aTitle">스탠다드 파일룸 용량은 1G 입니다.</span>
										<span class="aDate">글게시일</span>
									</a>
								</li>
							</ul>
							<p class="more">
								<a href="board.jsp" title="글 목록 더보기">
									<span class="moreImg">
										<img src="" alt="더보기 아이콘"/>
									</span>
									<span class="moreTxt">더보기</span>
								</a>
							</p>
						</div>
					</article>
				</section>
			</div>
		</div>
		<!-- footer starts -->
		<jsp:include page="./include/footer.jsp"/>
		<!-- footer ends -->
	</div>
</body>
</html>