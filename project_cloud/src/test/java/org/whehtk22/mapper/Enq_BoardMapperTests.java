package org.whehtk22.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.whehtk22.domain.Enq_BoardVO;
import org.whehtk22.domain.PageSetting;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class Enq_BoardMapperTests {

	@Setter(onMethod_ = @Autowired)
	private Enq_BoardMapper mapper;
	
//@Test
	public void testGetList() {
		mapper.getList().forEach(board->log.info(board));
	}
//	@Test
	public void testInsert() {
		Enq_BoardVO board = new Enq_BoardVO();
		board.setTitle("새로 작성글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		
		mapper.insert(board);
		log.info(board);
	}
//	@Test
	public void testInsertSelectKey() {
		Enq_BoardVO board = new Enq_BoardVO();
		board.setTitle("새로 작성하는 글 select key");
		board.setContent("새로 작성하는 내용 select Key");
		board.setWriter("newbie");
		
		mapper.insertSelectKey(board);
	}
	@Test
	public void testRead() {
		//존재하는 게시물 번호로 테스트
		Enq_BoardVO board = mapper.read(9L);
		log.info(board);
	}
//	@Test
	public void testDelete() {
		log.info("DELETE COUNT: "+mapper.delete(3L));
	}
	//@Test
	public void testUpdate() {
		Enq_BoardVO board = new Enq_BoardVO();
		//실행전 존재하는 번호인지 확인할 것
		board.setBno(20L);
		board.setTitle("수정된 제목~");
		board.setContent("수정된 내용~~");
		board.setWriter("user~~~");
		
		int count = mapper.update(board);
		log.info("UPDATE COUNT: "+count);
	}
	@Test
	public void testPaging() {
		PageSetting page = new PageSetting();
		page.setAmount(10);
		page.setPageNum(1);
		List<Enq_BoardVO> list = mapper.getListWithPaging(page);
		
		list.forEach(board->log.info(board));
	}
}
