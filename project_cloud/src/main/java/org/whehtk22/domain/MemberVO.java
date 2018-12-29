package org.whehtk22.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberVO {

	private String userid;
	private String userpw;
	private String username;
	private boolean enabled;
	
	private Date regdate;
	private Date updatedate;
	private String useremail;
	private String phone;
	private List<AuthVO> authList;
}
