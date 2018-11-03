package org.whehtk22.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.whehtk22.domain.Enq_BoardVO;
import org.whehtk22.domain.PageDTO;
import org.whehtk22.domain.PageSetting;
import org.whehtk22.service.Enq_BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")//  /board라는 주소에 모두 매핑
@AllArgsConstructor
public class BoardController {

	private Enq_BoardService service;
	
  /* @GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("list",service.getList());
	}*/
	@GetMapping("/list")
	public void list(PageSetting page,Model model) {
		log.info("list: "+page);
		model.addAttribute("list",service.getListWithPaging(page));
//		model.addAttribute("page",new PageDTO(page,123));
		
		int total = service.getTotal(page);
		
		log.info("total: "+total);
		model.addAttribute("page",new PageDTO(page,total));
	}
   @GetMapping("/register")
   public String register() {
	   System.out.println("register");
	   return "/board/write_view";
   }
   @PostMapping("/register")
	public String register(Enq_BoardVO board, RedirectAttributes rttr) {
		log.info("register: "+board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result",board.getBno());//새롭게 등록된 게시블의 번호를 같이 전달.
		return "redirect:/board/list";//스프링이 자동적으로 response.sendRedirect()를 처리해 준다.
	}
   @GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("page") PageSetting page, Model model) {
		log.info("/get or /modify");
		model.addAttribute("board",service.get(bno));
	}
   @PostMapping("/modify")
   public String modify(Enq_BoardVO board,@ModelAttribute("page") PageSetting page, RedirectAttributes rttr) {
	   	log.info("modify: "+board);
		
	   	if(service.modify(board)) {
	   		rttr.addFlashAttribute("result","success");
	   	}
		rttr.addAttribute("pageNum",page.getPageNum());
		rttr.addAttribute("amount",page.getAmount());
		rttr.addAttribute("type",page.getType());//목록으로 이동하기 전에 전에 검색했던 사항들을 추가해서 전달.
		rttr.addAttribute("keyword",page.getKeyword());
		
		return "redirect:/board/list"+page.getListLink();
	}
   @PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("page") PageSetting page, RedirectAttributes rttr) {
		log.info("remove......"+bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum",page.getPageNum());
		rttr.addAttribute("amount",page.getAmount());
		rttr.addAttribute("type",page.getType());//목록으로 이동하기 전에 전에 검색했던 사항들을 추가해서 전달.
		rttr.addAttribute("keyword",page.getKeyword());
		
		return "redirect:/board/list"+page.getListLink();
	}
   
}
