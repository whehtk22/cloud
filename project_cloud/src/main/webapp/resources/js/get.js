var bnoValue='<c:out value="${board.bno}"/>'
var pageNum =1
var replyPageFooter = $(".panel-footer")

function showReplyPage(replyCnt){
	
	var endNum = Math.ceil(pageNum/10.0)*10
	var startNum = endNum-9
	
	var prev = startNum !=1//시작하는 번호가 1이 아니면 true
	var next = false
	
	if(endNum*10>=replyCnt){//페이지의 끝번호가 전체 댓글수보다 크다면
		endNum=Math.ceil(replyCnt / 10.0);//댓글중 마지막 의 페이지번호로..
	}
	
	if(endNum*10<replyCnt){//마지막 페이지 번호가 전체 댓글수보다 작다면 
		next=true//다음 페이지로 넘어갈수있음
	}
	
	var str = "<ul class='pagination pull-right'>"
	
	if(prev){
		str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>"
		
	}
	console.log("startNum : "+startNum)
	console.log("endNum: "+endNum)
	for(var i=startNum;i<=endNum;i++){
		var active=pageNum==i?"active":""//페이지번호가 현재와 같으면 비활성화
				
		str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>"
	}
	
	if(next){
		str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>"
	}
	
	str+="</ul></div>"
	console.log(str)
	//console.log(replypageFooter)
	$(".panel-footer").html(str)
	//replyPageFooter.html(str)
}
		replyService.get(10,function(data){
			console.log(data)
		})
		
function showImage(fileCallPath){
			$(".bigPictureWrapper").css("display","flex").show()
			
			$(".bigPicture")
			.html("<img src='/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%',height:'100%'},1000)
		}
$(document).ready(function(){
	
	(function(){//즉시 실행함수
		var bno = '<c:out value="${board.bno}"/>'
			
			$.getJSON("/board/getAttachList",{bno:bno},function(arr){
				console.log(arr)
				
				var str = ""
				$(arr).each(function(i,attach){
					//image type
					if(attach.image){
						var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName)
						str+="<li data-path='"+attach.uploadPath+"' data-uuid='"
						+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.image+"'><div>"
						str+="<img src='/display?fileName="+fileCallPath+"'>"
						str+="</div></li>"
					}else{
						str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
						+attach.fileName+"' data-fileType='"+attach.image+"'><div>"
						str+="<span> "+attach.fileName+"</span><br>"
						str+="<img src='/resources/images/attach.jpg'>"
						str+="</div></li>"
					}
				})
				$(".uploadResult ul").html(str)
			})
	})()
		
	var operForm = $("#operForm")
	
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/board/modify").submit()
	})
	
	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#bno").remove()//목록으로 이동하는 것이므로 필요 없는 bno를 지워준다.
		operForm.attr("action","/board/list")
		operForm.submit()
	})
	
	$("button[data-oper='remove']").on("click",function(e){
		operForm.attr("action","/board/remove")
		operForm.attr("method","post")
		operForm.submit()
	})
	
	$(".uploadResult").on("click","li",function(e){
		console.log("view image")
		var liObj = $(this)
		
		var path= encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"))
		
		if(liObj.data("type")){//이미지파일인 경우
			showImage(path.replace(new RegExp(/\\/g),"/"))// \\를 모두 /로 바꾼다.
			//함수로 전달하는 과정에서 문제가 생기므로 변환한다.
		}else{
			self.location="/download?fileName="+path//일반파일인 경우
		}
	})
	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%',height:'0%'},1000)
		setTimeout(function(){
			$(".bigPictureWrapper").hide()
		},1000)
	})
})
$(document).ready(function(){
	var replyUL = $(".chat")
	
	showList(1)
	
	function showList(page){
		replyService.getList({bno:bnoValue,page:page||1},function(replyCnt,list){

			console.log(list)
			
			if(page==-1){//페이지 번호가 -1로 전달되면 마지막 페이지를 호출한다.
				pageNum = Math.ceil(replyCnt / 10.0); //만약 replyCnt가 14라고 하면 올림해서 2가 된다.
				showList(pageNum);
				return;
			}
			
			var str = ""
		if(list==null||list.length==0){//아무것도 리스트가 없으면 ""로 처리
			return
		}
		for(var i=0,len=list.length||0;i<len;i++){//댓글 리스트를 하나씩 생성해주는 자바구문.
			str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>"
			str +=" <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>"
			str +="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>"
			str +="<p>"+list[i].reply+"</p></div></li>"
		}
		
		replyUL.html(str)//반복문에서 생성한 str을 삽입해서 html로 나타내는 것.
		showReplyPage(replyCnt)
	})
	}
	var modal=$(".modal")//모달창에서 입력창에 대한 변수들
	var modalInputReply = modal.find("input[name='reply']")
	var modalInputReplyer = modal.find("input[name='replyer']")
	var modalInputReplyDate = modal.find("input[name='replyDate']")
	//모달창에서 버튼들에 대한 변수들
	var modalModBtn = $("#modalModBtn")
	var modalRemoveBtn = $("#modalRemoveBtn")
	var modalRegisterBtn = $("#modalRegisterBtn")
	var modalCloseBtn = $("#modalCloseBtn")
	//새로운 댓글 등록버튼을 눌렀을 경우의 이벤트
	$("#addReplyBtn").on("click",function(e){
		modal.find("input").val("")
		modalInputReplyDate.closest("div").hide()
		modal.find("button[id!='modalCloseBtn']").hide()
		
		modalRegisterBtn.show()
		
		$(".modal").modal("show")
	})
	modalRegisterBtn.on("click",function(e){
		var reply={
				reply:modalInputReply.val(),
				replyer:modalInputReplyer.val(),
				bno:bnoValue
		}
		replyService.add(reply,function(result){
			alert(result)
		})
		modal.find("input").val("")
		modal.modal("hide")
		
		//showList(1)
		showList(-1)
	})
	$(".chat").on("click","li",function(e){//ul태그의 클래스 chat의 항목(li)을 클릭하였을 경우 동작하는 함수 
		var rno = $(this).data("rno")
		replyService.get(rno,function(reply){
			modalInputReply.val(reply.reply)
			modalInputReplyer.val(reply.replyer)
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly")
			modal.data("rno",reply.rno)
			
			modal.find("button[id !='modalCloseBtn']").hide()
			modalModBtn.show()
			modalRemoveBtn.show()
			
			$(".modal").modal("show")
		})
		console.log(rno)
	})
	modalModBtn.on("click",function(e){//수정하는 버튼을 클릭하였을 경우
		var reply={rno:modal.data("rno"),reply:modalInputReply.val()}
		replyService.update(reply,function(result){
			alert(result)
			modal.modal("hide")
			console.log("pageNum"+pageNum)
			showList(pageNum)
		})
	})
	modalRemoveBtn.on("click",function(e){//삭제하는 버튼을 클릭하였을 경우
		var rno =modal.data("rno")
		
		replyService.remove(rno,function(result){
			alert(result)
			modal.modal("hide")
			showList(pageNum)
		})
	})
	modalCloseBtn.on("click",function(e){
		modal.modal("hide")
		showList(pageNum)
	})
	$(".panel-footer").on("click","li a",function(e){
		e.preventDefault()
		console.log("page click")
		
		var targetPageNum = $(this).attr("href")
		console.log("targetPageNum: "+targetPageNum)
		
		pageNum = targetPageNum
		console.log("pageNum: "+pageNum)
		showList(pageNum)
	})
})