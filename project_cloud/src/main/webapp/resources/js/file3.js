 var cloneObj
 var category
 var list
 var superarray
 function checklength(){
	 var li_count = $(".fileViewInner > li").size()
		if(li_count>18){
			$("#dataAreaWrap").css("overflow-y","scroll")
		}
 }
 function openFileOption()
 {
   document.getElementById("uploadfile").click();//숨겨져 있는 파일 인풋태그
   console.log(document.getElementById("uploadfile"))
   checklength()
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
						if(category==="all"){
							 viewAll()
						 }else if(category==="video"){
							 viewVideo()
						 }else if(category==="docu"){
							 viewDocu()
						 }else if(category==="image"){
							 viewImage()
						 }
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
									checklength()
								}
							})
				}
			 })
	 }
 }
 
 
 function viewVideo(username){
	 category="video"
	 list=false
	 console.log("카테고리"+category)
	 var fileViewInner = $(".fileViewInner")
	 $(".fileViewInner_li").empty()
	 $(".fileViewlist").empty()
	 $("#fileView").css("display","block")
	 fileViewInner.empty()
		$.getJSON("/file/getVideoList",{user:username},function(arr){
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
			checklength()
 })
 }
 function viewDocu(username){
	 category="docu"
	 list=false
	 console.log("카테고리"+category)
	 var fileViewInner = $(".fileViewInner")
	 $(".fileViewInner_li").empty()
	 $(".fileViewlist").empty()
	 $("#fileView").css("display","block")
	 fileViewInner.empty()
		$.getJSON("/file/getDocuList",{user:username},function(arr){
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
								"<label class='hide' for='chk_search_"+obj.uuid+"'></label><img src='/resources/images/icons/document.png' height='140px' width='140px'>"
										+"<p>"+ obj.fileName+"</p>"
						+ "<span data-file=\'"+fileCallPath+"\' data-type='file' class='blind'></span>"
						+ "</div></li>"
			})
			//label에 준 클래스를 blind에서 hide로 변경(label)화면에서 숨기기
			fileViewInner.append(str)
			checklength()
 })
 }
 function viewImage(username){
	 category="image"
	 list=false
	 console.log("카테고리"+category)
	 var fileViewInner = $(".fileViewInner")
	 $(".fileViewInner_li").empty()
	 $(".fileViewlist").empty()
	 $("#fileView").css("display","block")
	 fileViewInner.empty()
		$.getJSON("/file/getImageList",{user:username},function(arr){
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
			checklength()
		})
 }
 function viewAll(username){
	 console.log("username"+username)
	 list=false
	 console.log("카테고리 "+category)
	 var fileViewInner = $(".fileViewInner")
	 fileViewInner.empty() 
	 $(".fileViewInner_li").empty()
	 $(".fileViewlist").empty()
	 $("#fileView").css("display","block")
	 viewDocu(username)
	 viewImage(username)
	 viewVideo(username)
	 category="all"
							checklength()
 }
 function view_li(username){
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
			 $.getJSON("/file/getImageList",{user:username},function(arr){
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
							fileViewlist.append(str);
			 })
			 $.getJSON("/file/getDocuList",{user:username},function(arr){
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
				 $.getJSON("/file/getVideoList",{user:username},function(arr){
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
						console.log($(".fileViewInner > li").size())
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
		 $.getJSON("/file/getVideoList",{user:username},function(arr){
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
		 $.getJSON("/file/getDocuList",{user:username},function(arr){
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
		 $.getJSON("/file/getImageList",{user:username},function(arr){
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
 function showGrid(username){
	 if(category==="all"){
		 viewAll(username)
	 }else if(category==="video"){
		 viewVideo(username)
	 }else if(category==="docu"){
		 viewDocu(username)
	 }else if(category==="image"){
		 viewImage(username)
	 }
 }