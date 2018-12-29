/**
 * 
 */

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
$(function(){
	$("#addReplyBtn").on("click",function(e){
		modal.find("input").val("")
		modal.find("input[name='replyer']").val(replyer)
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
	
	modalModBtn.on("click",function(e){//수정하는 버튼을 클릭하였을 경우
		var originalReplyer = modalInputReplyer.val();
		
		var reply={rno:modal.data("rno"),
				reply:modalInputReply.val(),
				replyer:originalReplyer};
		
		if(!replyer){
			alert("로그인후 수정이 가능합니다.")
			modal.modal("hide");
			return;
		}
		
		if(replyer !=originalReplyer){
			alert("자신이 작성한 댓글만 수정 가능합니다.")
			modal.modal("hide")
			return;
		}
		replyService.update(reply,function(result){
			alert(result)
			modal.modal("hide")
			console.log("pageNum"+pageNum)
			showList(pageNum)
		})
	})
	modalRemoveBtn.on("click",function(e){//삭제하는 버튼을 클릭하였을 경우
		var rno =modal.data("rno")
		if(!replyer){
			alert("로그인후 삭제가 가능합니다!")
			modal.modal("hide")
			return;
		}
		
		var originalReplyer = modalInputReplyer.val();
		
		console.log("원래 댓글 작성자 : "+originalReplyer)
		
		if(replyer!=originalReplyer){
			alert("자신이 작성한 댓글만 삭제 가능합니다.")
			modal.modal("hide")
			return;
		}
		replyService.remove(rno,originalReplyer,function(result){
			alert(result)
			modal.modal("hide")
			showList(pageNum)
		})
	})
	modalCloseBtn.on("click",function(e){
		modal.modal("hide")
		showList(pageNum)
	})
});