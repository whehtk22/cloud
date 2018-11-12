<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
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
<script>
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
						str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
						+attach.fileName+"' data-fileType='"+attach.image+"'><div>"
						str+="<span>"+attach.fileName+"</span>"
						str+="<button type='button' data-file=\'"+fileCallPath+"\'data-type='image'"
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
</head>
<body>
	<h3>게시글 내용 보기</h3>
	<hr>
	<form role="form" action="/board/modify" method="post">
		<table border="1" width="500">
			<tr>
				<td width="20%">글 번호</td>
				<td width="30%"><input name='bno' value='${board.bno}'
					readonly="readonly"></td>
				<td width="20%">조회수</td>
				<td width="30%">${content.bHit}</td>
			</tr>
			<tr>
				<td width="20%">작성자</td>
				<td width="30%"><input name='writer' value="${board.writer}"
					readonly="readonly"></td>
				<td width="20%">작성일</td>
				<td width="30%"><input name='regdate'
					value='<fmt:formatDate value="${board.regdate}" pattern="yyyy/MM/dd"/>'
					readonly="readonly"></td>
			</tr>
			<tr>
				<td width="40%">글 제목</td>
				<td width="60%" colspan="3"><input name='title'
					value="${board.title}"></td>
			</tr>
			<tr>
				<td width="40%">글 내용</td>
				<td width="60%" height="100px" colspan="3"><input
					name='content' value="${board.content}"></td>
			</tr>
			<tr>
				<td colspan="4">
					<!-- 파일을 업로드하는 칸 -->
					<div class="row">
						<div class="panel-body">
							<div class="form-group uploadDiv">
								<input type="file" name='uploadFile' multiple="multiple">
							</div>
						</div>
						<div class="uploadResult">
							<!-- 파일을 보여주는 칸 -->
							<ul></ul>
						</div>
					</div>
				</td>
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
		<div>
			<input type="hidden" class="form-control" name='updateDate'
				value='<fmt:formatDate value="${board.updateDate}" pattern="yyyy/MM/dd/"/>'>
			<input type="hidden" name='pageNum' value='${page.pageNum}'>
			<input type="hidden" name='amount' value='${page.amount}'> <input
				type='hidden' name='keyword' value='${page.keyword}'> <input
				type='hidden' name='type' value='${page.type}'>
		</div>
	</form>
</body>
</html>