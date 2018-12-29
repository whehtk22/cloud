package org.whehtk22.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.whehtk22.domain.MemberVO;
import org.whehtk22.domain.ReplyVO;
import org.whehtk22.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/register/*")
@Log4j
public class RegisterController {

	@Autowired
	private MemberMapper mapper;
	
	@GetMapping(value = "/idcheck/{id}" ,  produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> idcheck(@PathVariable("id") String id) {// json타입을 ReplyVO타입으로 변환
		log.info("idcheck+"+id);
		log.info("idcheck="+mapper.idCheck(id));
		return mapper.idCheck(id) == 0 ? new ResponseEntity<>("아이디는 중복되지 않습니다.", HttpStatus.OK)
				: new ResponseEntity<>("중복된 아이디가 있습니다.",HttpStatus.OK);
		// 3항 연산자로 처리해서 삽입되면 success신호를 보내고 아니면 에러.
	}
	/*@GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		log.info("get: " + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}*/
	@GetMapping(value = "/emailcheck/{email1}/{email2}", produces ="text/plain;charset=UTF-8")
	public ResponseEntity<String> emailcheck(@PathVariable("email1") String email1,@PathVariable("email2")String email2) {// json타입을 ReplyVO타입으로 변환
		String email = email1+"@"+email2;
		return mapper.emailCheck(email) == 0 ? new ResponseEntity<>("이메일은 중복되지 않습니다.", HttpStatus.OK)
				: new ResponseEntity<>("중복된 이메일이 있습니다.",HttpStatus.OK);
		// 3항 연산자로 처리해서 삽입되면 success신호를 보내고 아니면 에러.
	}
}
