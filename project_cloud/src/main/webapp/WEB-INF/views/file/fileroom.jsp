<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>FileRoom Home</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
	<link href="/resources/vendor/bootstrap/css/bootstrap.css"
	rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="/resources/css/jquery.percentageloader-0.2.css">
	<style>
		#uploadfile{
			position:fixed;top:-1000px;
			/* display:none; */
		}
		.bar{
		background-color: black;
		}
		#topLoader{
		width:256px;
		height:256px;
		margin-bottom:32px;
		}
		#procontainer{
		width:940px;
		padding:10px;
		margin-left:auto;
		margin-right:auto;
		}
		/* p{
		font-size:12px;
		width:160px;
		/* word-wrap:break-word; */
		
		
		} */
		.check{
			width:160px;
		}
		li:hover {
		opacity: 0.5;
}
.file_li .list_head{
	position:relative;
	overflow:hidden;
	height:25px;
	text-align:right;
	background:#f9f9f9;
}
.file_li .list_head li{
	display:inline-block;
	height:100%;
	text-align:left;
}
.file_li .list_sort{
	position:relative;
	width:100%;
	height:26px;
}
.file_li .list_head li.check{
	float:left;
	text-indent:8px;
}
.file_li .list_head li.type{
	float:left;
}
.file_li .list_head li.filename{
	position:relative;
	float:left;
	text-align:left;
}
.file_li .list_head li.span{
	display:inline-block;
	margin-top:6px;
	letter-spaicng:-1px;
	text-indent:8px;
}
.fileViewInner_ct .fileViewlist .list_body_li .list_body{
	position:relative;
	overflow:hidden;
	height:31px;
	text-align:right;
	white-space:nowrap;
}
.fileViewInner_ct .fileViewlist .list_body_li{
	border-bottom: 1px solid #f1f1f1;
}
.fileViewInner_ct .fileViewlist .list_body_li li{
	display:inline-block;
	padding:9px 0 0 0;
	line-height:18px;
	vertial-align:top;
}
.fileViewInner_ct .fileViewlist .list_body_li li.check{
	float:left;
	padding-top:11px;
	text-align:left;
	text-indent:8px;
}
.fileViewInner_ct .fileViewlist .list_body_li li.type{
	float:left;
	padding-top:10px;
	text-indent:1px;
}
.fileViewInner_ct .fileViewlist .list_body_li li.filename{
	float:left;
	text-align:left;
}
.fileViewInner_ct .fileViewlist .list_body_li li.type img{
	float: left;
}
	</style>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="//code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="/resources/js/jquery.percentageloader-0.2.js"></script>
 <script>
 var percentComplete=0;
 var username=null;
 <sec:authorize access="isAuthenticated()">
	
 username='<sec:authentication property="principal.username"/>';
 </sec:authorize>
 var csrfHeaderName = "${_csrf.headerName}"
var csrfTokenValue = "${_csrf.token}"
 $(document).on("ready",function(){
	 $("#full").hide()
	 console.log($(".fileViewInner > li").size())
	 $(".fileViewInner").on("click","li",function(){
		 console.log("클릭")
		 $(this).find('.input_check').each(function(){
			if($(this).is(":checked"))  $(this).prop("checked",false); 
			else if(!$(this).is(":checked"))$(this).prop("checked",true); 
	 })
	 })
	 $(".fileViewlist").on("click","li",function(){
		 $(this).find('.input_check').each(function(){
			 if($(this).is(":checked")) $(this).prop("checked",false)
			 else $(this).prop("checked",true)
		 })
	 })
	 /*업로드한 파일 목록 3줄 넘어가면 스크롤 생기기*/
	 
	 
	 $("#uploadfile").on('change', function () {//인풋태그에서의 변화가 있을 경우에.
		 var topLoader = new PercentageLoader(document.getElementById('toploader'), {
              width: 256, height: 256, controllable: true, progress: 0.5, onProgressUpdate: function (val) {
                this.setValue(Math.round(val * 100.0) + 'kj');
              }
            })
		 console.log(this.files);
	 		console.log("태그변화")
		  var files = this.files
		  var formData = new FormData()	 		
		  for (var i = 0; i < files.length; i++) {

				if (!checkExtension(files[i].name, files[i].size)) {//파일 사이즈나 파일의 확장자 제한에서 걸리면
					return false
				}
				console.log("추가추가")
				formData.append("uploadFile", files[i])//그렇지 않다면 폼데이터에 추가하라.
				formData.append("username",username)
				console.log("username+"+username)
				console.log(formData.get("uploadFile"))
			}
			$.ajax({
				xhr:function(){
					var xhr = new window.XMLHttpRequest()
					//흑막.
					xhr.upload.addEventListener("progress",function(evt){
						if(evt.lengthComputable){
							var kb = evt.loaded
							var totalKb = evt.total
							percentComplete = parseInt(percentComplete*100)
							topLoader.setProgress(kb/totalKb)
							topLoader.setValue(kb.toString()+'kb')
								console.log("킬로"+kb/totalKb)
							console.log("percentComplete"+percentComplete)
							if(kb/totalKb===1){
								$("#toploader").empty()//업로드 진행이 다 되면 프로그레스바 비우기
							}
						}
					},false)
					return xhr
				},
				url : '/file/upload',
				processData : false,
				contentType : false,
				data : formData,
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type : 'POST',
				dataType : 'json',//결과를 json타입으로 받겠다.
				success : function(result) {//result는 다시 받는 결과값을 의미.
					console.log(result)
					showUploadedFilediv(result)
				}
			})
			
		})
		})
 </script>
  <script src="/resources/js/file2.js"></script> 
  <script src="/resources/js/file3.js"></script>
</head>
<body>
	<div id="wrapper">
		<!-- header starts -->
		<jsp:include page="../include/header.jsp"/>
		<!-- header ends -->
		<!-- container starts -->
		<div id="container" class="cloudMainWrap">
			<div id="cloudContentsWrap">
				<section id="sideBarWrap">
					<h2>sidebar area</h2>
					<div id="userInfo">
						<h3 class="hide">profile and info</h3>
						<div class="profile">
							<p class="profileImg">
								<img class="defaultProfile" src="/resources/images/profile/man.png" alt="user default profile image"/>
							</p>
							<div class="infoArea">
								<p class="nickname"><span><sec:authentication property="principal.username"/></span></p>
								<p class="storageVolume">
									<a class="storageVolumeInner" href="#none" title="나의 잔여용량 보기">
										<span class="usedVolume">${total}</span>&nbsp;/&nbsp;<span class="totalVolume">32</span>
										<span class="volumeUnit">GB</span>
									</a>
								</p>
								<p class="graphArea">
									<span class="outerBar">
										<em class="innerBar"></em>
									</span>
								</p>
							</div>
						</div>
					</div>
					<nav>
						<ul class="sideNav classByType">
							<li><a href="javascript:void(0)" onclick="viewAll('<sec:authentication property="principal.username"/>');return;"title="기본 모아보기">기본</a></li>
							<li><a href="javascript:void(0)" onclick="viewDocu('<sec:authentication property="principal.username"/>');return;"title="문서 모아보기">문서</a></li>
							<li><a href="javascript:void(0)" onclick="viewVideo('<sec:authentication property="principal.username"/>');return;" title="영상 모아보기">영상</a></li>
							<li><a href="javascript:void(0)" onclick="viewImage('<sec:authentication property="principal.username"/>');return;" title="사진 모아보기">사진</a></li>
							<li><a href="#none" title="즐겨찾기 모아보기">즐겨찾기</a></li>
							<li><a href="#none" title="즐겨찾기 모아보기">숨김|중요</a></li>
							<li><a href="javascript:void(0)" onclick="deleteFile();return;" title="즐겨찾기 모아보기">삭제</a></li>
						</ul>
						<ul class="connToExt">
							<li class="msTree"><a href="#none" title="내 윈도우 탐색기 연동"></a></li>
							<li class="macTree"><a href="#none" title="내 Mac 탐색기 연동"></a></li>
							<li><a href="#none" title="내 외장하드 연동">외장하드 연동</a></li>
						</ul>
					</nav>
				</section>
				<section id="subHeader">
					<h2>subHeader area</h2>
					<div class="subNavOuter">
						<nav class="subNavInner">
							<div class="btnArea1">
								<h3 class="hide">기능버튼 영역</h3>
								<p>
								<!--  -->
									<a href="javascript:void(0);" onclick="openFileOption();return;" id="uploadBtn" title="업로드 버튼" >
										<img src="/resources/images/icons/upload4.png" alt="업로드 아이콘" >
										<span class="hide">upload</span>
									 </a> 
									 <input type="file" id="uploadfile" name="uploadfile" multiple>
								</p>
								<p>
									<a href="javascript:void(0);" onclick="downLoadFile();return;" id="downloadBtn" title="다운로드 버튼">
										<img src="/resources/images/icons/download5.png" alt="다운로드 아이콘">
										<span class="hide">다운로드</span>
									</a>
								</p>
								<p>
									<a href="javascript:void(0);" onclick="deleteFile();return;" id="deleteBtn" title="삭제 버튼">
										<img src="/resources/images/icons/delete_100_124_5.png" alt="삭제 아이콘">
										<span class="hide">삭제</span>
									</a>
								</p>
								<p>
									<a href="javascript:void(0);" title="이름변경 버튼">
										<img src="/resources/images/icons/change_name4.png" alt="이름변경 아이콘">
										<span class="hide">이름변경</span>
									</a>
								</p>
							</div>
							<div class="btnArea2">
								<h3 class="hide">그리드 및 정보버튼 영역</h3>
								<p class="gridStyleBtn">
									<!-- 그리드 형식 보기가 디폴트방식 -->
									<a href="#none" title="그리드 형식으로 보기" onclick="showGrid('<sec:authentication property="principal.username"/>')">
										<img src="/resources/images/icons/grid5.png" alt="그리드 형식 보기 아이콘">
										<span class="hide">그리드 보기</span>
									</a>
								</p>
								<p class="listStyleBtn">
									<a href="#none" title="리스트 형식으로 보기" onclick="view_li('<sec:authentication property="principal.username"/>')">
										<img src="/resources/images/icons/list5.png" alt="리스트 형식 보기 아이콘">
										<span class="hide">리스트 보기</span>
									</a>
								</p>
								<p class="showInfoBtn">
									<a href="#none" title="파일 또는 폴더 정보보기">
										<img src="/resources/images/icons/info4.png" alt="정보보기 아이콘">
										<span class="hide">정보보기</span>
									</a>
								</p>
							</div>
						</nav>
					</div>
				</section>
				<section id="dataAreaWrap">
					<h2>data list area</h2>
					<h3 class="hide">drag and drop업로드가 구현되어야 할 부분</h3>
						<div id="fileView"><!-- 파일드롭구역 -->
							<ul class="fileViewInner">
								 <li class="firstSlot slot"><!-- onClick="firstFileUp()" -->
									<p class="check">
										<!--  <a href="#none" title="클릭해서 업로드하기"> -->
											<img src="/resources/images/icons/add_file.png" alt="클릭해서 업로드하는 버튼"/>
										<!-- </a> -->
									</p>
								</li>
							</ul>
							</div>
							<div class="file_li">
							<div class="fileViewInner_li"><!-- 테이블헤더 -->
							
							</div>
							<div class="fileViewInner_ct"><!-- 테이블바디 -->
							<ul class="fileViewlist">
							</ul>
							</div>
							</div>
						<div>
						
						</div>
						<!-- <div id="full"></div> -->
						<!-- <div class="progress-bar" data-percent="100"></div> -->
						<div id="procontainer">
						<div id="toploader"></div>
						</div>
						
						<!-- <div id="pgb"></div> -->
				</section>
				<section id="dataInfoWrap"><!-- hidden이었다가 modal -->
					<h2>data info area modal</h2>
					<h3 class="hide">선택된 디렉터리 또는 파일 정보 표시영역</h3>
					<div class="infoOuter">
						<div class="closeBtn">
							<p>
								<span class="upBar"></span>
								<span class="btmBar"></span>
							</p>
						</div>
						<dl class="infoInner">
							<dt class="infoTitle">
								<strong>파일유형</strong>
								<img src="" alt="해당 데이터 썸네일"/>
							</dt>
							<dd class="infoDetail">
								<h4>상세정보</h4>
								<div class="dataDesc">
									<ol>
										<li class="basic">
											<strong class="descTitle1">유형</strong>
											<p class="descCont1">사진</p>
										</li>
										<li class="basic">
											<strong class="descTitle2">수정일시</strong>
											<p class="descCont1">2018년10월13일</p>
										</li>
										<li class="basic">
											<strong class="descTitle3">크기</strong>
											<p class="descCont1">10MB</p>
										</li>
										<li class="basic">
											<strong class="descTitle4">저장경로</strong>
											<p class="descCont1"></p>
										</li>
										<li class="pic">
											<strong class="descTitle4">모델명</strong>
											<p class="descCont1">Apple<i>|</i>iPhone 5s</p>
										</li>
										<li class="pic">
											<strong class="descTitle4">해상도</strong>
											<p class="descCont1">3264<i class="multiple">x</i>2448</p>
										</li>
										<li class="pic">
											<strong class="descTitle4">정보</strong>
											<p class="descCont1">
												<span>ISO 64<i class="devider">|</i></span>
												<span>f2.2<i class="devider">|</i></span>
												<span>4.15mm<i class="devider">|</i></span>
												<span>1/30s<i class="devider">|</i></span>
											</p>
										</li>
									</ol>
								</div>
							</dd>
						</dl>
					</div>
				</section>
			</div>
		</div>
		<!-- container starts -->
		<!-- footer starts -->
		<script>
		$(document).on("ready",function(){
			var elems = $(".innerBar")
			console.log(elems)
			var width = parseFloat($(".usedVolume").text())/parseFloat($(".totalVolume").text())*100
			elems.css("width",width+"%")
		})
		</script>
		<jsp:include page="../include/footer.jsp"/>
		<!-- footer ends -->
	</div>
</body>
</html>