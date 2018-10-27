$(function(){
	//alert(1);
	//menu btn
	var now = false;
	$("#menuWrap").click(function(){
		if(now==false){
			$(this).animate({"right":"185"},300,"linear");
			$("#gnb").animate({"right":"-15"},300,"linear");
			$(".midBar").css({"color":"transparent"});
			$(".topBar").css({"transform":"translatey(13px) rotatez(45deg)"});
			$(".btmBar").css({"transform":"translatey(-13px) rotatez(-45deg)"});
			now=true;
		}else{
			$(this).animate({"right":"5"},300,"linear");
			$("#gnb").animate({"right":"-500"},300,"linear");
			$(".midBar").css({"color":"#fff"});
			$(".topBar").css({"transform":"rotatez(0)"});
			$(".btmBar").css({"transform":"rotatez(0)"});
			now=false;
		}
	});	
});