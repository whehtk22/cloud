package org.whehtk22.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.whehtk22.domain.AttachFileDTO;
import org.whehtk22.domain.Enq_BoardVO;
import org.whehtk22.domain.PageSetting;
import org.whehtk22.mapper.BoardAttachMapper;
import org.whehtk22.mapper.Enq_BoardMapper;
import org.whehtk22.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class Enq_BoardServiceImpl implements Enq_BoardService {

	@Setter(onMethod_ = @Autowired)
	private Enq_BoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper replyMapper;
	@Transactional
	@Override
	public void register(Enq_BoardVO board) {
		log.info("register...."+board);
		mapper.insertSelectKey(board);
		if(board.getAttachList()==null||board.getAttachList().size()<=0) {
			return;
		}
		board.getAttachList().forEach(attach->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public Enq_BoardVO get(Long bno) {
		log.info("get....."+bno);
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(Enq_BoardVO board) {
		log.info("modify....."+board);
		
		attachMapper.deleteAll(board.getBno());//기존 첨부파일 관련 데이터를 삭제
		
		boolean modifyResult = mapper.update(board)==1;
		if(modifyResult && board.getAttachList().size()>0) {//게시판이 업데이트가 되고 게시판의 첨부파일의 갯수가 0개 이상이면
			board.getAttachList().forEach(attach->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;//수정된 갯수
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove..."+bno);
		attachMapper.deleteAll(bno);
		replyMapper.deleteAll(bno);
		return mapper.delete(bno)==1;
	}

	//@Override
	/*public List<Enq_BoardVO> getList() {
		log.info("getList.......");
		
		return mapper.getList();
	}*/

	@Override
	public List<Enq_BoardVO> getList(PageSetting page) {
		log.info("get List with page: "+page);
		return mapper.getListWithPaging(page);
	}
	@Override
	public int getTotal(PageSetting page) {
		log.info("get total count");
		return mapper.getTotalNum(page);
	}
	@Override
	public List<Enq_BoardVO> getListWithPaging(PageSetting page) {
		log.info("getList with paging");
		return mapper.getListWithPaging(page);
	}

	@Override
	public List<AttachFileDTO> getAttachList(Long bno) {
		log.info("get Attach list by bno"+bno);
		
		return attachMapper.findByBno(bno);
	}
}
