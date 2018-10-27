package org.whehtk22.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.*;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration//Test for Controller
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class BoardControllerTests {

	@Setter(onMethod_ = {@Autowired} )
	private WebApplicationContext context;
	
	private MockMvc mockMvc;//가짜 mvc ; 가짜로 URL과 파라미터 등을 브라우저에서 사용하는 것처럼 만든다.
	
	@Before//모든 테스트 전에 매번 실행되는 메서드
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	//@Test
	public void testList() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
		.andReturn()
		.getModelAndView()//모델에 있는 것을 확인해 볼 수 있다.
		.getModelMap());
	}
//	@Test
	public void testRegister()throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register").
				param("title","테스트 새글 제목")
				.param("content","테스트 새글 내용")
				.param("writer","user000")).
				andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	//@Test
	public void testGet() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get").
				param("bno","10")).andReturn().getModelAndView().getModelMap());
	}
	//@Test
	public void testModify()throws Exception{
		String resultpage = mockMvc
				.perform(MockMvcRequestBuilders.post("/board/modify")
						.param("bno", "1")
						.param("title", "수정된 제목")
						.param("content","수정된 내용")
						.param("writer","user0000"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultpage);
	}
	@Test
	public void testRemove() throws Exception{
		//삭제 전 데이터베이스에 게시물 번호 확인할 것
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "23")
				).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
}
