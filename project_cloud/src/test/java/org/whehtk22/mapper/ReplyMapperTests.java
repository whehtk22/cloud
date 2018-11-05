/*package org.whehtk22.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.whehtk22.domain.PageSetting;
import org.whehtk22.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	private Long[] bnoArr = {2097150L, 2097149L,2097148L,2097147L,2097146L};
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	//@Test
	public void testCreate() {
		IntStream.rangeClosed(1,10).forEach(i->{
			ReplyVO vo = new ReplyVO();
			
			//게시물의 번호
			vo.setBno(bnoArr[i%5]);
			vo.setReply("댓글 테스트 " +i);
			vo.setReplyer("replyer"+i);
			
			mapper.insert(vo);
		});
	}
	//@Test
	public void testRead() {
		Long targetRno = 5L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
	}
	//@Test
	public void testDelete() {
		Long targetRno=2L;
		mapper.delete(targetRno);
	}
	//@Test
	public void testUpdate() {
		Long targetRno = 10L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		vo.setReply("Update reply ");
		int count = mapper.update(vo);
		
		log.info("UPDATE COUNT: "+count);
	}
	//@Test
	public void testList() {
		PageSetting page = new PageSetting();
		List<ReplyVO> replies = mapper.getListWithPaging(page, bnoArr[0]);
		
		replies.forEach(rep->log.info(rep));
	}
	//@Test
	public void testMapper() {
		log.info(mapper);
	}
	//@Test
	public void testList2() {
		PageSetting page = new PageSetting(2,10);
		
		List<ReplyVO> replies = mapper.getListWithPaging(page, 2097150L);
		
		replies.forEach(reply->log.info(reply));
	}
}
*/