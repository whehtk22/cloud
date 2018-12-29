<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
<script type="text/javascript"
	src="/resources/vendor/bootstrap/js/bootstrap2.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>

<link rel="stylesheet" href="/resources/css/get.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/modal.css">
<div class='bigPictureWrapper'>
	<div class="bigPicture"></div>
</div>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}

#addReplyBtn {
	float: right;
}

.pagingArea {
	width: 100%;
	text-align: center;
}

.pagingArea .pagingInner {
	display: inline-block;
	width: 200px;
}

.pagination {
	display: inline-block;
	padding-left: 0;
	margin: 20px 0;
	border-radius: 4px;
}

.pagination>li {
	display: inline;
}

.pagination>li>a, .pagination>li>span {
	position: relative;
	float: left;
	padding: 6px 12px;
	margin-left: -1px;
	line-height: 1.42857143;
	color: #337ab7;
	text-decoration: none;
	background-color: #fff;
	border: 1px solid #ddd;
}

.pagination>li>a:hover, .pagination>li>span:hover, .pagination>li>a:focus,
	.pagination>li>span:focus {
	z-index: 2;
	color: #23527c;
	background-color: #eee;
	border-color: #ddd;
}

.pagination>.active>a, .pagination>.active>span, .pagination>.active>a:hover,
	.pagination>.active>span:hover, .pagination>.active>a:focus,
	.pagination>.active>span:focus {
	z-index: 3;
	color: #fff;
	cursor: default;
	background-color: #337ab7;
	border-color: #337ab7;
}

.btns {
	float: right;
	margin: 3px;
}
</style>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<jsp:include page="modal.jsp"></jsp:include>
<script type="text/javascript">
	//각기 다른 버튼에 대해서 data-oper를 다르게 적용하여 버튼마다 다른 기능을 구현.
	var bnoValue = '<c:out value="${board.bno}"/>'
	var pageNum = 1
	var replyPageFooter = $(".panel-footer")

	function showImage(fileCallPath) {
		$(".bigPictureWrapper").css("display", "flex").show()

		$(".bigPicture").html(
				"<img src='/display?fileName=" + fileCallPath + "'>").animate({
			width : '100%',
			height : '100%'
		}, 1000)
	}
	$(document)
			.ready(
					function() {

						(function() {//즉시 실행함수
							var bno = '<c:out value="${board.bno}"/>'

							$
									.getJSON(
											"/board/getAttachList",
											{
												bno : bno
											},
											function(arr) {
												console.log(arr)

												var str = ""
												$(arr)
														.each(
																function(i,
																		attach) {
																	//image type
																	if (attach.image) {
																		var fileCallPath = encodeURIComponent(attach.uploadPath
																				+ "/s_"
																				+ attach.uuid
																				+ "_"
																				+ attach.fileName)
																		str += "<li data-path='"+attach.uploadPath+"' data-uuid='"
						+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.image+"'><div>"
																		str += "<img src='/display?fileName="
																				+ fileCallPath
																				+ "'>"
																		str += "</div></li>"
																	} else {
																		shortfileName = attach.fileName
																				.substring(
																						0,
																						6)
																				+ ".."
																		str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
						+attach.fileName+"' data-type='"+attach.image+"'><div>"
																		str += "<span> "
																				+ shortfileName
																				+ "</span><br>"
																		str += "<img src='/resources/images/attach.jpg' alt='"+attach.fileName+"'>"
																		str += "</div></li>"
																	}
																})
												$(".uploadResult ul").html(str)
											})
						})()

						var operForm = $("#operForm")

						$("button[data-oper='modify']").on(
								"click",
								function(e) {
									operForm.attr("action", "/board/modify")
											.submit()
								})

						$("button[data-oper='list']").on("click", function(e) {
							operForm.find("#bno").remove()//목록으로 이동하는 것이므로 필요 없는 bno를 지워준다.
							operForm.attr("action", "/board/list")
							operForm.submit()
						})

						$("button[data-oper='remove']").on("click",
								function(e) {
									 operForm.attr("action", "/board/remove")
									operForm.attr("method", "post")
									operForm.submit() 
								})

						$(".uploadResult").on(
								"click",
								"li",
								function(e) {
									console.log("view image")
									var liObj = $(this)

									var path = encodeURIComponent(liObj
											.data("path")
											+ "/"
											+ liObj.data("uuid")
											+ "_"
											+ liObj.data("filename"))

									if (liObj.data("type")) {//이미지파일인 경우
										showImage(path.replace(
												new RegExp(/\\/g), "/"))// \\를 모두 /로 바꾼다.
										//함수로 전달하는 과정에서 문제가 생기므로 변환한다.
									} else {
										self.location = "/download?fileName="
												+ path//일반파일인 경우
									}
								})
						$(".bigPictureWrapper").on("click", function(e) {
							$(".bigPicture").animate({
								width : '0%',
								height : '0%'
							}, 1000)
							setTimeout(function() {
								$(".bigPictureWrapper").hide()
							}, 1000)
						})
					})

	$(document).ready(
			function() {
				//var replyUL = $(".chat")
				var replyUL = $("#showRpl")
				showList(1)
				$("#showRpl").on(
						"click",
						"dl",
						function(e) {//ul태그의 클래스 chat의 항목(li)을 클릭하였을 경우 동작하는 함수 
							var rno = $(this).data("rno")
							replyService.get(rno, function(reply) {
								modalInputReply.val(reply.reply)
								modalInputReplyer.val(reply.replyer)
								modalInputReplyDate.val(
										replyService
												.displayTime(reply.replyDate))
										.attr("readonly", "readonly")
								modal.data("rno", reply.rno)

								modal.find("button[id !='modalCloseBtn']")
										.hide()
								modalModBtn.show()
								modalRemoveBtn.show()

								$(".modal").modal("show")
							})
							console.log(rno)
						})
				$(".panel-footer").on("click", "li a", function(e) {
					e.preventDefault()
					console.log("page click")

					var targetPageNum = $(this).attr("href")
					console.log("targetPageNum: " + targetPageNum)

					pageNum = targetPageNum
					console.log("pageNum: " + pageNum)
					showList(pageNum)
				})
			})
			var replyer=null;
	
	<sec:authorize access="isAuthenticated()">
	
replyer='<sec:authentication property="principal.username"/>';
</sec:authorize>
var csrfHeaderName="${_csrf.headerName}";
var csrfTokenValue="${_csrf.token}";
$(document).ajaxSend(function(e,xhr,options){
	xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
})
</script>
<script type="text/javascript" src="/resources/js/modal.js"></script>
<script type="text/javascript" src="/resources/js/replyshow.js"></script>
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<!--contents container starts-->
	<div id="container">
		<div id="mainVisualWrap">
			<div id="mainVisual">
				<p class="imgArea">
				<h2>메인비쥬얼</h2>
				</p>
				<p class="textArea">
					Welcome to our <span>Mini&nbsp;Cloud</span>, <strong>Board</strong>
				</p>
			</div>
		</div>
		<div id="contentsWrap">
			<div class="sideBarArea">
				<nav class="sideNavWrap">
					<h3>
						<span>Board&nbsp;>>&nbsp;</span>자유게시판
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
			<div class="contentsArea">
				<section id="showContents">
					<article id="contentInfo">
						<h4>
							<span>${board.writer}님의 게시물입니다.</span>
						</h4>
						<div>
							<span> 작성자 : <b>${board.writer}</b>
							</span> <span> 작성일 : <b><fmt:formatDate
										value="${board.regdate}" pattern="yyyy/MM/dd" /></b>
							</span>
						</div>
						<p class="contentAddr">
							<a href="#none" title="글의 주소">글의 주소</a>
							<button onClick="copyAddr()">주소 복사</button>
						</p>
					</article>
					<article id="boardArticle">
						<div class="articleTitle">
							<h4>${board.title}</h4>
							<p>${board.bno}</p>
						</div>
						<div class="articleDetail">
							<p>${board.content}</p>
						</div>
					</article>
				</section>
				<article class="panel-heading">Files</article>
				<section class="panel-body">
					<article class="uploadResult">
						<!-- 파일이 보이는곳 -->
						<ul>

						</ul>
					</article>
				</section>
				<section id="rplArea">
					<div class="panel-heading" style="margin-bottom: 35px;">
						<i class="fa fa-comments fa-fw"></i>Reply
						<sec:authorize access="isAuthenticated()">
							<button id='addReplyBtn'
								class='btn btn-primary btn-xs pull-right'>New Reply</button>
						</sec:authorize>
					</div>
					<article id="showRpl">
						<h3 class="hide">댓글 표시 영역</h3>
						<h4>
							댓글 <span>N</span>건
						</h4>
					</article>
				</section>
				<div class="panel-footer"></div>
				<div class="hiddenFormArea"></div>
				<div>
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer }">
							<button class="btn btns" data-oper='modify'>수정</button>
							<button class="btn btns" data-oper='remove'>삭제</button>
						</c:if>
					</sec:authorize>
					<button class="btn btns" data-oper='list'>목록</button>
				</div>
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
			<!-- 숨겨진 폼을 만들어서 각각의 버튼에 대해서 다른 기능을 구현. -->
			<form id="operForm" action="/board/modify" method="get">
				<input type="hidden" id="bno" name="bno"
					value="<c:out value='${board.bno}'/>"> <input type='hidden'
					name="writer" value="${board.writer}"> <input type="hidden"
					name="pageNum" value="<c:out value='${page.pageNum}'/>"> <input
					type="hidden" name="amount" value="<c:out value='${page.amount}'/>">
				<input type="hidden" name="keyword"
					value="<c:out value='${page.keyword}'/>"> <input
					type="hidden" name="type" value="<c:out value='${page.type}'/>">
				<input type='hidden' name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>