package org.whehtk22.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.whehtk22.domain.PageSetting;
import org.whehtk22.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(@Param("page") PageSetting page, @Param("bno") Long bno);
	
	public int getCountByBno(Long bno);
}
