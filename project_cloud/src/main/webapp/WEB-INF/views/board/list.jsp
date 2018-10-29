<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FreeBoard</title>
<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="/resources/css/board.css">
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
					<p class="title4">수정일</p>
				</li>
				<c:forEach var="list" items="${list}">
				<li class="contentRow">
					<p>${list.bno}</p><!--  target='_blank' -->
					<p><a  class='move' href='<c:out value="${list.bno}"/>'>
					<c:out value="${list.title }"/></a></p>
					<p>${list.writer }</p>
					<p><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}"/></p>
					<p><fmt:formatDate pattern="yyyy-MM-dd" value="${list.updateDate}"/></p>
				</li>
				</c:forEach>
				<li class="btnRow">
					<div>
						<button id='write_board' class="btn" title="글쓰기">글쓰기</button>
					</div>
				</li>
			</ul>
			<div>
			<ul>
			<c:if test="${page.prev}">
			<li><a href="${page.startPage-1}">Previous</a></li>
			</c:if>
			<c:forEach var="num" begin="${page.startPage}" end="${page.endPage}">
			<p class="page_button  ${page.page.pageNum == num ? "active" : ""} "> 
			<a href="${num}" title="1"><span>${num}</span></a></p>
			</c:forEach>
			
			<c:if test="{page.next}">
			<li><a href="${page.endPage+1}">Next</a>
			</c:if>
			</ul>
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
	<form id='actionForm' action="/board/list" method="get">
	<input type='hidden' name='pageNum' value='${page.page.pageNum}'>
	<input type='hidden' name='amount' value='${page.page.amount}'>
	</form>
	<!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                            처리가 완료되었습니다.
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->
<script type="text/javascript">
	$(document).ready(function(){
		var result='<c:out value="${result}"/>'
		checkModal(result)
		history.replaceState({},null,null)
		function checkModal(result){
			if(result===' '||history.state){//뒤로가기 버튼을 입력하거나 처음으로 list를 들어갔을 경우 모달 창이 안뜨게 하는 것.
				return
			}
			if(parseInt(result)>0){
				$(".modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다.")
			}
			$("#myModal").modal("show");
		}
		$("#write_board").on("click",function(){
			self.location="/board/register"
		})
		
		var actionForm = $("#actionForm")
		
		$(".page_button a").on("click",function(e){
			e.preventDefault()
			
			console.log('click')
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"))
			actionForm.submit()
		})
		
		$(".move").on("click",function(e){
			e.preventDefault()
			
			console.log('click')
			actionForm.append("<input type='hidden' name='bno' value='"+
					$(this).attr("href")+"'>")//bno값을 추가하는 input태그를 생성
			actionForm.attr("action","/board/get")//액션값을 바꿔서 상세보기로~
			actionForm.submit()
		})
		
	})
		
	</script>
</body>
</html>