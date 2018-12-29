<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
	<!-- <meta charset="EUC-KR"> -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>FileRoom Home</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
	<script src="/resources/js/jquery-1.12.4.min.js" type="text/javascript"></script>
	<script src="/resources/js/floating-ads.js" type="text/javascript"></script>
	<script src="/resources/js/ajax.js" type="text/javascript"></script>
	<script >
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
										+ "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'>"
										+ "<i class='fa fa-times'>X</i></button><br>"
										+ "<img src='/resources/img/attach.png'></a>"
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
										+ "</span>"
										+ "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'><i class='fa fa-times'>X</i></button><br>"
										+ "<img src='/display?fileName="+fileCallPath+"'>"
										+ "</div></li>"
										uploadUL.append(str)
								str = ""
								console.log("이미지파일")
							}
						})
		//uploadUL.append(str)//업로드 된 파일을 화면에 보여준다.
	}
	$(document).ready(function(e){
		var formObj = $("form")
		console.log(formObj)
		$("input[type='submit']").on("click",function(e){
			e.preventDefault()
			
			console.log("submit clicked")
			
			var str=""
			$(".uploadResult ul li").each(function(i,obj){
				var jobj = $(obj)
				console.log("이미지인"+jobj.data("type"))
				str +="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>"
				str +="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>"
				str +="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>"
				str +="<input type='hidden' name='attachList["+i+"].image' value='"+jobj.data("type")+"'>"
				console.log(str)
				formObj.append(str)
			})
			console.log(formObj)
			$("form").submit()
			
		})
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$("input[type='file']").change(function(e) {
			var formData = new FormData()

			var inputFile = $("input[name=upload]")

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
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : formData,
				type : 'POST',
				dataType : 'json',//결과를 json타입으로 받겠다.
				success : function(result) {//result는 다시 받는 결과값을 의미.
					console.log(result);
					showUploadResult(result)
				}
			})
		})
		$(".uploadResult").on("click","button",function(e){
			console.log("delete file")
			
			var targetFile = $(this).data("file")
			console.log(targetFile)
			var type=$(this).data("type")
			console.log(type)
			var targetLi = $(this).closest("li")
			console.log(targetLi)
			$.ajax({
				url:'/deleteFile',
				data:{fileName:targetFile, type:type},
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				dataType:'text',
				type:'POST',
				success:function(result){
					alert(result)
					targetLi.remove()
				}
			})
		})
	
	})
	</script>
</head>
<body>
	<!-- header starts -->
	<jsp:include page="../include/header.jsp"/>
	<!-- header ends -->
	<div id="container">
		<div id="mainVisualWrap">
			<div id="mainVisual">
				<p class="imgArea">
					<h2>메인비쥬얼</h2>
					<!-- <img src="./images/bg_landing.jpg" alt="메인비주얼"/> -->
				</p>
				<p class="textArea">
					Welcome to our <span>Mini&nbsp;Cloud</span>, <strong>Board</strong>
				</p>
			</div>
		</div>
		<div id="contentsWrap">
			<div class="sideBarArea">
				<nav class="sideNavWrap">
					<h3><span>Board&nbsp;>>&nbsp;</span>자유게시판</h3>
					<!-- 이 부분은 하단의 링크버튼 클릭에 따라 해당 게시판명으로 변경 -->
					<ul class="sideNav">
						<li class="homeLink"><a href="/index" title="홈으로">Home</a></li>
						<li class="freeBLink"><a href="#none" title="자유게시판">Free Board</a></li>
						<li class="marketBLink"><a href="#none" title="마켓게시판">Share Market</a></li>
					</ul>
				</nav>
			</div>
			<div class="formArea">
				<h3>게시판 글 작성</h3>
				<form class="writeForm" action="/board/register" method="post">
					<fieldset id="write_form">
						<div class="formInner">
							<h4 class="hide">자유게시판</h4>
							<p>
								<label for="writer">작성자</label>
								<input type="text" name="writer" value='<sec:authentication property="principal.username"/>' required/>
								<%--  <input type="text" name="bName" size="10"> --%>
								<%-- ${user_name}(${user_id}) --%>
								<%-- input을 가려서 파라미터가 없어졌으니 히든으로 이름정보를 DB에 넘겨야--%>
							</p>
							<p>
								<label>글 제목</label>
								<input type="text" name="title" size="20" required/>
							</p>
							<p>
								<label>작성시간</label>
								<span class="wTime">작성시간</span>
							</p>
							<hr/>
							<p>
								<label class="hide">내용</label>
								<textarea name="content"></textarea>
								<!-- <textarea name="content" rows="10" cols="50"></textarea> -->
							</p>
						</div>
						<hr/>
						<div class="form-group uploadDiv attachFiles">
							<p>
								<label for="file">파일첨부</label><!--
							 --><input type="file" name="upload" multiple/><!--
							 --></p>
						</div>
						<div class='uploadResult'>
						<ul></ul>
						</div>
						<div class="btnArea">
							<p>
								<button class="btn btnTempSave">임시저장</button>
							<input type="submit" class="btn btn-default" value="작성완료" ><!--
							 --><a class="goListBtn" href="/board/list" title="글 목록 보기">글목록</a>
							</p>
						</div>
					</fieldset>
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
				</form>
			</div>
			<div class="adsArea">
				<ul>
					<li>
						<a href="https://www.wdc.com/ko-kr/products/portable-storage.html" title="광고1" target="_blank">
							<img class="adImg01" src="/resources/images/ads/adimg01.jpg" alt="광고1 western digital 이미지"/>
						</a>
					</li>
					<li>
						<a href="https://www.sandisk.co.kr/home" title="광고2" target="_blank">
							<img class="adImg02" src="/resources/images/ads/adimg02.jpg" alt="광고2 sandisk 이미지"/>
						</a>
					</li>
					<li>
						<a href="https://www.seagate.com/kr/ko/consumer/backup/" title="광고3" target="_blank">
							<img class="adImg03" src="/resources/images/ads/adimg03.jpg" alt="광고3 seagate 이미지"/>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- footer starts -->
	<jsp:include page="../include/footer.jsp"/>
	<!-- footer ends -->
</body>
</html>