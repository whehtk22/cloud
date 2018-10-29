package org.whehtk22.service;

import java.util.List;

import org.whehtk22.domain.Enq_BoardVO;
import org.whehtk22.domain.PageSetting;

public interface Enq_BoardService {

	public void register(Enq_BoardVO board);
	
	public Enq_BoardVO get(Long bno);
	
	public boolean modify(Enq_BoardVO board);
	
	public boolean remove(Long bno);
	
//	public List<Enq_BoardVO> getList();
	
	public List<Enq_BoardVO>getList(PageSetting page);
	
}
