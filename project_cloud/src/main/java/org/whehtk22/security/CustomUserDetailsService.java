package org.whehtk22.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.whehtk22.domain.CustomUser;
import org.whehtk22.domain.MemberVO;
import org.whehtk22.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{

	@Setter(onMethod_ = {@Autowired})
	private MemberMapper memberMapper;

	/*@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}*/

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.warn("Load User By UserName : "+username);
		System.out.println(memberMapper.read(username));
		//userName means userid
		MemberVO vo = memberMapper.read(username);
		
		log.warn("queried by member mapper: "+vo);
		
		return vo == null ? null: new CustomUser(vo);
	}
	
	
}
