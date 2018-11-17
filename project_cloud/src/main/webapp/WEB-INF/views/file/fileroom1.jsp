<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>FileRoom Home</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
	<style rel="stylesheet" type="text/css"><!--임의적으로 만든 것이라 수정가능.-->
		/* .uploadResult{
			width:100%;
			background-color:blue;
		}
		
		.uploadResult ul{
			display:flex;
			flex-flow:row;
			justify-content:center;
			align-items:center;
		}
		.uploadResult ul li{
			list-style:none;
			padding:10px;
		}
		.uploadResult ul li img{
			width:20px;
		} */
	</style>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="/resources/js/jquery-1.12.4.min.js"></script>
	<script src="/resources/js/file.js"></script>
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
								<!-- <div class="hide man license">Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div> -->
								<!-- <div class="hide woman license">Icons made by <a href="https://www.flaticon.com/authors/pixel-perfect" title="Pixel perfect">Pixel perfect</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div> -->
								<img class="defaultProfile" src="/resources/images/profile/man.png" alt="user default profile image"/>
							</p>
							<div class="infoArea">
								<p class="nickname"><span>userNickName</span></p>
								<p class="storageVolume">
									<a class="storageVolumeInner" href="#none" title="나의 잔여용량 보기">
										<span class="usedVolume">1.6</span>&nbsp;/&nbsp;<span class="totalVolume">32</span>
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
							<li><a href="#none" title="문서 모아보기">문서</a></li>
							<li><a href="#none" title="영상 모아보기">영상</a></li>
							<li><a href="#none" title="사진 모아보기">사진</a></li>
							<li><a href="#none" title="즐겨찾기 모아보기">즐겨찾기</a></li>
							<li><a href="#none" title="즐겨찾기 모아보기">숨김|중요</a></li>
							<li><a href="#none" title="즐겨찾기 모아보기">휴지통</a></li>
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
									<a href="#none" title="업로드 버튼">
										<img src="/resources/images/icons/upload4.png" alt="업로드 아이콘">
										<span>upload</span>
									</a>
								</p>
								<p>
									<a href="#none" title="다운로드 버튼">
										<img src="/resources/images/icons/download5.png" alt="다운로드 아이콘">
										<span>다운로드</span>
									</a>
								</p>
								<p>
									<a href="#none" title="삭제 버튼">
										<img src="/resources/images/icons/delete_100_124_5.png" alt="삭제 아이콘">
										<span>휴지통</span>
									</a>
								</p>
								<p>
									<a href="#none" title="이름변경 버튼">
										<img src="/resources/images/icons/change_name4.png" alt="이름변경 아이콘">
										<span>이름변경</span>
									</a>
								</p>
							</div>
							<div class="btnArea2">
								<h3 class="hide">그리드 및 정보버튼 영역</h3>
								<p class="gridStyleBtn">
									<!-- 그리드 형식 보기가 디폴트방식 -->
									<a href="#none" title="그리드 형식으로 보기" onclick="showList()">
										<img src="/resources/images/icons/grid4.png" alt="그리드 형식 보기 아이콘">
										<span>그리드 보기</span>
									</a>
								</p>
								<p class="listStyleBtn">
									<a href="#none" title="리스트 형식으로 보기">
										<img src="/resources/images/icons/list4.png" alt="리스트 형식 보기 아이콘">
										<span>리스트 보기</span>
									</a>
								</p>
								<p class="showInfoBtn">
									<a href="#none" title="파일 또는 폴더 정보보기">
										<img src="/resources/images/icons/info4.png" alt="정보보기 아이콘">
										<span>정보보기</span>
									</a>
								</p>
							</div>
						</nav>
					</div>
				</section>
				<section id="dataAreaWrap">
					<h2>data list area</h2>
					<h3 class="hide">drag and drop업로드가 구현되어야 할 부분</h3>
					<form id="uploadForm" name="uploadForm" enctype="multipart/form-data" method="post"><!-- drag and dfrop form -->
						<div id="fileView"><!-- file drop zone -->
							<ul class="fileViewInner">
								<li class="firstSlot slot"> <!-- onClick="firstFileUp()" -->
									<p>
										<a href="#none" title="클릭해서 업로드하기">
											<img src="/resources/images/icons/add_file.png" alt="클릭해서 업로드하는 버튼"/>
										</a>
									</p>
								</li>
								<li class="slot">
									<p>
										<a href="#none" title="클릭해서 업로드하기">
											1
										</a>
									</p>
								</li>
								<!-- <li class="slot">
									<p>
										<a href="#none" title="클릭해서 업로드하기">
											1
										</a>
									</p>
								</li>
								<li class="slot">
									<p>
										<a href="#none" title="클릭해서 업로드하기">
											1
										</a>
									</p>
								</li>
								<li class="slot">
									<p>
										<a href="#none" title="클릭해서 업로드하기">
											1
										</a>
									</p>
								</li>
								<li class="slot">
									<p>
										<a href="#none" title="클릭해서 업로드하기">
											1
										</a>
									</p>
								</li>
								<li class="slot">
									<p>
										<a href="#none" title="클릭해서 업로드하기">
											1
										</a>
									</p>
								</li>
								<li class="slot">
									<p>
										<a href="#none" title="클릭해서 업로드하기">
											1
										</a>
									</p>
								</li>
								<li class="slot">
									<p>
										<a href="#none" title="클릭해서 업로드하기">
											1
										</a>
									</p>
								</li>
								<li class="slot">
									<p>
										<a href="#none" title="클릭해서 업로드하기">
											1
										</a>
									</p>
								</li> -->
							</ul>
						</div>
					</form>
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
		<jsp:include page="../include/footer.jsp"/>
		<!-- footer ends -->
	</div>
</body>
</html>