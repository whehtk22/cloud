package org.whehtk22.mapper;

import java.util.List;

import org.whehtk22.domain.FileVO;

public interface FileRoomMapper {
	
	public void remove(String fileuser, String uuid);
	
	public List<FileVO> findAll(String fileuser);
	
	public List<FileVO>findDocu(String fileuser);
	
	public List<FileVO>findImage(String fileuser);
	
	public List<FileVO>findVideo(String fileuser);
	
	public void removeAll(String fileuser);

	public void upload(FileVO dto);
}
