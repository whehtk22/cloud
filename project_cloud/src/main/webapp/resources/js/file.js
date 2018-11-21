/**
 * subHeader영역에서 데이터리스트 보기 형식을 바꾸는 버튼을 누르면
 * grid형태로 파일/디렉터리 목록 보기
 * 또는 table 형식의 목록 보기 처리하는 부분
 */

function showList(){
	alert("그리드 형태로 파일리스트를 봅시다!!");
	xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
			document.getElementById("fileView").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("GET","../ajaxdata/file_list_grid.jsp", true);
	xmlhttp.send();
}


/**
 * drag and drop upload 처리 부분
 */
//파일 리스트 번호
var fileIndex = 0;
// 등록할 전체 파일 사이즈
var totalFileSize = 0;
// 파일 리스트
var fileList = new Array();
// 파일 사이즈 리스트
var fileSizeList = new Array();
// 등록 가능한 파일 사이즈 MB
var uploadSize = 50;
// 등록 가능한 총 파일 사이즈 MB
var maxUploadSize = 500;

$(function (){
    // 파일 드롭 다운
    fileDropDown();
});

//파일 드롭 다운
function fileDropDown(){
	var dropZone = $("#fileView");
    //Drag기능
    dropZone.on('dragenter',function(e){
        e.stopPropagation();
        e.preventDefault();
        // 드롭다운 영역 css_ 우선권이 fileroom.css에 있음
        //dropZone.css('background-color','#E3F2FC');
    });
    dropZone.on('dragleave',function(e){
    	e.stopPropagation();
        e.preventDefault();
        // 드롭다운 영역 css
        //dropZone.css('background-color','#FFFFFF');
    });
    dropZone.on('dragover',function(e){
        e.stopPropagation();
        e.preventDefault();
        // 드롭다운 영역 css
        //dropZone.css('background-color','#E3F2FC');
    });
    dropZone.on('drop',function(e){
        e.preventDefault();
        // 드롭다운 영역 css
        //dropZone.css('background-color','#FFFFFF');

        var files = e.originalEvent.dataTransfer.files;
        if(files != null){
            if(files.length < 1){
                alert("폴더 업로드 불가");
                return;
            }
            selectFile(files);
        }else{
            alert("ERROR");
        }
    });
}

// 파일 선택시
function selectFile(fileObject){
	var files = null;
	
	if(fileObject != null){
		//외부창에서 파일을 drag해서 등록하는 경우
		files=fileObject;
	}else{
		//파일을 직접 등록하는 경우
		files=$('#multipaartFileList_' + fileIndex)[0].files;
		//files=$('#multipartFileList_' + fileIndex)[0].files;
	}

	// 다중파일 등록
	if(files != null){
		for(var i=0;i<files.length;i++){//다중파일을 반복문들 돌려서해준다.
			//파일명
			var fileName = files[i].name;
			var fileNameArr = fileName.split("\.");
			//파일 확장자
			var ext = fileNameArr[fileNameArr.length - 1];
			// 파일 사이즈(단위 :MB)
            var fileSize = files[i].size / 1024 / 1024;
            
            if($.inArray(ext, ['exe', 'bat', 'sh', 'java','zip','alz', 'jsp', 'html', 'js', 'css', 'xml']) >= 0){
                // 확장자 체크
                alert("등록 불가 확장자");
                break;
            }else if(fileSize > uploadSize){
                // 파일 사이즈 체크
                alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
                break;
            }else{
                // 전체 파일 사이즈
                totalFileSize += fileSize;

                // 파일 배열에 넣기
                fileList[fileIndex] = files[i];

                // 파일 사이즈 배열에 넣기
                fileSizeList[fileIndex] = fileSize;

                // 업로드 파일 목록 생성
                addFileList(fileIndex, fileName, fileSize);

                // 파일 번호 증가
                fileIndex++;
            }
		}
	}else{
		alert("error!");
	}
}

//업로드 파일 목록 생성
//function addFileList(fIndex, fileName, fileSize){
//    var html = "";
//    html += "<tr id='fileTr_" + fIndex + "'>";
//    html += "    <td class='left' >";
//    html +=         fileName + " / " + fileSize + "MB "  + "<a href='#' onclick='deleteFile(" + fIndex + "); return false;' class='btn small bg_02'>삭제</a>"
//    html += "    </td>"
//    html += "</tr>"
//
//    $('#fileTableTbody').append(html);
//}
//업로드 파일 목록 생성
function addFileList(fIndex, fileName, fileSize){
  var html = "";
  html += "<li class='slot_" + fIndex + "'>";
  html += "    <a class='left' >";
  html +=         "<a href='#' onclick='deleteFile(" + fIndex + "); return false;' class='btn small bg_02'>삭제</a>"
  					"<img src='' alt=''>"+"<input type='checkbox'>"
  					
  html += "    </a>"
  html += "</li>"

  $('.fileViewInner').append(html);
  $('.left').text("           ");
}
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

// 업로드 파일 삭제
function deleteFile(fIndex){
    // 전체 파일 사이즈 수정
    totalFileSize -= fileSizeList[fIndex];

    // 파일 배열에서 삭제
    delete fileList[fIndex];

    // 파일 사이즈 배열 삭제
    delete fileSizeList[fIndex];

    // 업로드 파일 테이블 목록에서 삭제
    $("#fileTr_" + fIndex).remove();
}

// 파일 등록
function uploadFile(){
    // 등록할 파일 리스트
    var uploadFileList = Object.keys(fileList);

    // 파일이 있는지 체크
    if(uploadFileList.length == 0){
        // 파일등록 경고창
        alert("파일이 없습니다.");
        return;
    }

    // 용량을 500MB를 넘을 경우 업로드 불가
    if(totalFileSize > maxUploadSize){
        // 파일 사이즈 초과 경고창
        alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " MB");
        return;
    }

    if(confirm("등록 하시겠습니까?")){
        // 등록할 파일 리스트를 formData로 데이터 입력
        var form = $('#uploadForm');
        var formData = new FormData(form);
        for(var i = 0; i < uploadFileList.length; i++){
            formData.append('files', fileList[uploadFileList[i]]);
        }

        $.ajax({
            url:"업로드 경로",
            data:formData,
            type:'POST',
            enctype:'multipart/form-data',
            processData:false,
            contentType:false,
            dataType:'json',
            cache:false,
            success:function(result){
                if(result.data.length > 0){
                    alert("성공");
                    location.reload();
                }else{
                    alert("실패");
                    location.reload();
                }
            }
        });
    }
}