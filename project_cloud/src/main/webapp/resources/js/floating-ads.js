/**
 * .adsArea sticky floating 처리
 */
$(function(){
	//alert(1);//js 연결성 test용
	//header 높이값 가져오기
	headerheight = $("#headWrap").height();
	//mainVisual 높이값 가져오기
	mvheight = $("#mainVisualWrap").height();
	//footer 높이값 가져오기
	//footerheight = $("#footerWrap").height();
	
	scrY = headerheight+mvheight;
	console.log(scrY);
	
	//header 영역 가져오기
	header = $("#headWrap");
	
	//adsArea(광고)영역 높이값 구하기
	//scrY + adsArea
	adsAreaHeight = $(".adsArea").height();
	adsH = scrY+adsAreaHeight;
	console.log(adsH);
	
	//적용할 대상 :: div.adsArea 가져오기
	fltAds = $(".adsArea");
	
	//화면 스크롤 값이 scrY보다 크거나 같고,
	//화면 스크롤 값이 footerheight보다 작거나 같으면
		//광고 영역에 .fixed적용
	$(window).scroll(function(){
		if(window.scrollY >= scrY){
			fltAds.addClass("fixed");
		}else{
			fltAds.removeClass("fixed");
		}
	});
});