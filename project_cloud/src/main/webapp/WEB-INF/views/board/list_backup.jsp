<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
	<div class="div_center" align="center">
		<h3>My First Web 게시판</h3>

		<hr>

		<table width="500" border="1">
			<tr>
				<td>글 번호</td>
				<td>작성자</td>
				<td>제목</td>
				<td>날짜</td>
				<td>조회수</td>
			</tr>

			<%-- 반복문으로 글 목록 처리 글 목록이 반복해서 들어갈 tr자리 --%>
			<c:forEach var="list" items="${b_list}">
				<tr>
					<td>${list.bId}</td>
					<td>${list.bName}</td>

					<td>
		
					<c:forEach begin="1" end="${list.bIndent}">ㄴre:</c:forEach>
					<a href="b_content.board?bId=${list.bId}">
					${list.bTitle}
					</a>
					</td>

					<td>${list.bDate}</td>
					<td>${list.bHit}</td>
				</tr>
			</c:forEach>

			<tr>
				<td colspan="5"><a href="write_form.board">[글쓰기]</a></td>
			</tr>
		</table>
	</div>
</body>
</html>