<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		p{
		font-size:12px;
		width:160px;
		word-wrap:break-word;
		}
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
 <script src="/resources/js/file2.js"></script> 
<script src="/resources/js/jquery.percentageloader-0.2.js"></script>
 <script>
 var cloneObj
 var category
 var list
 function openFileOption()
 {
   document.getElementById("uploadfile").click();
   console.log(document.getElementById("uploadfile"))
 }
 function downLoadFile(){
	 if(list===false){
	 $('.fileViewInner').find('.input_check').each(function(){
			if($(this).is(":checked")){
				console.log()
				location.href="/file/download?fileName="+$(this).next().next().next().next().attr("data-file")
			}
			console.log($(this).next().next().next().attr("data-file"))
		})
	 }else if(list===true){
		 $(".fileViewlist").find('.input_check').each(function(){
			if($(this).is(":checked")){
				location.href="/file/download?fileName="+$(this).parent().next().next().next().attr("data-file")
			}
		 })
	 }
	}
 function deleteFile(){
	 if(list===false){
	 $('.fileViewInner').find('.input_check').each(function(){
			if($(this).is(":checked")){
				//location.href="/file/deleteFile?fileName="+$(this).next().next().next().attr("data-file")
						var fileName = $(this).siblings("span").attr("data-file")
						var type = $(this).siblings("span").attr("data-type")
						$(this).parent().remove()
				$.ajax({
					url : '/file/deleteFile',
					data : {
						fileName : fileName,
						type : type,
						user:'user1'
					},
					dataType : 'text',
					type : 'POST',
					success : function(result) {
						alert(result)
						
					}
				})
			}
			console.log($(this).next().next().next().next().attr("data-file"))
		})
	 }else if(list===true){
		 $(".fileViewlist").find('.input_check').each(function(){
				if($(this).is(":checked")){
					//location.href="/file/download?fileName="+$(this).parent().next().next().next().attr("data-file")
							var fileName=$(this).parent().next().next().next().attr("data-file")
							var type=$(this).parent().next().next().next().attr("data-type")
							$(this).parent().parent().parent().remove()
							$.ajax({
								url:'/file/deleteFile',
								data:{
									fileName:fileName,
									type:type,
									user:'user1'
								},
								dataType:'text',
								type:'POST',
								success:function(result){
									alert(result)
								}
							})
				}
			 })
	 }
 }
 
 
 function viewVideo(){
	 category="video"
	 list=false
	 console.log("카테고리"+category)
	 var fileViewInner = $(".fileViewInner")
	 $(".fileViewInner_li").empty()
	 $(".fileViewlist").empty()
	 $("#fileView").css("display","block")
	 fileViewInner.empty()
		$.getJSON("/file/getVideoList",{user:'user1'},function(arr){
			console.log(arr)
			console.log("video")
			var str = ""
			$(arr).each(function(i,obj){
			
				//image type
					var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
					var fileCallPath = encodeURIComponent(obj.uploadPath
							+ "/"
							+ obj.uuid
							+ "_"
							+ obj.fileName)
							
							str += "<li title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'>" +
						"<div class='check'>" +
						"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
								"<label class='blind' for='chk_search_"+obj.uuid+"'></label><img src='/resources/images/icons/video-file.png' height='140px' width='140px'>"
						+"<p>"+ obj.fileName+"</p>"
						+ "<span data-file=\'"+fileCallPath+"\' data-type='file' class='blind'></span>"
						+ "</div></li>"
			})
			fileViewInner.append(str)
 })
 }
 function viewDocu(){
	 category="docu"
	 list=false
	 console.log("카테고리"+category)
	 var fileViewInner = $(".fileViewInner")
	 $(".fileViewInner_li").empty()
	 $(".fileViewlist").empty()
	 $("#fileView").css("display","block")
	 fileViewInner.empty()
		$.getJSON("/file/getDocuList",{user:'user1'},function(arr){
			console.log(arr)
			
			var str = ""
			$(arr).each(function(i,obj){
			
				//image type
					var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
					var fileCallPath = encodeURIComponent(obj.uploadPath
							+ "/"
							+ obj.uuid
							+ "_"
							+ obj.fileName)
							
							str += "<li title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'>" +
						"<div class='check'>" +
						"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
								"<label class='blind' for='chk_search_"+obj.uuid+"'></label><img src='/resources/images/icons/document.png' height='140px' width='140px'>"
										+"<p>"+ obj.fileName+"</p>"
						+ "<span data-file=\'"+fileCallPath+"\' data-type='file' class='blind'></span>"
						+ "</div></li>"
			})
			fileViewInner.append(str)
 })
 }
 function viewImage(){
	 category="image"
	 list=false
	 console.log("카테고리"+category)
	 var fileViewInner = $(".fileViewInner")
	 $(".fileViewInner_li").empty()
	 $(".fileViewlist").empty()
	 $("#fileView").css("display","block")
	 fileViewInner.empty()
		$.getJSON("/file/getImageList",{user:'user1'},function(arr){
			console.log(arr)
	 var str = ""
			$(arr).each(function(i,obj){
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName)
				var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
				var originPath = obj.uploadPath + "\\"
						+ obj.uuid + "_" + obj.fileName//원본파일의 이름

				originPath = originPath.replace(new RegExp(
						/\\/g), "/")//정규식을 써서 \(역슬래쉬)를 /로 바꿔준다.
				//역슬래쉬는 일반 문자열과는 처리가 다르게 되기 때문에 바꾸어준다.

				str += "<li title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'><div class='check'>" +
				"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
				"<label class='blind' for='chk_search_"+obj.uuid+"'></label><img src='/file/display?fileName="
						+ fileCallPath
						+ "' height='140px' width='140px'></a>"
						+"<p>"+ obj.fileName+"</p>"
						+ "<span data-file=\'"+fileCallPath+"\' data-type='image'></span></li>"
			})
			fileViewInner.append(str)
		})
 }
 function viewAll(){
	 category="all"
	 list=false
	 console.log("카테고리 "+category)
	 var fileViewInner = $(".fileViewInner")
	 fileViewInner.empty() 
	 $(".fileViewInner_li").empty()
	 $(".fileViewlist").empty()
	 $("#fileView").css("display","block")
	 $.getJSON("/file/getImageList",{user:'user1'},function(arr){
			console.log(arr)
			 var str = ""
					$(arr).each(function(i,obj){
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName)
						var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
						var originPath = obj.uploadPath + "\\"
								+ obj.uuid + "_" + obj.fileName//원본파일의 이름

						originPath = originPath.replace(new RegExp(
								/\\/g), "/")//정규식을 써서 \(역슬래쉬)를 /로 바꿔준다.
						//역슬래쉬는 일반 문자열과는 처리가 다르게 되기 때문에 바꾸어준다.

						str += "<li title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'><div class='check'>" +
						"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
						"<label class='blind' for='chk_search_"+obj.uuid+"'></label><img src='/file/display?fileName="
								+ fileCallPath
								+ "' height='140px' width='140px'></a>"
								+"<p>"+ obj.fileName+"</p>"
								+ "<span data-file=\'"+fileCallPath+"\' data-type='image'></span></li>"
								//fileViewInner.append(str)
					})
					fileViewInner.append(str)
	 }).success(function(){
		 $.getJSON("/file/getDocuList",{user:'user1'},function(arr){
				console.log(arr)
				
		var str = ""
				$(arr).each(function(i,obj){
				
					//image type
						var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
						var fileCallPath = encodeURIComponent(obj.uploadPath
								+ "/"
								+ obj.uuid
								+ "_"
								+ obj.fileName)
								
								str += "<li title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'>" +
							"<div class='check'>" +
							"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
									"<label class='blind' for='chk_search_"+obj.uuid+"'></label><img src='/resources/images/icons/document.png' height='140px' width='140px'>"
											+"<p>"+ obj.fileName+"</p>"
							+ "<span data-file=\'"+fileCallPath+"\' data-type='file' class='blind'></span>"
							+ "</div></li>"
							//fileViewInner.append(str)
				})
				fileViewInner.append(str)
	 }).success(function(){
		 $.getJSON("/file/getVideoList",{user:'user1'},function(arr){
				console.log(arr)
				console.log("video")
				var str = ""
				$(arr).each(function(i,obj){
				
					//image type
						var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
						var fileCallPath = encodeURIComponent(obj.uploadPath
								+ "/"
								+ obj.uuid
								+ "_"
								+ obj.fileName)
								
								str += "<li title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'>" +
							"<div class='check'>" +
							"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
									"<label class='blind' for='chk_search_"+obj.uuid+"'></label><img src='/resources/images/icons/video-file.png' height='140px' width='140px'>"
							+"<p>"+ obj.fileName+"</p>"
							+ "<span data-file=\'"+fileCallPath+"\' data-type='file' class='blind'></span>"
							+ "</div></li>"
				})
							fileViewInner.append(str)
				
		 })
	 })
	 })
 }
 function view_li(){
	 list=true
	 if(category==="all"){
			 var fileView = $("#fileView")
			 fileView.hide()
			 var fileViewInner_li = $(".fileViewInner_li")
			 fileViewInner_li.append("<div class='list_sort'><ul class='list_head'>"+
			 "<li class='check' style='width:35px;'></li>"+
			 "<li class='type' style='width:50px;'>종류</li>"+
			 "<li class='filename' style='width:auto;'><span>이름</span><div class='move_zone' style='width:462px;'></div></li>"+
			 "</div> ")
			 var fileViewlist = $(".fileViewlist")
			 $.getJSON("/file/getImageList",{user:'user1'},function(arr){
					console.log(arr)
					 var str = ""
							$(arr).each(function(i,obj){
								var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName)
								var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
								var originPath = obj.uploadPath + "\\"
										+ obj.uuid + "_" + obj.fileName//원본파일의 이름

								originPath = originPath.replace(new RegExp(
										/\\/g), "/")//정규식을 써서 \(역슬래쉬)를 /로 바꿔준다.
								//역슬래쉬는 일반 문자열과는 처리가 다르게 되기 때문에 바꾸어준다.

								str += "<li class='list_body_li' title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'><ul class='list_body'><li class='check' style='width:35px'>" +
								"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
								"<label class='blind' for='chk_search_"+obj.uuid+"'></label>"+
								"<li class='type' style='width:50px'><img src='/resources/images/icons/image.png' height='20px' width='25px'></li>"
										+"<li class='filename' style='width:auto'><p>"+ obj.fileName+"</p></li>"
										+ "<span style='display:none' data-file=\'"+fileCallPath+"\' data-type='image'></span></ul></li>"
										//fileViewInner.append(str)
							})
							fileViewlist.append(str)
			 }).success(function(){
				 $.getJSON("/file/getDocuList",{user:'user1'},function(arr){
						console.log(arr)
						
				var str = ""
						$(arr).each(function(i,obj){
						
							//image type
								var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
								var fileCallPath = encodeURIComponent(obj.uploadPath
										+ "/"
										+ obj.uuid
										+ "_"
										+ obj.fileName)
										
										str += "<li class='list_body_li' title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'><ul class='list_body'><li class='check' style='width:35px'>" +
									"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
											"<label class='blind' for='chk_search_"+obj.uuid+"'></label>"+
											"<li class='type' style='width:50px'><img src='/resources/images/icons/document.png' height='20px' width='25px'></li>"
													+"<li class='filename' style='width:auto'><p>"+ obj.fileName+"</p>"
									+ "<span style='display:none' data-file=\'"+fileCallPath+"\' data-type='file' class='blind'></span></ul></li>"
									//fileViewInner.append(str)
						})
						fileViewlist.append(str)
			 }).success(function(){
				 $.getJSON("/file/getVideoList",{user:'user1'},function(arr){
						console.log(arr)
						console.log("video")
						var str = ""
						$(arr).each(function(i,obj){
						
							//image type
								var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
								var fileCallPath = encodeURIComponent(obj.uploadPath
										+ "/"
										+ obj.uuid
										+ "_"
										+ obj.fileName)
										
										str += "<li class='list_body_li' title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'><ul class='list_body'><li class='check' style='width:35px'>" +
									"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
											"<label class='blind' for='chk_search_"+obj.uuid+"'></label>"+
											"<li class='type' style='width:50px'><img src='/resources/images/icons/video-file.png' height='20px' width='25px'></li>"
									+"<li class='filename' stye='width:auto'><p>"+ obj.fileName+"</p></li>"
									+ "<span style='display:none' data-file=\'"+fileCallPath+"\' data-type='file' class='blind'></span></ul></li>"
						})
									fileViewlist.append(str)
						
				 })
			 })
			 })
	 }else if(category==="video"){
		 var fileView = $("#fileView")
		 fileView.hide()
		 var fileViewInner_li = $(".fileViewInner_li")
		 fileViewInner_li.append("<div class='list_sort'><ul class='list_head'>"+
		 "<li class='check' style='width:35px;'></li>"+
		 "<li class='type' style='width:50px;'>종류</li>"+
		 "<li class='filename' style='width:auto;'><span>이름</span><div class='move_zone' style='width:462px;'></div></li>"+
		 "</div> ")
		 var fileViewlist = $(".fileViewlist")
		 $.getJSON("/file/getVideoList",{user:'user1'},function(arr){
						console.log(arr)
						console.log("video")
						var str = ""
						$(arr).each(function(i,obj){
						
							//image type
								var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
								var fileCallPath = encodeURIComponent(obj.uploadPath
										+ "/"
										+ obj.uuid
										+ "_"
										+ obj.fileName)
										
										str += "<li class='list_body_li' title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'><ul class='list_body'><li class='check' style='width:35px'>" +
									"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
											"<label class='blind' for='chk_search_"+obj.uuid+"'></label>"+
											"<li class='type' style='width:50px'><img src='/resources/images/icons/video-file.png' height='20px' width='25px'></li>"
									+"<li class='filename' stye='width:auto'><p>"+ obj.fileName+"</p></li>"
									+ "<span style='display:none' data-file=\'"+fileCallPath+"\' data-type='file' class='blind'></span></ul></li>"
						})
									fileViewlist.append(str)
						
				 })
	 }else if(category==="docu"){
		 var fileView = $("#fileView")
		 fileView.hide()
		 var fileViewInner_li = $(".fileViewInner_li")
		 fileViewInner_li.append("<div class='list_sort'><ul class='list_head'>"+
		 "<li class='check' style='width:35px;'></li>"+
		 "<li class='type' style='width:50px;'>종류</li>"+
		 "<li class='filename' style='width:auto;'><span>이름</span><div class='move_zone' style='width:462px;'></div></li>"+
		 "</div> ")
		 var fileViewlist = $(".fileViewlist")
		 $.getJSON("/file/getDocuList",{user:'user1'},function(arr){
				console.log(arr)
				
		var str = ""
				$(arr).each(function(i,obj){
				
					//image type
						var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
						var fileCallPath = encodeURIComponent(obj.uploadPath
								+ "/"
								+ obj.uuid
								+ "_"
								+ obj.fileName)
								
								str += "<li class='list_body_li' title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'><ul class='list_body'><li class='check' style='width:35px'>" +
							"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
									"<label class='blind' for='chk_search_"+obj.uuid+"'></label>"+
									"<li class='type' style='width:50px'><img src='/resources/images/icons/document.png' height='20px' width='25px'></li>"
											+"<li class='filename' style='width:auto'><p>"+ obj.fileName+"</p>"
							+ "<span style='display:none' data-file=\'"+fileCallPath+"\' data-type='file' class='blind'></span></ul></li>"
							//fileViewInner.append(str)
				})
				fileViewlist.append(str)
		 })
	 }else if(category==="image"){
		 var fileView = $("#fileView")
		 fileView.hide()
		 var fileViewInner_li = $(".fileViewInner_li")
		 fileViewInner_li.append("<div class='list_sort'><ul class='list_head'>"+
		 "<li class='check' style='width:35px;'></li>"+
		 "<li class='type' style='width:50px;'>종류</li>"+
		 "<li class='filename' style='width:auto;'><span>이름</span><div class='move_zone' style='width:462px;'></div></li>"+
		 "</div> ")
		 var fileViewlist = $(".fileViewlist")
		 $.getJSON("/file/getImageList",{user:'user1'},function(arr){
				console.log(arr)
				 var str = ""
						$(arr).each(function(i,obj){
							var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName)
							var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
							var originPath = obj.uploadPath + "\\"
									+ obj.uuid + "_" + obj.fileName//원본파일의 이름

							originPath = originPath.replace(new RegExp(
									/\\/g), "/")//정규식을 써서 \(역슬래쉬)를 /로 바꿔준다.
							//역슬래쉬는 일반 문자열과는 처리가 다르게 되기 때문에 바꾸어준다.

							str += "<li class='list_body_li' title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'><ul class='list_body'><li class='check' style='width:35px'>" +
							"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
							"<label class='blind' for='chk_search_"+obj.uuid+"'></label>"+
							"<li class='type' style='width:50px'><img src='/resources/images/icons/image.png' height='20px' width='25px'></li>"
									+"<li class='filename' style='width:auto'><p>"+ obj.fileName+"</p></li>"
									+ "<span style='display:none' data-file=\'"+fileCallPath+"\' data-type='image'></span></ul></li>"
									//fileViewInner.append(str)
						})
						fileViewlist.append(str)
	 })
 }
 }
 var percentComplete=0;
 $(document).on("ready",function(){
	 
	 $("#full").hide()
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
							<li><a href="javascript:void(0)" onclick="viewAll();return;"title="기본 모아보기">기본</a></li>
							<li><a href="javascript:void(0)" onclick="viewDocu();return;"title="문서 모아보기">문서</a></li>
							<li><a href="javascript:void(0)" onclick="viewVideo();return;" title="영상 모아보기">영상</a></li>
							<li><a href="javascript:void(0)" onclick="viewImage();return;" title="사진 모아보기">사진</a></li>
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
									<a href="#none" title="그리드 형식으로 보기" onclick="showList()">
										<img src="/resources/images/icons/grid5.png" alt="그리드 형식 보기 아이콘">
										<span class="hide">그리드 보기</span>
									</a>
								</p>
								<p class="listStyleBtn">
									<a href="#none" title="리스트 형식으로 보기" onclick="view_li()">
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
									<p>
										 <a href="#none" title="클릭해서 업로드하기">
											<img src="/resources/images/icons/add_file.png" alt="클릭해서 업로드하는 버튼"/>
										</a>
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
		<jsp:include page="../include/footer.jsp"/>
		<!-- footer ends -->
	</div>
</body>
</html>