package org.whehtk22.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	private int startPage;//화면에 나오는 페이지의 시작번호
	private int endPage;//화면에 나오는 페이지의 끝번호
	private boolean prev,next;//페이지에서 이전과 다음이 존재하는지의 여부를 체크
	
	private int total;
	private PageSetting page;
	
	public PageDTO(PageSetting page, int total) {
		this.page=page;
		this.total=total;
		
		this.endPage=(int)(Math.ceil(page.getPageNum()/10.0))*10;
		this.startPage=this.endPage-9;
		
		int realEnd = (int)(Math.ceil((total*1.0)/page.getAmount()));//실제 마지막 페이지 번호
		if(realEnd<this.endPage) {//형식적인 마지막 페이지가 실제 마지막 페이지 번호보다 클 경우
			this.endPage=realEnd;
		}
		
		this.prev=this.startPage>1;
		
		this.next=this.endPage<realEnd;
	}
}
