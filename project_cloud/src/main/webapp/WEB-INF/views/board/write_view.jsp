<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<form action="/board/register" method="post">
			
			<table width="500" border="1">
				<tr>
					<td>작성자</td>
					<td>
					<input type="text" name="writer" >
						<%--  <input type="text" name="bName" size="10"> --%>
						<%-- ${user_name}(${user_id}) --%>
						<%-- input을 가려서 파라미터가 없어졌으니 히든으로 이름정보를 DB에 넘겨야--%>
					</td>
				</tr>
				<tr>
					<td>글 제목</td>
					<td>
						<input type="text" name="title" size="20">
					</td>
				</tr>
				<tr>
					<td>글 내용</td>
					<td>
						<textarea name="content" rows="10" cols="50"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" class="btn btn-default" value="완료" >
						&nbsp;&nbsp;<a href="/board/list">[목록]</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>