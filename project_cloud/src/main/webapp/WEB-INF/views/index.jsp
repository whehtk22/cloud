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
						<h2>���κ����</h2>
						<!-- <img src="./images/bg_landing.jpg" alt="���κ��־�"/> -->
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
						<h3>���Ϸ� ���� �Ұ�</h3>
					</article>
					<article id="mypageZone" class="row1">
						<h3>�������Ϸ�(Ŭ����)</h3>
					</article>
					<article id="eventZone" class="row1">
						<h3>�̺�Ʈ �ҽ���</h3>
					</article>
					<article id="advZone" class="row2">
						<h3>������</h3>
					</article>					
					<article id="boardZone" class="row2">
						<h3>�������� �Ǵ� ��ȸ�� ���� �� ���</h3>
						<div id="listWrap">
							<ul class="articleArea">
								<li>
									<a href="#none" title="boardList1">
										<span class="aTitle">���Ĵٵ� ���Ϸ� �뷮�� 1G �Դϴ�.</span>
										<span class="aDate">�۰Խ���</span>
									</a>
								</li>
								<li>
									<a href="#none" title="boardList2">
										<span class="aTitle">���Ĵٵ� ���Ϸ� �뷮�� 1G �Դϴ�.</span>
										<span class="aDate">�۰Խ���</span>
									</a>
								</li>
								<li>
									<a href="#none" title="boardList3">
										<span class="aTitle">���Ĵٵ� ���Ϸ� �뷮�� 1G �Դϴ�.</span>
										<span class="aDate">�۰Խ���</span>
									</a>
								</li>
							</ul>
							<p class="more">
								<a href="board.jsp" title="�� ��� ������">
									<span class="moreImg">
										<img src="" alt="������ ������"/>
									</span>
									<span class="moreTxt">������</span>
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