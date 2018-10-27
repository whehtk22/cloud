package org.whehtk22.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.whehtk22.domain.Enq_BoardVO;
import org.whehtk22.mapper.Enq_BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class Enq_BoardServiceImpl implements Enq_BoardService {

	@Setter(onMethod_ = @Autowired)
	private Enq_BoardMapper mapper;
	@Override
	public void register(Enq_BoardVO board) {
		log.info("register...."+board);
		mapper.insertSelectKey(board);

	}

	@Override
	public Enq_BoardVO get(Long bno) {
		log.info("get....."+bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(Enq_BoardVO board) {
		log.info("modify....."+board);
		return mapper.update(board)==1;//수정된 갯수
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove..."+bno);
		return mapper.delete(bno)==1;
	}

	@Override
	public List<Enq_BoardVO> getList() {
		log.info("getList.......");
		
		return mapper.getList();
	}

}
