package org.whehtk22.mapper;

import java.util.List;

import org.whehtk22.domain.Enq_BoardVO;
import org.whehtk22.domain.PageSetting;

public interface Enq_BoardMapper {

	//@Select("select * from enq_board where bno>0")
	public List<Enq_BoardVO> getList();
	
	public List<Enq_BoardVO> getListWithPaging(PageSetting page);
	
	public void insert(Enq_BoardVO board);
	
	public void insertSelectKey(Enq_BoardVO board);
	
	public Enq_BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(Enq_BoardVO board);
}
