package org.whehtk22.domain;

import lombok.Data;

@Data
public class AttachFileDTO {

	private String fileName;
	private String uploadPath;
	private String uuid;//저장된 위치에서 같은 파일 이름일 경우 앞에 붙여주는 식별자.
	private boolean image;//이미지 파일인지 아닌지의 여부
	//날짜 식별자
}
