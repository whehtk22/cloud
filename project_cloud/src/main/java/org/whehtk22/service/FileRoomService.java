package org.whehtk22.service;

import java.util.List;

import org.whehtk22.domain.FileVO;

public interface FileRoomService {

	public void remove(String fileuser,String uuid);
	public List<FileVO> findAll(String fileuser);
	public List<FileVO> findDocu(String fileuser);
	public List<FileVO> findImage(String fileuser);
	public List<FileVO> findVideo(String fileuser);
	public Long findSum(String fileuser);
	public void removeAll(String fileuser);
	void update(FileVO dto);
}
