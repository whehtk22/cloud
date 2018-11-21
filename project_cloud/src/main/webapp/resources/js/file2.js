
$(function (){
    // 파일 드롭 다운
    fileDropDown();
   // uploadBtn();
    showfiles();
});
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$")//.뒤에 exe|sh|zip|alz의 형식을 검사하는 정규식
var maxSize = 6024288000// 파일의 최대 크기 5MB

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
function uploadBtn(){
	$("#uploadBtn").on("click", function(e) {
		var formData = new FormData()

		var inputFile = $("input[id=uploadfile]")
		var files = inputFile[0].files

		//console.log(files)

		for (var i = 0; i < files.length; i++) {

			if (!checkExtension(files[i].name, files[i].size)) {//파일 사이즈나 파일의 확장자 제한에서 걸리면
				return false
			}
			formData.append("uploadFile", files[i])//그렇지 않다면 폼데이터에 추가하라.
			console.log(formData.get("uploadFile"))
		}

		$.ajax({
			url : '/file/upload',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			dataType : 'json',//결과를 json타입으로 받겠다.
			success : function(result) {//result는 다시 받는 결과값을 의미.
				console.log(result)
				showUploadedFile(result)
				//$(".uploadDiv").html(cloneObj.html())//업로드하고 버튼을 클릭하면 다시 초기화가 된다.
			}
		})
	})
}
function showfiles(){//즉시 실행함수
	//var user = '<c:out value="${board.bno}"/>'
		var fileViewInner = $(".fileViewInner")
		var cloneObj = $(".fileViewInner").clone()
		$.getJSON("/file/getFileList",{user:'user1'},function(arr){
			console.log(arr)
			
			var str = ""
			$(arr).each(function(i,obj){
			
				//image type
				if(obj.image){
					var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName)
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
				}else{
					var ext = obj.fileName.substring(obj.fileName.lastIndexOf(".")+1)
					var fileCallPath = encodeURIComponent(obj.uploadPath
							+ "/"
							+ obj.uuid
							+ "_"
							+ obj.fileName)
							
							str += "<li title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'>" +
						"<div class='check'>" +
						"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
								"<label class='blind' for='chk_search_"+obj.uuid+"'>" +
										""+obj.fileName+"</label><img src='/resources/images/attach.jpg' height='200px' width='160px'>"
						+ obj.fileName
						+ "<span data-file=\'"+fileCallPath+"\' data-type='file' class='blind'>x</span>"
						+ "</div></li>"
				}
			})
			$(".fileViewInner").html(str)
		})
}
function showUploadedFile(uploadResultArr) {
	var fileViewInner = $(".fileViewInner")
	var str = ""
	//이미지파일과 일반 파일을 동시에 올리는 경우 싱크로가 안 맞는 경우가 있어서 하나의 파일마다
	//바로바로 보이게 한다.
	$(uploadResultArr)
			.each(
					function(i, obj) {
						if (!obj.image) {
							console.log(obj.fileName.substring(obj.fileName.lastIndexOf(".")))
							var fileCallPath = encodeURIComponent(obj.uploadPath
									+ "/"
									+ obj.uuid
									+ "_"
									+ obj.fileName)
							str += "<li><a href='/download?fileName="
									+ fileCallPath
									+ "'><img src='/resources/images/attach.jpg' height='200px' width='160px'>"
									+ obj.fileName
									+ "</a>"
									+ "<span data-file=\'"+fileCallPath+"\' data-type='file'>x</span>"
									+ "<div></li>"
									
									
							console.log("일반파일")
							fileViewInner.append(str)
							str = ""
						} else {
							console.log(obj.fileName.substring(obj.fileName.lastIndexOf(".")))
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
							fileViewInner.append(str)
							str = ""
							console.log("이미지파일")
						}
					})
	//uploadResult.append(str)//업로드 된 파일을 화면에 보여준다.
}
function showUploadedFilediv(uploadResultArr) {
	var fileViewInner = $(".fileViewInner")
	var str = ""
	//이미지파일과 일반 파일을 동시에 올리는 경우 싱크로가 안 맞는 경우가 있어서 하나의 파일마다
	//바로바로 보이게 한다.
	$(uploadResultArr)
			.each(
					function(i, obj) {
						if (!obj.image) {
							var ext = obj.fileName.substring(obj.fileName.lastIndexOf("."))//파일확장자
							var fileCallPath = encodeURIComponent(obj.uploadPath
									+ "/"
									+ obj.uuid
									+ "_"
									+ obj.fileName)
									
							str += "<li title='"+obj.fileName+"' _extension='"+ext+"' _resourceno='"+obj.uuid+"'>" +
									"<div class='check'>" +
									"<input type='checkbox' class='input_check' id='chk_search_"+obj.uuid+"'>" +
											"<label class='blind' for='chk_search_"+obj.uuid+"'>" +
													""+obj.fileName+"</label><img src='/resources/images/attach.jpg' height='200px' width='160px'>"
									+ obj.fileName
									+ "<span data-file=\'"+fileCallPath+"\' data-type='file' class='blind'>x</span>"
									+ "</div></li>"
							console.log("일반파일")
							fileViewInner.append(str)
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
							fileViewInner.append(str)
							str = ""
							console.log("이미지파일")
						}
					})
	//uploadResult.append(str)//업로드 된 파일을 화면에 보여준다.
}
function fileDropDown() {
	
	
	console.log("한번")
    //Drag기능
	var dropZone = $("#fileView");
    dropZone.on('dragenter',function(e){
        e.stopPropagation();
        e.preventDefault();
        console.log("드래그엔터")
        // 드롭다운 영역 css_ 우선권이 fileroom.css에 있음
        //dropZone.css('background-color','#E3F2FC');
    });
    dropZone.on('dragleave',function(e){
    	e.stopPropagation();
        e.preventDefault();
        console.log("드래그리브")
        // 드롭다운 영역 css
        //dropZone.css('background-color','#FFFFFF');
    });
    dropZone.on('dragover',function(e){
        e.stopPropagation();
        e.preventDefault();
        console.log("드래그오버")
        // 드롭다운 영역 css
        //dropZone.css('background-color','#E3F2FC');
    });
    dropZone.on('drop',function(e){
        e.preventDefault();
        console.log("드래그온")
        
	var formData = new FormData()
        // 드롭다운 영역 css
        //dropZone.css('background-color','#FFFFFF');
        var files = e.originalEvent.dataTransfer.files;
        console.log(files)
        //드롭다운....
        for (var i = 0; i < files.length; i++) {

			if (!checkExtension(files[i].name, files[i].size)) {//파일 사이즈나 파일의 확장자 제한에서 걸리면
				return false
			}
			formData.append("uploadFile", files[i])//그렇지 않다면 폼데이터에 추가하라.
		}
        console.log(formData.getAll('uploadFile'))
		$.ajax({
			url : '/file/upload',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			dataType : 'json',//결과를 json타입으로 받겠다.
			success : function(result) {//result는 다시 받는 결과값을 의미.
				console.log(result)
				formData.delete('uploadFile')
				showUploadedFilediv(result)
				//$(".uploadDiv").html(cloneObj.html())//업로드하고 버튼을 클릭하면 다시 초기화가 된다.
			}
		})
    });

}