package org.whehtk22.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.whehtk22.domain.AttachFileDTO;
import org.whehtk22.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {//일정 시간을 정해서 주기적으로 실행하는 클래스

	@Setter(onMethod_= {@Autowired})
	private BoardAttachMapper attachMapper;
	/*@Scheduled(cron="0 * * * * *")//매분 0초가 될 때마다 실행
	public void checkFiles() {
		log.warn("File Check Task run......");
		
		log.warn("============================");
	}*/
	
	private String getFolderYesterDay() {//삭제할 폴더를 지정
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();//날짜 관련 클래스를 가져온다.
		
		cal.add(Calendar.DATE	, -1);//하루뺀 날짜
		
		String str = sdf.format(cal.getTime());//형식 변환
		
		return str.replace("-", File.separator);//"-"를 기준으로 폴더를 나누어 준다.
	}
	
	@Scheduled(cron="0 * * * * *")//매일 새벽 2시에 작동
	public void checkFiles(){
		log.warn("file Check Task run.............");
		log.warn(new Date());
		//file list in database
		List<AttachFileDTO> fileList = attachMapper.getOldFiles();
		
		//데이터베이스와 실제 경로의 파일 비교준비
		List<Path>fileListPaths = fileList.stream()
				.map(vo->Paths.get("C:\\upload", vo.getUploadPath(),vo.getUuid()+"_"+vo.getFileName()))
				//위의 문자열들을 합한 것들을 추출하여
				.collect(Collectors.toList());//리스트의 형태로 반환해준다.
		
		//이미지 썸네일 경로
		fileList.stream().filter(vo->vo.isImage()==true)
		.map(vo->Paths.get("C:\\upload", vo.getUploadPath(),"s_"+vo.getUuid()+"_"+vo.getFileName()))
		.forEach(p->fileListPaths.add(p));
		
		log.warn("==============================");
		
		fileListPaths.forEach(p->log.warn(p));
		
		//어제의 파일의 경로
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		//데이터 베이스의 파일들과 일치하지 않는 것들을 뽑아내서
		File[] removeFiles = targetDir.listFiles(file->fileListPaths.contains(file.toPath())==false);
		
		log.warn("-------------------------------------------");
		for(File file:removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
}
