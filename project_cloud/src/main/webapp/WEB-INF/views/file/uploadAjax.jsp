<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style><!--임의적으로 만든 것이라 수정가능.-->
.uploadResult{
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
}

</style>
<title>Insert title here</title>
</head>
<body>
<h1>Upload with Ajax</h1>

<div class="uploadDiv">
<input type='file' name='uploadFile' multiple>
</div>
<button id='uploadBtn'>Upload</button>
<div class='uploadResult'>
<ul></ul>
</div>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
  <script>
  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$")//.뒤에 exe|sh|zip|alz의 형식을 검사하는 정규식
  var maxSize= 10242880// 파일의 최대 크기 5MB
  
  function checkExtension(fileName, fileSize){
	  if(fileSize>=maxSize){
		  alert("파일 사이즈 초과")
		  return false
	  }
	  
	  if(regex.test(fileName)){
		  alert("해당 종류의 파일은 업로드 할 수 없습니다.")
		  return false
	  }
	  return true
  }
  var uploadResult = $(".uploadResult ul")
  
  function showUploadedFile(uploadResultArr){
	  var str = ""
	  
	  $(uploadResultArr).each(function(i,obj){
		  if(!obj.image){
			  str ="<li><img src='/resources/images/attach.jpg'>"+obj.fileName+"</li>"+str
		  }else{
		  //str += "<li>"+obj.fileName+"</li>"//공백문자나 한글 이름 등이 문제가 되기 때문에 인코딩을 해주어야 한다.
		  var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName)
		  
		  str="<li><img src='/display?fileName="+fileCallPath+"'><li>"+str
		  }
	  })
	  uploadResult.append(str)//업로드 된 파일을 화면에 보여준다.
  }

  $(document).ready(function(){
	  var cloneObj = $(".uploadDiv").clone()
	  $("#uploadBtn").on("click",function(e){
			var formData = new FormData()
		  
		  var inputFile = $("input[name=uploadFile]")
		  
		  var files = inputFile[0].files
		  
		  console.log(files)
		  
		  for(var i=0;i<files.length;i++){
			  
			  if(!checkExtension(files[i].name,files[i].size)){//파일 사이즈나 파일의 확장자 제한에서 걸리면
				  return false
			  }
			  formData.append("uploadFile",files[i])//그렇지 않다면 폼데이터에 추가하라.
		  }
			
			$.ajax({
				url:'/uploadAjaxAction',
				processData:false,
				contentType:false,
				data:formData,
				type:'POST',
				dataType:'json',//결과를 json타입으로 받겠다.
				success:function(result){//result는 다시 받는 결과값을 의미.
					console.log(result)
					showUploadedFile(result)
					$(".uploadDiv")	.html(cloneObj.html())//업로드하고 버튼을 클릭하면 다시 초기화가 된다.
				}
			})
	  })
		 
	  })
  
  </script>

</body>

</html>