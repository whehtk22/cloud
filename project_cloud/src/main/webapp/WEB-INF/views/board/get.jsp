<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="/resources/js/reply.js"></script>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group">
                                            <label>Reply</label>
                                            <input class="form-control" name='reply' value='New Reply'>
                                            </div>
                                            <div class="form-group">
                                            <label>Replyer</label>
                                            <input class="form-control" name='replyer' value='replyer'>
                                            </div>
                                            <div class="form-group">
                                            <label>Reply Date</label>
                                            <input class="form-control" name='replyDate' value=' '>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
                                            <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
                                            <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
                                            <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->
<script type="text/javascript">
//각기 다른 버튼에 대해서 data-oper를 다르게 적용하여 버튼마다 다른 기능을 구현.
var bnoValue='<c:out value="${board.bno}"/>'
var pageNum =1
var replyPageFooter = $(".panel-footer")

function showReplyPage(replyCnt){
	
	var endNum = Math.ceil(pageNum/10.0)*10
	var startNum = endNum-9
	
	var prev = startNum !=1//시작하는 번호가 1이 아니면 true
	var next = false
	
	if(endNum*10>=replyCnt){//페이지의 끝번호가 전체 댓글수보다 크다면
		endNum=Math.ceil(replyCnt / 10.0);//댓글중 마지막 의 페이지번호로..
	}
	
	if(endNum*10<replyCnt){//마지막 페이지 번호가 전체 댓글수보다 작다면 
		next=true//다음 페이지로 넘어갈수있음
	}
	
	var str = "<ul class='pagination pull-right'>"
	
	if(prev){
		str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>"
		
	}
	console.log("startNum : "+startNum)
	console.log("endNum: "+endNum)
	for(var i=startNum;i<=endNum;i++){
		var active=pageNum==i?"active":""//페이지번호가 현재와 같으면 비활성화
				
		str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>"
	}
	
	if(next){
		str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>"
	}
	
	str+="</ul></div>"
	console.log(str)
	//console.log(replypageFooter)
	$(".panel-footer").html(str)
	//replyPageFooter.html(str)
}
//for replyService add test
//reply.js에서 등록한 변수인 replyService의 함수인 add를 호출해서 json의 형태로 추가해주고 결과가
//나오면 경고창으로 보여준다.
/* replyService.add(
		{reply:"JS Test",replyer:"tester",bno:bnoValue},
		function(result){
			alert("RESULT: "+result)
		}
		) */
		/* replyService.getList({bno:bnoValue,page:1},function(list){
			for(var i=0,len=list.length||0;i<len;i++){
				console.log(list[i])
			}
		}) */
	/* 	replyService.remove(5,function(count){
			console.log(count)
			
			if(count==="success"){
				alert("REMOVED")
			}
		},function(err){
			alert("ERROR..")
		}) */
		
		//10번 댓글 수정
		/* replyService.update({
			rno:10,
			bno:bnoValue,
			reply:"Modified Reply..."
		},function(result){
			alert("수정 완료~~~")
		}) */
		replyService.get(10,function(data){
			console.log(data)
		})
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
	
	$("button[data-oper='remove']").on("click",function(e){
		operForm.attr("action","/board/remove")
		operForm.attr("method","post")
		operForm.submit()
	})
})
$(document).ready(function(){
	var replyUL = $(".chat")
	
	showList(1)
	
	function showList(page){
		replyService.getList({bno:bnoValue,page:page||1},function(replyCnt,list){

			console.log(list)
			
			if(page==-1){//페이지 번호가 -1로 전달되면 마지막 페이지를 호출한다.
				pageNum = Math.ceil(replyCnt / 10.0); //만약 replyCnt가 14라고 하면 올림해서 2가 된다.
				showList(pageNum);
				return;
			}
			
			var str = ""
		if(list==null||list.length==0){//아무것도 리스트가 없으면 ""로 처리
			return
		}
		for(var i=0,len=list.length||0;i<len;i++){//댓글 리스트를 하나씩 생성해주는 자바구문.
			str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>"
			str +=" <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>"
			str +="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>"
			str +="<p>"+list[i].reply+"</p></div></li>"
		}
		
		replyUL.html(str)//반복문에서 생성한 str을 삽입해서 html로 나타내는 것.
		showReplyPage(replyCnt)
	})
	}
	var modal=$(".modal")//모달창에서 입력창에 대한 변수들
	var modalInputReply = modal.find("input[name='reply']")
	var modalInputReplyer = modal.find("input[name='replyer']")
	var modalInputReplyDate = modal.find("input[name='replyDate']")
	//모달창에서 버튼들에 대한 변수들
	var modalModBtn = $("#modalModBtn")
	var modalRemoveBtn = $("#modalRemoveBtn")
	var modalRegisterBtn = $("#modalRegisterBtn")
	var modalCloseBtn = $("#modalCloseBtn")
	//새로운 댓글 등록버튼을 눌렀을 경우의 이벤트
	$("#addReplyBtn").on("click",function(e){
		modal.find("input").val("")
		modalInputReplyDate.closest("div").hide()
		modal.find("button[id!='modalCloseBtn']").hide()
		
		modalRegisterBtn.show()
		
		$(".modal").modal("show")
	})
	modalRegisterBtn.on("click",function(e){
		var reply={
				reply:modalInputReply.val(),
				replyer:modalInputReplyer.val(),
				bno:bnoValue
		}
		replyService.add(reply,function(result){
			alert(result)
		})
		modal.find("input").val("")
		modal.modal("hide")
		
		//showList(1)
		showList(-1)
	})
	$(".chat").on("click","li",function(e){//ul태그의 클래스 chat의 항목(li)을 클릭하였을 경우 동작하는 함수 
		var rno = $(this).data("rno")
		replyService.get(rno,function(reply){
			modalInputReply.val(reply.reply)
			modalInputReplyer.val(reply.replyer)
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly")
			modal.data("rno",reply.rno)
			
			modal.find("button[id !='modalCloseBtn']").hide()
			modalModBtn.show()
			modalRemoveBtn.show()
			
			$(".modal").modal("show")
		})
		console.log(rno)
	})
	modalModBtn.on("click",function(e){//수정하는 버튼을 클릭하였을 경우
		var reply={rno:modal.data("rno"),reply:modalInputReply.val()}
		replyService.update(reply,function(result){
			alert(result)
			modal.modal("hide")
			console.log("pageNum"+pageNum)
			showList(pageNum)
		})
	})
	modalRemoveBtn.on("click",function(e){//삭제하는 버튼을 클릭하였을 경우
		var rno =modal.data("rno")
		
		replyService.remove(rno,function(result){
			alert(result)
			modal.modal("hide")
			showList(pageNum)
		})
	})
	$(".panel-footer").on("click","li a",function(e){
		e.preventDefault()
		console.log("page click")
		
		var targetPageNum = $(this).attr("href")
		console.log("targetPageNum: "+targetPageNum)
		
		pageNum = targetPageNum
		console.log("pageNum: "+pageNum)
		showList(pageNum)
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
	<div class='row'>
	<div class="col-lg-12">
	<!-- 패널 -->
	<div class="panel panel-default">
	<!-- <div class="panel-heading">
	<i class="fa fa-comments fa-fw"></i>Reply
	</div> -->
	<div class="panel-heading">
	<i class="fa fa-comments fa-fw"></i>Reply
	<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
	</div>
	<!-- 패널 헤딩 -->
	<div class="panel-body">
	<ul class="chat">
	<!-- start reply -->
	<li class="left clearfix" data-rno='12'>
	<div>
	<div class="left clearfix" data-rno='12'>
	<div>
	<div class="header">
	<strong class="primary-foot">user000</strong>
	<small class="pull-right text-muted">2018-11-04 14:43</small>
	</div>
	<p>Good job!!!</p>
	</div>
	</div>
	</div>
	</ul>
	</div>
	
	<div class="panel-footer">
	</div>
	</div>
	<!-- 숨겨진 폼을 만들어서 각각의 버튼에 대해서 다른 기능을 구현. -->
	<form id='operForm' action="/board/modify" method="get">
	<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${page.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${page.amount}"/>'> 
	<input type='hidden' name='keyword' value='<c:out value="${page.keyword}"/>'>
	<input type='hidden' name='type' value='<c:out value="${page.type}"/>'>
	</form>
</body>
</html>