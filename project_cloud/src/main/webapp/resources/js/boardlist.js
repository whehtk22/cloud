$(document).ready(function(){
  var result='<c:out value="${result}"/>'
  checkModal(result)
  history.replaceState({},null,null)
  function checkModal(result){
    if(result===' '||history.state){//뒤로가기 버튼을 입력하거나 처음으로 list를 들어갔을 경우 모달 창이 안뜨게 하는 것.
      return
    }
    if(parseInt(result)>0){
      $(".modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다.")
    }
    $("#myModal").modal("show");
  }
  $("#write_board").on("click",function(){
    self.location="/board/register"
  })

  var actionForm = $("#actionForm")
  var handler = function() { console.log("click")
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"))
		actionForm.submit()} 

$(".page_prev a").on("click",function(e){
	e.preventDefault()
	
	console.log("click")
	
	actionForm.find("input[name='pageNum']").val($(this).attr("href"))
	$(this).prop("href","#")
	actionForm.submit()
})
  $(".page_button a").on("click",function(e){
    e.preventDefault()

    console.log('click')

    actionForm.find("input[name='pageNum']").val($(this).attr("href"))
    actionForm.submit()
  })
$(".page_next a").on("click",function(e){
	e.preventDefault()
	
	console.log("next")
	
	actionForm.find("input[name='pageNum']").val($(this).attr("href"))
	actionForm.submit()
})

  $(".move").on("click",function(e){
    e.preventDefault()

    console.log('click')
    actionForm.append("<input type='hidden' name='bno' value='"+
        $(this).attr("href")+"'>")//bno값을 추가하는 input태그를 생성
    actionForm.attr("action","/board/get")//액션값을 바꿔서 상세보기로~
    actionForm.submit()
  })
  var searchForm = $("#searchArea")
  console.log(searchForm)
  $("#searchArea button").on("click",function(e){
//$("#searchArea").children("input[type='button']").on("click",function(e){
      if(!searchForm.find("option:selected").val()){
      console.log(searchForm.find("option:selected").val())
      alert("검색 종류를 선택하세요!")
      return false
    }

    if(!searchForm.find("input[name='keyword']").val()){
      alert("키워드를 입력하세요!")
      return false
    }
    //검색을 하는 경우 만약 검색하기 전에 3페이지였던 경우 3페이지로 이동하는데 그것을 막기 위해 페이지
    //번호를 1번으로 해준다.
    searchForm.find("input[name='pageNum']").val("1")
    e.preventDefault()

    searchForm.submit()
  })
})
