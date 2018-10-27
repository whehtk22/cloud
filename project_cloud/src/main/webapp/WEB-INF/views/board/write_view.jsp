<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div class="div_center" align="center">
		<h3>게시판 글 작성</h3>
		<hr>
		<form action="write.board" method="post">
			<input type="hidden" name="bName" value="${user_name}">
			<table width="500" border="1">
				<tr>
					<td>작성자</td>
					<td>
						<%--  <input type="text" name="bName" size="10"> --%>
						${user_name}(${user_id})
						<%-- input을 가려서 파라미터가 없어졌으니 히든으로 이름정보를 DB에 넘겨야--%>
					</td>
				</tr>
				<tr>
					<td>글 제목</td>
					<td>
						<input type="text" name="bTitle" size="20">
					</td>
				</tr>
				<tr>
					<td>글 내용</td>
					<td>
						<textarea name="bContent" rows="10" cols="50"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" class="btn btn-default" value="완료" onclick="return confirm('글 작성을 완료하시겠습니까?')">
						&nbsp;&nbsp;<a href="/jimmyZip/board/b_list.board">[목록]</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>