package org.whehtk22.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@GetMapping("/join")
	public String register() {
		return "/join";
	}
	
	@GetMapping("/login")
	public String login() {
		return "/login";
	}
}
