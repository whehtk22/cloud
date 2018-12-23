<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	<script type="text/javascript" src="/resources/vendor/bootstrap/js/bootstrap2.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<link rel="stylesheet" href="/resources/css/get.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<div class='bigPictureWrapper'>
	<div class="bigPicture"></div>
</div>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name='reply'
						value='New Reply'>
				</div>
				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name='replyer'
						value='replyer'>
				</div>
				<div class="form-group">
					<label>Reply Date</label> <input class="form-control"
						name='replyDate' value=' '>
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
		replyService.get(10,function(data){
			console.log(data)
		})
		
function showImage(fileCallPath){
			$(".bigPictureWrapper").css("display","flex").show()
			
			$(".bigPicture")
			.html("<img src='/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%',height:'100%'},1000)
		}
$(document).ready(function(){
	
	(function(){//즉시 실행함수
		var bno = '<c:out value="${board.bno}"/>'
			
			$.getJSON("/board/getAttachList",{bno:bno},function(arr){
				console.log(arr)
				
				var str = ""
				$(arr).each(function(i,attach){
					//image type
					if(attach.image){
						var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName)
						str+="<li data-path='"+attach.uploadPath+"' data-uuid='"
						+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.image+"'><div>"
						str+="<img src='/display?fileName="+fileCallPath+"'>"
						str+="</div></li>"
					}else{
						str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
						+attach.fileName+"' data-fileType='"+attach.image+"'><div>"
						str+="<span> "+attach.fileName+"</span><br>"
						str+="<img src='/resources/images/attach.jpg'>"
						str+="</div></li>"
					}
				})
				$(".uploadResult ul").html(str)
			})
	})()
		
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
	
	$(".uploadResult").on("click","li",function(e){
		console.log("view image")
		var liObj = $(this)
		
		var path= encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"))
		
		if(liObj.data("type")){//이미지파일인 경우
			showImage(path.replace(new RegExp(/\\/g),"/"))// \\를 모두 /로 바꾼다.
			//함수로 전달하는 과정에서 문제가 생기므로 변환한다.
		}else{
			self.location="/download?fileName="+path//일반파일인 경우
		}
	})
	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%',height:'0%'},1000)
		setTimeout(function(){
			$(".bigPictureWrapper").hide()
		},1000)
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
	modalCloseBtn.on("click",function(e){
		modal.modal("hide")
		showList(pageNum)
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
<jsp:include page="../include/header.jsp"></jsp:include>
	 <!--contents container starts-->
  <div id="container">
    <div id="mainVisualWrap">
      <div id="mainVisual">
        <p class="imgArea">
          <h2>메인비쥬얼</h2>
        </p>
        <p class="textArea">
          Welcome to our <span>Mini&nbsp;Cloud</span>, <strong>Board</strong>
        </p>
      </div>
    </div>
    <div id="contentsWrap">
      <div class="sideBarArea">
        <nav class="sideNavWrap">
          <h3>
            <span>Board&nbsp;>>&nbsp;</span>자유게시판
          </h3>
          <ul class="sideNav">
            <li class="homeLink"><a href="/index" title="홈으로">Home</a></li>
            <li class="freeBLink"><a href="#none" title="자유게시판">Free Board</a></li>
            <li class="marketBLink"><a href="#none" title="마켓게시판">Share Market</a></li>
          </ul>
        </nav>
      </div>
      <div class="contentsArea">
        <h3>자유게시판</h3>
        <section id="showContents">
          <article id="contentInfo">
            <h4>작성자 <span>님의 게시물입니다.</span></h4>
            <div>
              <span>
                작성자
                <b>${board.writer}</b>
              </span>
              <span>
                작성일
                <b>${board.regdate}</b>
              </span>
              <span>
                조회수
                <b>${content.bHit}</b>
              </span>
            </div>
            <p class="contentAddr">
              <a href="#none" title="글의 주소">글의 주소</a>
              <button onClick="copyAddr()">주소 복사</button>
            </p>
          </article>
          <article id="boardArticle">
            <div class="articleTitle">
              <h4>글 제목${board.title}</h4>
              <p>글 번호 ${board.bno}</p>
            </div>
            <div class="articleDetail">
              <p>글 내용${board.content}</p>
            </div>
          </article>
        </section>
        <section id="rplArea">
          <article id="showRpl">
            <h3 class="hide">댓글 표시 영역</h3>
            <h4>
              댓글 <span>N</span>건
            </h4>
            <dl class="rplUnit">
              <dt>
                <img src="../../images/profile/man.png" alt="댓글 썸네일">
              </dt>
              <dd>
                <div>
                  <p class="rplInfo">
                    <span>댓글쓴이</span>
                    <span>댓글날짜시각</span>
                  </p>
                  <p class="rplTxt">
                    댓글텍스트
                  </p>
                  <p class="rplBtn">
                    <!--댓글에 대해-->
                    <button>답글</button>
                    <button>수정</button>
                    <button>삭제</button>
                  </p>
                </div>
              </dd>
            </dl>
            <dl class="rplUnit">
              <dt>
                <img src="../../images/profile/man.png" alt="댓글 썸네일">
              </dt>
              <dd>
                <div>
                  <p class="rplInfo">
                    <span>댓글쓴이</span>
                    <span>댓글날짜시각</span>
                  </p>
                  <p class="rplTxt">
                    댓글텍스트
                  </p>
                  <p class="rplBtn">
                    <!--댓글에 대해-->
                    <button>답글</button>
                    <button>수정</button>
                    <button>삭제</button>
                  </p>
                </div>
              </dd>
            </dl>
          </article>
          <article id="writeRpl">
            <div>
              <form class="writeRpl" action="#" method="post">
                <fieldset>
                  <p class="inputTxt">
                    <input type="text" name="reply"/>
                  </p>
                  <p class="rplSubmit">
                    <button>댓글입력</button>
                  </p>
                </fieldset>
              </form>
            </div>
          </article>
        </section>
       <%--  <div class="pagingArea">
          <ul class="pagingInner">
            <c:if test="${page.prev}">
            <li>
              <a href="${page.startPage-1}">
                Previous
              </a>
            </li>
            </c:if>
            <c:forEach var="num" begin="${page.startPage}" end="${page.endPage}">
            <li>
              <p class="page_button  ${page.page.pageNum == num ? "active" : ""} ">
              <a href="${num}" title="1"><span>${num}</span></a></p>
            </li>
            </c:forEach>
            <c:if test="{page.next}">
            <li>
              <a href="${page.endPage+1}">
                Next
              </a>
            </li>
            </c:if>
          </ul>
        </div> --%>
        <div class="hiddenFormArea">
          <%-- <form id='actionForm' action="/board/list" method="get">
            <input type='hidden' name='pageNum' value='${page.page.pageNum}'>
            <input type='hidden' name='amount' value='${page.page.amount}'>
            <input type='hidden' name='type' value='${page.page.type}'>
            <input type='hidden' name='keyword' value='${page.page.keyword}'>
          </form> --%>
        </div>
        <div>
          <button data-oper='modify'>[수정]</button>
    			<button data-oper='remove'>[삭제]</button>
    			<button data-oper='list'>[목록]</button>
    			<a href="/jimmyZip/board/b_reply_form.board?bId=${content.bId}">[답변]</a>
        </div>
      </div>
      <div class="adsArea">
        <ul>
          <li>
            <a href="https://www.wdc.com/ko-kr/products/portable-storage.html" title="광고1" target="_blank">
              <img class="adImg01" src="../../images/ads/adimg01.jpg" alt="광고1 western digital 이미지"/>
            </a>
          </li>
          <li>
            <a href="https://www.sandisk.co.kr/home" title="광고2" target="_blank">
              <img class="adImg02" src="../../images/ads/adimg02.jpg" alt="광고2 sandisk 이미지"/>
            </a>
          </li>
          <li>
            <a href="https://www.seagate.com/kr/ko/consumer/backup/" title="광고3" target="_blank">
              <img class="adImg03" src="../../images/ads/adimg03.jpg" alt="광고3 seagate 이미지"/>
            </a>
          </li>
        </ul>
      </div>
      <!-- 숨겨진 폼을 만들어서 각각의 버튼에 대해서 다른 기능을 구현. -->
    	<form id="operForm" action="/board/modify" method="get">
      	<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>">
      	<input type="hidden" name="pageNum" value="<c:out value='${page.pageNum}'/>">
      	<input type="hidden" name="amount" value="<c:out value='${page.amount}'/>">
      	<input type="hidden" name="keyword" value="<c:out value='${page.keyword}'/>">
      	<input type="hidden" name="type" value="<c:out value='${page.type}'/>">
    	</form>
    </div>
    </div>
    <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>