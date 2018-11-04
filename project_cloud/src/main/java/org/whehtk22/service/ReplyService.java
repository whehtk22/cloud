package org.whehtk22.service;

import java.util.List;

import org.whehtk22.domain.PageSetting;
import org.whehtk22.domain.ReplyPageDTO;
import org.whehtk22.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(PageSetting page, Long bno);//단순히 댓글들 전체를 반환하는 서비스
	
	public ReplyPageDTO getListPage(PageSetting page, Long bno);//댓글들과 그 수를 반환하는 서비스
}
