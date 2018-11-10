var replyService=(function(){
	
	function add(reply,callback,error){//댓글 등록하기
		console.log(" add reply~~~~~~~~~")
	$.ajax({
		type : 'post',
		url : '/replies/new',
		data : JSON.stringify(reply),
		contentType : "application/json; charset=utf-8",
		success:function(result,status,xhr){
			if(callback){
				callback(result)
			}
		},error: function(xhr,status,er){
			if(error){
				error(er)
			}
		}
	})
	}
	function getList(param, callback, error){//댓글 목록 가져오기
		var bno = param.bno
		var page = param.page || 1;
		
		 $.getJSON("/replies/pages/"+bno+"/"+page+".json",
				 function(data){
			 if(callback){
				 //callback(data) 댓글 목록만 가져오는 경우
				 callback(data.replyCnt, data.list)//댓글 숫자와 목록을 가져오는 경우
			 }
		 }).fail(function(xhr,status,err){
			if(error){
				error()
			}
		})
	}
	function remove(rno,callback,error){//댓글제거하기
		$.ajax({
			type:'delete',
			url:'/replies/'+rno,
			success:function(deleteResult, status,xhr){
				if(callback){
					callback(deleteResult)
				}
			},error:function(xhr,status,er){
				if(error){
					error(er)
				}
			}
		})
	}
	function update(reply,callback,error){//댓글 수정하기
		console.log("RNO: "+reply.rno)
		
		$.ajax({
			type:'put',
			url:'/replies/'+reply.rno,
			data:JSON.stringify(reply),
			contentType:"application/json; charset=utf-8",
			success:function(result,status,xhr){
				if(callback){
					callback(result)
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er)
				}
			}
		})
	}
	function get(rno, callback,error){//댓글 조회하기
		$.get("/replies/"+rno+".json",function(result){
			if(callback){
				callback(result)
			}
		}).fail(function(xhr,status,err){
			if(error){
				error()
			}
		})
	}
	function displayTime(timeValue){
		var today = new Date()//오늘 날짜를 가져오는 것
		
		var gap = today.getTime() - timeValue//오늘의 시간에서 댓글을 작성한 날짜를 뺀 차이
		
		var dateObj = new Date(timeValue)//가져온 시간을 데이트 형식으로 변환
		var str = ""
		
		if(gap<(1000*60*60*24)){//만약 날짜 차이가 1일을 넘지 않는다면
			var hh = dateObj.getHours()
			var mi = dateObj.getMinutes()
			var ss = dateObj.getSeconds()
			
			return [ (hh>9?' ':'0')+hh,' : ',(mi>9?' ':'0')+mi,' : ',(ss>9?' ':'0')+ss].join(' ')/*시,분,초 가 각각 9를 넘으면 그냥 그 숫자 그대로 쓰고
			그렇지 않으면 앞에 0을 붙여준다.*/ 
		}else{
			var yy = dateObj.getFullYear()
			var mm = dateObj.getMonth()+1//getMonth는 0부터 시작하므로 1을 더해준다.
			var dd = dateObj.getDate()
			
			return [yy,'/',(mm>9?' ':'0')+mm,'/', (dd>9?' ':'0')+dd].join('')
		}
	}
	return {add:add,
		getList : getList,
		remove:remove,
		update:update,
		get:get,
		displayTime:displayTime}
})()