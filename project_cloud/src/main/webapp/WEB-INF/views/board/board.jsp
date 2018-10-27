<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h3>게시글 내용 보기</h3>
	<hr>
	<table border="1" width="500">
		<tr>
			<td width="20%">글 번호</td>
			<td width="30%">${content.bId}</td>
			<td width="20%">조회수</td>
			<td width="30%">${content.bHit}</td>
		</tr>
		<tr>
			<td width="20%">작성자</td>
			<td width="30%">${content.bName}</td>
			<td width="20%">작성일</td>
			<td width="30%">${content.bDate}</td>
		</tr>
		<tr>
			<td width="40%">글 제목</td>
			<td width="60%" colspan="3">${content.bTitle}</td>
		</tr>
		<tr>
			<td width="40%">글 내용</td>
			<td width="60%" height="100px" colspan="3">${content.bContent}</td>
		</tr>
		
		<tr>
			<td colspan="4">
				<a href="/jimmyZip/board/b_list.board">[목록]</a>&nbsp;&nbsp;
				<a href="/jimmyZip/board/b_update_form.board?bId=${content.bId}">[수정]</a>&nbsp;&nbsp;
				<a href="/jimmyZip/board/b_delete.board?bId=${content.bId}">[삭제]</a>&nbsp;&nbsp;
				<a href="/jimmyZip/board/b_reply_form.board?bId=${content.bId}">[답변]</a>&nbsp;&nbsp;
				<%--해당글을 수정,삭제,답변 해야하니까 글번호를 주소에 묻혀보낸다. --%>
			</td>
		</tr>
	</table>
</body>
</html>