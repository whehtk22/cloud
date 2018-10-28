<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<script type="text/javascript">
//각기 다른 버튼에 대해서 data-oper를 다르게 적용하여 버튼마다 다른 기능을 구현.
$(document).ready(function(){
	var operForm = $("#operForm")
	
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/board/modify").submit()
	})
	
	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#bno").remove()//목록으로 이동하는 것이므로 필요 없는 bno를 지워준다.
		operForm.attr("action","/board/list")
		operForm.submit()
	})
})

</script>
</head>
<body>
	<h3>게시글 내용 보기</h3>
	<hr>
	<table border="1" width="500">
		<tr>
			<td width="20%">글 번호</td>
			<td width="30%">${board.bno}</td>
			<td width="20%">조회수</td>
			<td width="30%">${content.bHit}</td>
		</tr>
		<tr>
			<td width="20%">작성자</td>
			<td width="30%">${board.writer}</td>
			<td width="20%">작성일</td>
			<td width="30%">${board.regdate}</td>
		</tr>
		<tr>
			<td width="40%">글 제목</td>
			<td width="60%" colspan="3">${board.title}</td>
		</tr>
		<tr>
			<td width="40%">글 내용</td>
			<td width="60%" height="100px" colspan="3">${board.content}</td>
		</tr>
		
		<tr>
			<td colspan="4">
			<button data-oper='modify' class="btn btn-default">[수정]</button>
			<button data-oper='remove' class="btn btn-danger">[삭제]</button>
			<button data-oper='list' class="btn btn-info">[목록]</button>
				<a href="/jimmyZip/board/b_reply_form.board?bId=${content.bId}">[답변]</a>&nbsp;&nbsp;
				<%--해당글을 수정,삭제,답변 해야하니까 글번호를 주소에 묻혀보낸다. --%>
			</td>
		</tr>
	</table>
	<!-- 숨겨진 폼을 만들어서 각각의 버튼에 대해서 다른 기능을 구현. -->
	<form id='operForm' action="/board/modify" method="get">
	<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
	</form>
</body>
</html>