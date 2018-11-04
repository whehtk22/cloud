package org.whehtk22.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.whehtk22.domain.PageSetting;
import org.whehtk22.domain.ReplyPageDTO;
import org.whehtk22.domain.ReplyVO;
import org.whehtk22.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService service;
	//consumes=> 처리할 데이터의 종류, produces=> 반환할 타입
	@PostMapping(value="/new", consumes="application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){//json타입을 ReplyVO타입으로 변환
		log.info("ReplyVO : "+vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT: "+insertCount);
		
		return insertCount==1?new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		//3항 연산자로 처리해서 삽입되면 success신호를 보내고 아니면 에러.
	}
	
	@GetMapping(value="/pages/{bno}/{page}",
			produces= {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page")int pagenum, @PathVariable("bno")Long bno){
		log.info("getList............");
		PageSetting pagesetting = new PageSetting(pagenum,10);
		log.info(pagesetting);
		
		return new ResponseEntity<>(service.getListPage(pagesetting, bno),HttpStatus.OK);
	}
	
	@GetMapping(value="/{rno}",
			produces= {MediaType.APPLICATION_XML_VALUE,
								MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno")Long rno){
		log.info("get: "+rno);
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	}
	@DeleteMapping(value="/{rno}",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		log.info("remove: "+rno);
		
		return service.remove(rno)==1?new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@RequestMapping(method= {RequestMethod.PUT,RequestMethod.PATCH},
			value="/{rno}",
			consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo,
																		@PathVariable("rno") Long rno){
		vo.setRno(rno);
		log.info("rno: "+rno);
		log.info("modify: "+vo);
		
		return service.modify(vo)==1?new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
