package org.whehtk22.mapper;

import java.util.List;

import org.whehtk22.domain.AttachFileDTO;

public interface BoardAttachMapper {

	public void insert(AttachFileDTO dto);
	
	public void delete(String uuid);
	
	public List<AttachFileDTO>findByBno(Long bno);
	
	public void deleteAll(Long bno);
	
	public List<AttachFileDTO> getOldFiles();
}
