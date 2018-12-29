package org.whehtk22.mapper;

import org.whehtk22.domain.AuthVO;
import org.whehtk22.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
	public void insert(MemberVO vo);
	
	public void insertauth(AuthVO vo);
	
	public int emailCheck(String email);
	
	public int idCheck(String id);
}
