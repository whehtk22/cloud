package org.whehtk22.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.whehtk22.domain.PageSetting;
import org.whehtk22.domain.ReplyPageDTO;
import org.whehtk22.domain.ReplyVO;
import org.whehtk22.mapper.Enq_BoardMapper;
import org.whehtk22.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	@Setter(onMethod_=@Autowired)
	private Enq_BoardMapper boardmapper;
	
	@Transactional
	public int register(ReplyVO vo) {
		
		boardmapper.updateReplyCnt(vo.getBno(), 1);
		log.info("register..."+vo);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get..."+rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify.."+vo);
		return mapper.update(vo);
	}
	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove..."+rno);
		ReplyVO vo = mapper.read(rno);//해당 댓글의 정보를 읽어와서
		boardmapper.updateReplyCnt(vo.getBno(), -1);//해당 댓글이 포함된 게시물의 번호를 가져와서 댓글의 수를 감소시킨다.
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(PageSetting page, Long bno) {
		log.info("get Reply List of a Board "+bno);
		return mapper.getListWithPaging(page, bno);
	}

	@Override
	public ReplyPageDTO getListPage(PageSetting page, Long bno) {
		
		return new ReplyPageDTO(mapper.getCountByBno(bno),mapper.getListWithPaging(page, bno));
	}
}
