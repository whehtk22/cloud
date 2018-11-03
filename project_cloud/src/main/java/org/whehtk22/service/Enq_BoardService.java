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
	
	public List<Enq_BoardVO>getListWithPaging(PageSetting page);
	
	public int getTotal(PageSetting page);//sql문을 처리하는데에는 필요없는 PageSetting이지만 검색처리에서 쓰인다.
}
