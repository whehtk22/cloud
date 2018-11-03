package org.whehtk22.service;

import java.util.List;

import org.whehtk22.domain.PageSetting;
import org.whehtk22.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(PageSetting page, Long bno);
}
