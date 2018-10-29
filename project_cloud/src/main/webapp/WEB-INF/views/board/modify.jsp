<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script>
$(document).ready(function(){
	var formObj = $("form")
	
	$('button').on("click",function(e){
		
		e.preventDefault()
		
		var operation = $(this).data("oper")
		
		console.log(operation)
		
		if(operation==='remove'){
			formObj.attr("action","/board/remove")
		}else if(operation==='list'){
			//self.location="/board/list"
			formObj.attr("action","/board/list").attr("method","get")//단순히 list로 가는 것이기 때문에 post방식이 필요 없이 get방식으로 해도 된다.
			var pageNum = $("input[name='pageNum']").clone()
			var amount = $("input[name='amount']").clone()
			
			formObj.empty()
			formObj.append(pageNum)
			formObj.append(amount)
		}
		formObj.submit()
	})
	
})

</script>
</head>
<body>
	<h3>게시글 내용 보기</h3>
	<hr>
	<form role="form" action="/board/modify" method="post">
	<table border="1" width="500">
		<tr>
			<td width="20%">글 번호</td>
			<td width="30%"><input name='bno' value='${board.bno}' readonly="readonly"></td>
			<td width="20%">조회수</td>
			<td width="30%">${content.bHit}</td>
		</tr>
		<tr>
			<td width="20%">작성자</td>
			<td width="30%"><input name='writer' value="${board.writer}" readonly="readonly"></td>
			<td width="20%">작성일</td>
			<td width="30%"><input name='regdate' value='<fmt:formatDate value="${board.regdate}" pattern="yyyy/MM/dd"/>' readonly="readonly"></td>
		</tr>
		<tr>
			<td width="40%">글 제목</td>
			<td width="60%" colspan="3"><input name='title' value="${board.title}"></td>
		</tr>
		<tr>
			<td width="40%">글 내용</td>
			<td width="60%" height="100px" colspan="3"><input name='content' value="${board.content}"></td>
		</tr>
		
		<tr>
			<td colspan="4">
			<button type="submit" data-oper='modify' class="btn btn-default">[수정]</button>
			<button type="submit" data-oper='remove' class="btn btn-danger">[삭제]</button>
			<button type="submit" data-oper='list' class="btn btn-info">[목록]</button>
				<a href="/jimmyZip/board/b_reply_form.board?bId=${content.bId}">[답변]</a>&nbsp;&nbsp;
				<%--해당글을 수정,삭제,답변 해야하니까 글번호를 주소에 묻혀보낸다. --%>
			</td>
		</tr>
	</table>
	<div><input type="hidden" class="form-control" name='updateDate' value='<fmt:formatDate value="${board.updateDate}" pattern="yyyy/MM/dd/"/>' >
	<input type="hidden" name='pageNum' value='${page.pageNum}'>
	<input type="hidden" name='amount' value='${page.amount}'>
	</div>
	</form>
</body>
</html>