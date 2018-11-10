<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!--임의적으로 만든 것이라 수정가능.-->
<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
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
</head>
<body>

	<h1>Upload with Ajax</h1>

	<div class="uploadDiv">
		<input type='file' name='uploadFile' multiple>
	</div>
	<button id='uploadBtn'>Upload</button>

	<div class='uploadResult' style="">
		<ul></ul>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>

	<script>
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$")//.뒤에 exe|sh|zip|alz의 형식을 검사하는 정규식
		var maxSize = 50242880// 파일의 최대 크기 5MB

		function showImage(fileCallPath) {
			//alert(fileCallPath)
			$(".bigPictureWrapper").css("display", "flex").show()

			$(".bigPicture").html(
					"<img src='/display?fileName=" + encodeURI(fileCallPath)
							+ "'>").animate({
				width : '100%',
				height : '100%'
			}, 1000)
			//이미지가 클릭되면 이미지가 크게 나타난다.
		}
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
		var uploadResult = $(".uploadResult ul")

		function showUploadedFile(uploadResultArr) {
			var str = ""
			//이미지파일과 일반 파일을 동시에 올리는 경우 싱크로가 안 맞는 경우가 있어서 하나의 파일마다
			//바로바로 보이게 한다.
			$(uploadResultArr)
					.each(
							function(i, obj) {
								if (!obj.image) {
									var fileCallPath = encodeURIComponent(obj.uploadPath
											+ "/"
											+ obj.uuid
											+ "_"
											+ obj.fileName)
									str += "<li><a href='/download?fileName="
											+ fileCallPath
											+ "'><img src='/resources/images/attach.jpg'>"
											+ obj.fileName
											+ "</a>"
											+ "<span data-file=\'"+fileCallPath+"\' data-type='file'>x</span>"
											+ "<div></li>"
									console.log("일반파일")
									uploadResult.append(str)
									str = ""
								} else {
									//str += "<li>"+obj.fileName+"</li>"//공백문자나 한글 이름 등이 문제가 되기 때문에 인코딩을 해주어야 한다.
									var fileCallPath = encodeURIComponent(obj.uploadPath
											+ "/s_"
											+ obj.uuid
											+ "_"
											+ obj.fileName)

									var originPath = obj.uploadPath + "\\"
											+ obj.uuid + "_" + obj.fileName//원본파일의 이름

									originPath = originPath.replace(new RegExp(
											/\\/g), "/")//정규식을 써서 \(역슬래쉬)를 /로 바꿔준다.
									//역슬래쉬는 일반 문자열과는 처리가 다르게 되기 때문에 바꾸어준다.

									str = "<li><a href=\"javascript:showImage(\'"
											+ originPath
											+ "\')\"><img src='/display?fileName="
											+ fileCallPath
											+ "'></a>"
											+ "<span data-file=\'"+fileCallPath+"\' data-type='image'>x</span></li>"
									uploadResult.append(str)
									str = ""
									console.log("이미지파일")
								}
							})
			//uploadResult.append(str)//업로드 된 파일을 화면에 보여준다.
		}

		$(document).ready(function() {
			var cloneObj = $(".uploadDiv").clone()
			$("#uploadBtn").on("click", function(e) {
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
						showUploadedFile(result)
						$(".uploadDiv").html(cloneObj.html())//업로드하고 버튼을 클릭하면 다시 초기화가 된다.
					}
				})
			})
			$(".bigPictureWrapper").on("click", function(e) {
				$(".bigPicture").animate({
					width : '0%',
					height : '0%'
				}, 1000)
				setTimeout(function() {
					$(".bigPictureWrapper").hide()
				}, 1000)//1000은 1초를 의미하는 것으로 애니메이션이 1초 동안 동작한다.
			})
			$(".uploadResult").on("click", "span", function(e) {//선택자로 this는 span의 값이 선택된다.
				console.log($(this))
				var targetFile = $(this).data("file")//span태그의 data-file에서의 file
				var type = $(this).data("type")//span태그의 data-type에서의 type
				$(this).parent().remove()//x표시가 된 span태그의 상위의 태그를 선택해서 제거해준다.
				$.ajax({
					url : '/deleteFile',
					data : {
						fileName : targetFile,
						type : type
					},
					dataType : 'text',
					type : 'POST',
					success : function(result) {
						alert(result)
					}
				})
			})
		})
	</script>

</body>

</html>