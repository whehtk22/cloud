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
		<form action="" method="post">
		<%-- 이 페이지에서 원본글에 대한 정보를 가지고 있다가 넘겨야 하기 때문에 서비스가 필요 --%>
			<input type="hidden" name="bName" value="${user_name}">
			<input type="hidden" name="bGroup" value="${info.bGroup}">
			<input type="hidden" name="bIndent" value="${info.bIndent}">		
			<table width="500" border="1">
				<tr>
					<td>작성자</td>
					<td>
						<%-- <input type="text" name="bName" size="10">--%>
						${user_name}(${user_id})
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