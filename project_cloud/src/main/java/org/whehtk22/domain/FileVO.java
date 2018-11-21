package org.whehtk22.domain;

import lombok.Data;

@Data
public class FileVO {

	private String fileName;
	private String uploadPath;
	private String uuid;//저장된 위치에서 같은 파일 이름일 경우 앞에 붙여주는 식별자.
	private boolean image;
	private String fileuser;
}
