package org.whehtk22.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.whehtk22.domain.AuthVO;
import org.whehtk22.domain.MemberVO;
import org.whehtk22.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value="/member/*")
@Log4j
public class MemberController {

	@Autowired
	private MemberMapper mapper; 
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@GetMapping("/join")
	public String termsandpriv() {
		return "/join";
	}
	
	@PostMapping("/join")
	@Transactional
	public String register(@RequestParam(value = "_csrf", required = false) String _csrf, String userid, String userpw1, String username, String useremail1,String useremail2, String phone) {
		log.info(pwencoder.encode(userpw1));
		String email = useremail1+"@"+useremail2;
		MemberVO vo = MemberVO.builder().userid(userid).username(username).useremail(email).phone(phone).userpw(pwencoder.encode(userpw1)).build();
		log.info("user정보"+vo);
		mapper.insert(vo);
		mapper.insertauth(new AuthVO(vo.getUsername(),"ROLE_MEMBER"));
		return "redirect:/index";
	}
}
