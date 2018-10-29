package org.whehtk22.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageSetting {
	
	private int pageNum;
	private int amount;
	
	public PageSetting() {
		this(1,10);//기본값으로 page번호는 1번, 한 페이지당 출력할 양은 10개
	}
	public PageSetting(int pageNum, int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}
	
}
