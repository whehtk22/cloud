<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!-- <meta charset="EUC-KR"> -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Board List</title>
<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<!--  <script src="/resources/js/jquery-1.12.4.min.js" type="text/javascript"></script>  -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/js/floating-ads.js" type="text/javascript"></script>
<script src="/resources/js/floating-ads.js" type="text/javascript"></script>
<script src="/resources/js/ajax.js" type="text/javascript"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<!--  <link href="/resources/vendor/bootstrap/css/bootstrap.css"
	rel="stylesheet" type="text/css">  -->
<!-- <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script> -->
<script type="text/javascript" src="/resources/vendor/bootstrap/js/bootstrap2.js"></script>
<script src="/resources/js/boardlist.js" type="text/javascript"></script>
<style>
.page_button:active>a {
	color: black;
	background-color: #1bbc9b;
}
</style>
<script>
	$(document).ready(function() {
		var num = $
		{
			num
		}
		$("#num").off("click")
		//$("#btnIdCheck").unbind("click");
	})
</script>
</head>
<body>
	<div id="wrapper">
		<!-- header starts -->
		<jsp:include page="../include/header.jsp"></jsp:include>
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
			<h3 class="hide">
				자유게시판
				<p>게시글은 게시자 인격의 거울입니다.</p>
			</h3>
			<div id="contentsWrap">
				<div class="sideBarArea">
					<nav class="sideNavWrap">
						<h3>
							Board>><span>&nbsp;&nbsp;자유게시판</span>
						</h3>
						<ul class="sideNav">
							<li class="homeLink"><a href="/index" title="홈으로">Home</a></li>
							<li class="freeBLink"><a href="#none" title="자유게시판">Free
									Board</a></li>
							<li class="marketBLink"><a href="#none" title="마켓게시판">Share
									Market</a></li>
						</ul>
					</nav>
				</div>
				<div class="formArea">
					<h3>자유게시판</h3>
					<section id="searchAreaWrapper">
						<form id="searchArea" action="/board/list" method="get">
							<fieldset id="searchField">
								<p class="choose">
									<select name="type">
										<option value=""
											<c:out value="${page.page.type==null?'selected':'' }"/>>--</option>
										<option value="T"
											<c:out value="${page.page.type eq 'T' ? 'selected':'' }"/>>
											제목</option>
										<option value="C"
											<c:out value="${page.page.type eq 'C' ? 'selected':'' }"/>>
											내용</option>
										<option value="W"
											<c:out value="${page.page.type eq 'W' ? 'selected':'' }"/>>작성자</option>
										<option value="TC"
											<c:out value="${page.page.type eq 'TC' ? 'selected':'' }"/>>제목
											or 내용</option>
										<option value="TW"
											<c:out value="${page.page.type eq 'TW' ? 'selected':'' }"/>>제목
											or 작성자</option>
										<option value="TWC"
											<c:out value="${page.page.type eq 'TWC' ? 'selected':'' }"/>>제목
											or 내용 or 작성자</option>
									</select>
								</p>
								<!--
             				 -->
								<p class="search">
									<input type="text" name="keyword" placeholder="검색어 입력란">
									<!--
          		 				 -->
									<input type="hidden" name="pageNum"
										value="${page.page.pageNum}">
									<!--
          		 				 -->
									<input type="hidden" name="amount" value="${page.page.amount}">
									<!--
          		 				 -->
									<button>Search</button>
								</p>
							</fieldset>
						</form>
					</section>
					<section id="tableContents">
						<h3 class="hide">게시물 목록 영역</h3>
						<div class="tableInner">
							<ul class="table">
								<li class="titleRow">
									<p class="title0">
										<span>번호</span>
									</p>
									<p class="title1">
										<span>제목</span>
									</p>
									<p class="title2">
										<span>작성자</span>
									</p>
									<p class="title3">
										<span>작성일</span>
									</p>
									<p class="title4">
										<span>수정일</span>
									</p>
								</li>
								<c:forEach var="list" items="${list}">
									<li class="contentRow">
										<p class="content0">
											<span>${list.bno}</span>
										</p> <!--  target='_blank' -->
										<p class="content1">
											<span><a class="move"
												href="<c:out value='${list.bno}'/>"><c:out
														value="${list.title }" /><b>[<c:out
															value="${list.replyCnt }" />]
												</b> </a> </span>
										</p>
										<p class="content2">
											<span>${list.writer }</span>
										</p>
										<p class="content3">
											<span><fmt:formatDate pattern="yyyy-MM-dd"
													value="${list.regdate}" /></span>
										</p>
										<p class="content4">
											<span><fmt:formatDate pattern="yyyy-MM-dd"
													value="${list.updateDate}" /></span>
										</p>
									</li>
								</c:forEach>
							</ul>
							<div class="writeBtn">
								<button id='write_board' class="btn" title="글쓰기">글쓰기</button>
							</div>
							<div class="pagingArea">
								<ul class="pagingInner">
									<c:if test="${page.prev}">
										<li class="page_prev"><a href="${page.startPage-1}">
												Prev </a></li>
									</c:if>
									<c:forEach var="num" begin="${page.startPage}"
										end="${page.endPage}">
										<li><c:choose>
												<c:when test="${page.page.pageNum!=num }">
													<p
														class="page_button ${page.page.pageNum == num ? 'active' : ''} ">
														<a href="${num}" title="1" id="${num}"><span>${num}</span></a>
													</p>
												</c:when>
												<c:otherwise>
													<p
														class="page_button ${page.page.pageNum == num ? 'active' : ''} ">
														<span>${num}</span>
													</p>
												</c:otherwise>
											</c:choose></li>
									</c:forEach>
									<c:if test="${page.next}">
										<li class="page_next"><a href="${page.endPage+1}">
												Next </a></li>
									</c:if>
								</ul>
								<div class="hiddenFormArea">
									<form id='actionForm' action="/board/list" method="get">
										 <input type='hidden' name='pageNum'
											value='${page.page.pageNum}'> 
											<input type='hidden'
											name='amount' value='${page.page.amount}'> 
											<input
											type='hidden' name='type' value='${page.page.type}'>
										<input type='hidden' name='keyword'
											value='${page.page.keyword}'>
											<input type='hidden' name='list' value='${list}'>
											<%-- <input type='hidden' name='pagedto' value='${page}'> --%>
									</form>
								</div>
							</div>
						</div>
					</section>
					<!-- <section class="forModale">
						Modal
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-hidden="true">&times;</button>
										<h4 class="modal-title" id="myModalLabel">Modal title</h4>
									</div>
									<div class="modal-body">처리가 완료되었습니다.</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
										<button type="button" class="btn btn-primary">Save
											changes</button>
									</div>
								</div>
								/.modal-content
							</div>
							/.modal-dialog
						</div>
						/.modal
					</section> -->
				</div>
				<div class="adsArea">
					<ul>
						<li><a
							href="https://www.wdc.com/ko-kr/products/portable-storage.html"
							title="광고1" target="_blank"> <img class="adImg01"
								src="/resources/images/ads/adimg01.jpg"
								alt="광고1 western digital 이미지" />
						</a></li>
						<li><a href="https://www.sandisk.co.kr/home" title="광고2"
							target="_blank"> <img class="adImg02"
								src="/resources/images/ads/adimg02.jpg" alt="광고2 sandisk 이미지" />
						</a></li>
						<li><a href="https://www.seagate.com/kr/ko/consumer/backup/"
							title="광고3" target="_blank"> <img class="adImg03"
								src="/resources/images/ads/adimg03.jpg" alt="광고3 seagate 이미지" />
						</a></li>
					</ul>
				</div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>
