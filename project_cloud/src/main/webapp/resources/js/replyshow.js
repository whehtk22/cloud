/**
 * 게시판의 댓글에 대한 함수들
 */
function showReplyPage(replyCnt){
	
	var endNum = Math.ceil(pageNum/10.0)*10
	var startNum = endNum-9
	
	var prev = startNum !=1// 시작하는 번호가 1이 아니면 true
	var next = false
	
	if(endNum*10>=replyCnt){// 페이지의 끝번호가 전체 댓글수보다 크다면
		endNum=Math.ceil(replyCnt / 10.0);// 댓글중 마지막 의 페이지번호로..
	}
	
	if(endNum*10<replyCnt){// 마지막 페이지 번호가 전체 댓글수보다 작다면
		next=true// 다음 페이지로 넘어갈수있음
	}
	
	var str = "<ul class='pagination pull-right'>"
	
	if(prev){
		str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>"
		
	}
	console.log("startNum : "+startNum)
	console.log("endNum: "+endNum)
	for(var i=startNum;i<=endNum;i++){
		var active=pageNum==i?"active":""// 페이지번호가 현재와 같으면 비활성화
				
		str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>"
	}
	
	if(next){
		str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>"
	}
	
	str+="</ul></div>"
	console.log(str)
	// console.log(replypageFooter)
	$(".panel-footer").html(str)
	// replyPageFooter.html(str)
}

function showList(page){
	var replyUL=$("#showRpl")
		replyService.getList({bno:bnoValue,page:page||1},function(replyCnt,list){
			console.log("쇼")
			console.log(list)
			console.log("페이지번호"+page)
			if(page==-1){// 페이지 번호가 -1로 전달되면 마지막 페이지를 호출한다.
				pageNum = Math.ceil(replyCnt / 10.0); // 만약 replyCnt가 14라고 하면
														// 올림해서 2가 된다.
				showList(pageNum);
				return;
			}
			
			var str = ""
		if(list==null||list.length==0){// 아무것도 리스트가 없으면 ""로 처리
			return
		}
		for(var i=0,len=list.length||0;i<len;i++){// 댓글 리스트를 하나씩 생성해주는 자바구문.
			/*
			 * str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>"
			 * str +=" <div><div class='header'><strong
			 * class='primary-font'>"+list[i].replyer+"</strong>" str +="<small
			 * class='pull-right
			 * text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>"
			 * str +="<p>"+list[i].reply+"</p></div></li>"
			 */
			str+="<dl class='rplUnit' data-rno='"+list[i].rno+"'><dt><img src='/resources/images/profile/man.png' alt='댓글 썸네일'></dt>"
			str+="<dd><div><p class='rplInfo'><span>"+list[i].replyer+"</span><span>"+replyService.displayTime(list[i].replyDate)+"</span></p>"
			str+="<p class='rplTxt'>"+list[i].reply+"</p>"
			str+="<p class='rplBtn'><button>답글</button></p></div></dd></dl>"
		}
		
		replyUL.html(str)// 반복문에서 생성한 str을 삽입해서 html로 나타내는 것.
		showReplyPage(replyCnt)
	})
	}