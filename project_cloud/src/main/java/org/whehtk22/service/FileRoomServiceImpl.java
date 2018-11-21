package org.whehtk22.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.whehtk22.domain.FileVO;
import org.whehtk22.mapper.FileRoomMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class FileRoomServiceImpl implements FileRoomService{

	@Setter(onMethod_=@Autowired)
	private FileRoomMapper mapper;


	@Override
	public void remove(String fileuser, String uuid) {
		mapper.remove(fileuser, uuid);
	}

	@Override
	public List<FileVO> findFile(String fileuser) {
		return mapper.findFile(fileuser);
	}


	@Override
	public void removeAll(String fileuser) {
		mapper.removeAll(fileuser);
	}

	@Override
	public List<FileVO> findImage(String fileuser) {
		
		return mapper.findImage(fileuser);
	}

	@Override
	public void update(FileVO dto) {
		mapper.upload(dto);
	}


}
