package org.whehtk22.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageSetting {
	
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	public PageSetting() {
		this(1,10);//기본값으로 page번호는 1번, 한 페이지당 출력할 양은 10개
	}
	public PageSetting(int pageNum, int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}
	//검색조건을 포함하여 검색 유형을 type으로 정하고 검색 조건을 스트링 배열로 처리한다.
	//만약 타입이 TC로 들어오는 경우 TC를 T,C로 분할하여 배열로 해서 보내준다.
	public String[] getTypeArr() {
		return type==null? new String[] {}:type.split("");
	}
	
	public String getListLink() {//여러개의 파라미터를 이용해서 URL의 형태로 만들어주는 기능.
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
}
