/**
 * board/register에서
 * freeboard 또는 market_board selector 처리
 */
$(function(){
	$(".marketBLink").click(function(){
		//alert(2);//tester
		$.ajax({
			url:"/resources/ajaxdata/market.jsp",
			dataType:"html",//이게 안되면 jsp로
			type:"get",
			success:function(html){
				alert("성공");
				$("#write_form").html(html);
			},error:function(){
				alert("oops, 페이지 에러입니다. 다시 확인하고 연결하세요.");
			}
		});
	});
});