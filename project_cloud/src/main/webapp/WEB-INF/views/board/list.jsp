<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>FreeBoard</title>
<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="/resources/css/board.css">
</head>
<body>
	<div id="navContainer">
		<nav id="navInner">
			<ul id="nav">
				<li><a class="navItem" href="#none" title="서비스 소개">서비스 소개</a></li>
				<li><a class="navItem" href="#none" title="홈으로">홈으로</a></li>
				<li><a class="navItem" href="#none" title="이용안내">이용안내</a></li>
				<li><a class="navItem" href="#none" title="회원가입">회원가입</a></li>
				<li><a class="navItem" href="#none" title="로그인">로그인</a></li>
				<li><a class="navItem" href="#none" title="이벤트">이벤트</a></li>
				<li><a class="navItem" href="#none" title="테스트">테스트</a></li>
			</ul>
		</nav>
	</div>
	<div id="tableArea">
		<h3>
			자유게시판
			<p>게시글은 게시자 인격의 거울입니다.</p>
		</h3>
		<hr>
		<div id="tableContents">
			<ul id="table">
				<li class="titleRow">
					<p class="title0">번호</p>
					<p class="title1">제목</p>
					<p class="title2">작성자</p>
					<p class="title3">작성일</p>
					<p class="title4">조회수</p>
					<p class="title5">좋아요</p>
				</li>
				<c:forEach var="list" items="${list}">
				<li class="contentRow">
					<p>${list. }</p>
					<p></p>
					<p></p>
					<p></p>
					<p></p>
					<p></p>
				</li>
				</c:forEach>
				<li class="btnRow">
					<p>
						<a class="btn" href="#none" title="글쓰기">글쓰기</a>
					</p>
				</li>
			</ul>
			<div id="pagingArea">
				<p class="prev">
					<a class="prevBtn" href="#none" title="이전목록">이전</a>
				</p>
				<p class="pageNoArea">
					<a class="pageNo" href="#none" title="1"><span>1</span></a>
					<a class="pageNo" href="#none" title="2"><span>2</span></a>
					<a class="pageNo" href="#none" title="3"><span>3</span></a>
					<a class="pageNo" href="#none" title="4"><span>4</span></a>
					<a class="pageNo" href="#none" title="5"><span>5</span></a>
					<a class="pageNo" href="#none" title="6"><span>6</span></a>
					<a class="pageNo" href="#none" title="7"><span>7</span></a>
					<a class="pageNo" href="#none" title="8"><span>8</span></a>
					<a class="pageNo" href="#none" title="9"><span>9</span></a>
					<a class="pageNo" href="#none" title="10"><span>10</span></a>
				</p>
				<p class="next">
					<a class="nextBtn" href="#none" title="다음목록">다음</a>
				</p>
			</div>
		</div>
		<div id="searchAreaWrapper">
			<form id="searchArea" action="#none" method="get">
				<select>
					<option value="제목">제목</option>
					<option value="작성자">작성자</option>
					<option value="작성자+내용">작성자+내용</option>
				</select>
				<p>
					<input id="search" type="text" name="search">
					<input type="submit" value="검색">
				</p>	
			</form>
		</div>
	</div>
</body>
</html>