<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
<script type="text/javascript"
	src="/resources/vendor/bootstrap/js/bootstrap2.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>

<link rel="stylesheet" href="/resources/css/get.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/modal.css">
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

#addReplyBtn {
	float: right;
}

.pagingArea {
	width: 100%;
	text-align: center;
}

.pagingArea .pagingInner {
	display: inline-block;
	width: 200px;
}

.pagination {
	display: inline-block;
	padding-left: 0;
	margin: 20px 0;
	border-radius: 4px;
}

.pagination>li {
	display: inline;
}

.pagination>li>a, .pagination>li>span {
	position: relative;
	float: left;
	padding: 6px 12px;
	margin-left: -1px;
	line-height: 1.42857143;
	color: #337ab7;
	text-decoration: none;
	background-color: #fff;
	border: 1px solid #ddd;
}

.pagination>li>a:hover, .pagination>li>span:hover, .pagination>li>a:focus,
	.pagination>li>span:focus {
	z-index: 2;
	color: #23527c;
	background-color: #eee;
	border-color: #ddd;
}

.pagination>.active>a, .pagination>.active>span, .pagination>.active>a:hover,
	.pagination>.active>span:hover, .pagination>.active>a:focus,
	.pagination>.active>span:focus {
	z-index: 3;
	color: #fff;
	cursor: default;
	background-color: #337ab7;
	border-color: #337ab7;
}

.btns {
	float: right;
	margin: 3px;
}

textarea {
	margin: 0px;
	width: 100%;
	min-height: 300px;
	resize: none;
	border: 0px;
	font-size: 1em;
	padding-left: 5px;
	padding-top: 5px;
}
.form-group {
    display: block;
    margin-bottom: 0;
    vertical-align: middle;
  }
  .uploadDiv {
  position: relative;
  overflow: hidden;
  display: inline-block;
}

.fbtn {
  display: inline-block;
  padding: 6px 12px;
  margin-bottom: 5px;
  margin-top:5px;
  margin-left:5px;
  font-size: 14px;
  font-weight: normal;
  line-height: 1.42857143;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
}

.uploadDiv input[type=file] {
  font-size: 100px;
  position: absolute;
  left: 0;
  top: 0;
  opacity: 0;
}
</style>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<jsp:include page="modal.jsp"></jsp:include>
<script type="text/javascript">
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$")//.뒤에 exe|sh|zip|alz의 형식을 검사하는 정규식
var maxSize = 50242880// 파일의 최대 크기 5MB
function checkExtension(fileName, fileSize) {
	if (fileSize >= maxSize) {
		alert("파일 사이즈 초과")
		return false
	}

	if (regex.test(fileName)) {
		alert("해당 종류의 파일은 업로드 할 수 없습니다.")
		return false
	}
	return true
}
function showUploadResult(uploadResultArr) {
	if(!uploadResultArr || uploadResultArr.length==0){return}
	
	var uploadUL = $(".uploadResult ul")
	
	var str=""
	//이미지파일과 일반 파일을 동시에 올리는 경우 싱크로가 안 맞는 경우가 있어서 하나의 파일마다
	//바로바로 보이게 한다.
	$(uploadResultArr).each(
					function(i, obj) {
						if (!obj.image) {
							var fileCallPath = encodeURIComponent(obj.uploadPath
									+ "/"
									+ obj.uuid
									+ "_"
									+ obj.fileName)
									var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/")
									
							str += "<li data-path='"+obj.uploadPath+"' data-uuid='"
							+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div><span>"
									+ obj.fileName+"</span>"
									+ "<button class='btn btn-warning btn-circle' type='button' data-file=\'"+fileCallPath+"\' data-type='file'>"//버튼에 클래스를 입혀서 그 모양으로 나옴.
									+ "<i class='fa fa-times'>X</i></button><br>"
									+ "<img src='/resources/images/attach.jpg'></a>"
									+ "</div></li>"
							console.log("일반파일")
							uploadUL.append(str)
							str = ""
						} else {
							//str += "<li>"+obj.fileName+"</li>"//공백문자나 한글 이름 등이 문제가 되기 때문에 인코딩을 해주어야 한다.
							var fileCallPath = encodeURIComponent(obj.uploadPath
									+ "/s_"
									+ obj.uuid
									+ "_"
									+ obj.fileName)
							console.log("이미지"+obj.image)
							var originPath = obj.uploadPath + "\\"
									+ obj.uuid + "_" + obj.fileName//원본파일의 이름
							str = "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"
							+obj.fileName+"' data-type='"+obj.image+"'><div><span>"
									+ obj.fileName
									+ "</span>"//버튼에 클래스를 입혀서 그 모양으로 나옴.
									+ "<button class='btn btn-warning btn-circle' type='button' data-file=\'"+fileCallPath+"\' data-type='image'><i class='fa fa-times'>X</i></button><br>"
									+ "<img src='/display?fileName="+fileCallPath+"'>"
									+ "</div></li>"
									uploadUL.append(str)
							str = ""
							console.log("이미지파일")
						}
					})
	//uploadUL.append(str)//업로드 된 파일을 화면에 보여준다.
}
				
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
			var keyword = $("input[name='keyword']").clone()
			var type = $("input[name='type']").clone()
			
			formObj.empty()
			formObj.append(pageNum)
			formObj.append(amount)
			formObj.append(keyword)
			formObj.append(type)
		}else if(operation==='modify'){
			console.log("submit clicked")
			var str=""
			
			$(".uploadResult ul li").each(function(i,obj){
				var jobj = $(obj)
				console.dir(jobj)
				
				str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>"
				str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>"
				str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>"
				str+="<input type='hidden' name='attachList["+i+"].image' value='"+jobj.data("type")+"'>"
			})
			formObj.append(str).submit()
		}
		formObj.submit()
	})
	
})
$(document).ready(function(){
	
	(function(){//즉시 실행함수
			var bno = ${board.bno}
			$.getJSON("/board/getAttachList",{bno:bno},function(arr){
				console.log(arr)
				
				var str = ""
				$(arr).each(function(i,attach){
					//image type
					if(attach.image){
						var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName)
						str+="<li data-path='"+attach.uploadPath+"' data-uuid='"
						+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.image+"'><div>"
						str+="<span>"+attach.fileName+"</span>"
						str+="<button type='button' data-file=\'"+fileCallPath+"\'data-type='image'"//버튼에 클래스를 입혀서 그 모양으로 나옴.
						str+="class='btn btn-warning btn-circle'><i class='fa fa-times'>X</i></button><br>"
						str+="<img src='/display?fileName="+fileCallPath+"'>"
						str+="</div></li>"
					}else{
						shortfileName= attach.fileName.substring(0,6)+".."
						str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
						+attach.fileName+"' data-type='"+attach.image+"'><div>"
						str+="<span>"+shortfileName+"</span>"
						str+="<button type='button' data-file=\'"+fileCallPath+"\'data-type='file'"
						str+="class='btn btn-warning btn-circle'><i class='fa fa-times'>X</i></button><br>"//버튼에 클래스를 입혀서 그 모양으로 나옴.
						str+="<img src='/resources/images/attach.jpg'>"
						str+="</div></li>"
					}
				})
				$(".uploadResult ul").html(str)
			})
	})()
	$(".uploadResult").on("click","button",function(e){
		console.log("delete file")
		if(confirm("이 파일을 삭제하시겠습니까?")){
			var targetLi = $(this).closest("li")
			targetLi.remove()
		}
	})
	
		$("input[type='file']").change(function(e) {
			var formData = new FormData()

			var inputFile = $("input[name=uploadFile]")

			var files = inputFile[0].files

			console.log(files)

			for (var i = 0; i < files.length; i++) {

				if (!checkExtension(files[i].name, files[i].size)) {//파일 사이즈나 파일의 확장자 제한에서 걸리면
					return false
				}
				formData.append("uploadFile", files[i])//그렇지 않다면 폼데이터에 추가하라.
			}

			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				dataType : 'json',//결과를 json타입으로 받겠다.
				success : function(result) {//result는 다시 받는 결과값을 의미.
					console.log(result)
					showUploadResult(result)
	/*				$(".uploadDiv").html(cloneObj.html())//업로드하고 버튼을 클릭하면 다시 초기화가 된다. */
				}
			})
		})
})
</script>
<script type="text/javascript" src="/resources/js/modal.js"></script>
<script type="text/javascript" src="/resources/js/replyshow.js"></script>
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
		<form role="form" action="/board/modify" method="post">
		<div id="contentsWrap">
			<div class="sideBarArea">
				<nav class="sideNavWrap">
					<h3>
						<span>Board&nbsp;>>&nbsp;</span>자유게시판
					</h3>
					<ul class="sideNav">
						<li class="homeLink"><a href="/index" title="홈으로">Home</a></li>
						<li class="freeBLink"><a href="#none" title="자유게시판">Free
								Board</a></li>
						<li class="marketBLink"><a href="#none" title="마켓게시판">Share
								Market</a></li>
					</ul>
				</nav>
			</div>
			<div class="contentsArea">
				<section id="showContents">
					<article id="contentInfo">
						<h4>
							작성자 <span>님의 게시물입니다.</span>
						</h4>
						<div>
							<span> 작성자 <b><input name='writer' value="${board.writer}"
					readonly="readonly"></b>
							</span> <span> 작성일 <b><input name='regdate'
					value='<fmt:formatDate value="${board.regdate}" pattern="yyyy/MM/dd"/>'
					readonly="readonly"></b>
							</span>
						</div>
						<p class="contentAddr">
							<a href="#none" title="글의 주소">글의 주소</a>
							<button onClick="copyAddr()">주소 복사</button>
						</p>
					</article>
					<article id="boardArticle">
						<div class="articleTitle">
							<h4>글 제목 : <input name='title' value="${board.title}"></h4>
							<p>글 번호 : <input name='bno' value='${board.bno}'
					readonly="readonly"></p>
						</div>
						<div class="articleDetail">
							<p>
								<textarea name='content'>${board.content}</textarea>
							</p>
						</div>
					</article>
				</section>
				<article class="panel-heading"></article>
				<section class="panel-body">
					<article class="uploadResult">
						<!-- 파일이 보이는곳 -->
						<div class="form-group uploadDiv">
				<button class="fbtn">파일 첨부</button>
								<input type="file" name='uploadFile' multiple="multiple">
							</div>
						<ul>

						</ul>
					</article>
				</section>
				<div class="hiddenFormArea"></div>
				<div>
					<button type="submit" class="btn btns" data-oper='modify'>수정</button>
					<button type="submit" class="btn btns" data-oper='remove'>삭제</button>
					<button type="submit" class="btn btns" data-oper='list'>목록</button>
				</div>
			</div>
			<div class="adsArea">
				<ul>
					<li><a
						href="https://www.wdc.com/ko-kr/products/portable-storage.html"
						title="광고1" target="_blank"> <img class="adImg01"
							src="/resources/images/ads/adimg01.jpg"
							alt="광고1 western digital 이미지" />
					</a></li>
					<li><a href="https://www.sandisk.co.kr/home" title="광고2"
						target="_blank"> <img class="adImg02"
							src="/resources/images/ads/adimg02.jpg" alt="광고2 sandisk 이미지" />
					</a></li>
					<li><a href="https://www.seagate.com/kr/ko/consumer/backup/"
						title="광고3" target="_blank"> <img class="adImg03"
							src="/resources/images/ads/adimg03.jpg" alt="광고3 seagate 이미지" />
					</a></li>
				</ul>
			</div>
			<!-- 숨겨진 폼을 만들어서 각각의 버튼에 대해서 다른 기능을 구현. -->
			<div>
			<input type="hidden" class="form-control" name='updateDate'
				value='<fmt:formatDate value="${board.updateDate}" pattern="yyyy/MM/dd/"/>'>
			<input type="hidden" name='pageNum' value='${page.pageNum}'>
			<input type="hidden" name='amount' value='${page.amount}'> <input
				type='hidden' name='keyword' value='${page.keyword}'> <input
				type='hidden' name='type' value='${page.type}'>
				</div>
				</div>
				</form>
				<%-- <input type="hidden" id="bno" name="bno"
					value="<c:out value='${board.bno}'/>"> <input type="hidden"
					name="pageNum" value="<c:out value='${page.pageNum}'/>"> <input
					type="hidden" name="amount" value="<c:out value='${page.amount}'/>">
				<input type="hidden" name="keyword"
					value="<c:out value='${page.keyword}'/>"> <input
					type="hidden" name="type" value="<c:out value='${page.type}'/>"> --%>
		</div>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>