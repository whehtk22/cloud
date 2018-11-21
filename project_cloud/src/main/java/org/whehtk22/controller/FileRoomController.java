package org.whehtk22.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.whehtk22.domain.AttachFileDTO;
import org.whehtk22.domain.FileVO;
import org.whehtk22.service.FileRoomService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/file")
@AllArgsConstructor
public class FileRoomController {

	private FileRoomService service;
	
	@GetMapping(value="/getFileList",
			   produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	   @ResponseBody
	   public ResponseEntity<List<FileVO>>getFileList(String user){
		   log.info("getFileList"+user);
		   
		   return new ResponseEntity<>(service.findFile(user),HttpStatus.OK);
	   }
	@GetMapping(value="/getImageList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<FileVO>>getImageList(String user){
		log.info("getImageList"+user);
		return new ResponseEntity<>(service.findImage(user),HttpStatus.OK);
	}
	@PostMapping(value="/upload",produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<FileVO>> uploadAjaxPost(@RequestHeader("User-Agent") String userAgent, MultipartFile[] uploadFile) {
		
		List<FileVO>list = new ArrayList<>();
		String uploadFolder = "C:\\fileroom";
		
		String uploadFolderPath = getFolder();//업로드하는 자세한 경로.
		//make folder ---------------
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		
		if(uploadPath.exists()==false) {//폴더가 존재하지 않으면 
			uploadPath.mkdirs();//폴더를 생성해 준다.
		}
		
		for(MultipartFile multipartfile:uploadFile) {
			
			FileVO fileVO = new FileVO();
			
			String uploadFileName = multipartfile.getOriginalFilename();
			
			if(userAgent.contains("Trident")||userAgent.contains("Edge")) {//인터넷 익스플로러와 엣지는 파일 이름이 전체 경로까지 다 나온다.
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);//그렇기 때문에 경로들을 이름에서 제외해 준다.
			}
			log.info("only file name: "+uploadFileName);
			fileVO.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();//uuid를 랜덤으로 생성해주어서
			fileVO.setUuid(uuid.toString());
			fileVO.setUploadPath(uploadFolderPath);
			uploadFileName = uuid.toString()+"_"+uploadFileName;//uuid뒤에 _를 붙여서 파일 이름뒤에 붙인다.
			
			try {
				File saveFile = new File(uploadPath,uploadFileName);
				multipartfile.transferTo(saveFile);
				//이미지 타입의 파일인지 체크한다.
				if(checkImageType(saveFile)) {
					fileVO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					//앞에 s_가 붙는 파일을 경로에 생성해주는 outputstream을 생성
					Thumbnailator.createThumbnail(multipartfile.getInputStream(), thumbnail, 200,200);
					//받아온 multipartfile을 위의 경로의 이름으로 100*100사이즈로 생성해준다.
					thumbnail.close();
				}
				log.info(fileVO);
				fileVO.setFileuser("user1");
				list.add(fileVO);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		for(FileVO fileVO:list) {
			service.update(fileVO);
		}
		return new ResponseEntity<>(list,HttpStatus.OK);//받은 쪽으로 다시 결과확인값을 보내준다.
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		String str = sdf.format(date);//오늘 날짜를 받아서
		
		return str.replace("-", File.separator);//-표시를 기준으로 \\를 넣어서 폴더의 이름을 반환
	}
	
	private boolean checkImageType(File file) {
		try {
			Tika tika = new Tika();//파일의 타입을 찾아주는 클래스.
			 String mimeType = tika.detect(file);//컨텐트 타입을 반환
			 log.info(mimeType);
			 log.info(mimeType.indexOf("/"));//'/'의 인덱스번호를 반환해준다.
			 log.info(mimeType.substring(mimeType.indexOf("/")+1));//'/'의 인덱스의 다음부터의 문자열을 반환해준다.
			return mimeType.startsWith("image");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]>getFile(String fileName){
		log.info("fileName: "+fileName);
		
		File file = new File("c:\\fileroom\\"+fileName);
		
		log.info("file: "+file);
		
		ResponseEntity<byte[]>result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			Tika tika = new Tika();//파일의 타입을 찾아주는 클래스.
			 String mimeType = tika.detect(file);
			header.add("Content-Type",mimeType );//파일을 바이트로 변환해서 보내준다.
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header,HttpStatus.OK);
		}catch(IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName,String type,String user) throws InterruptedException{
		log.info("deleteFile : "+fileName);
		
		File file;
		try {
			String decoded = URLDecoder.decode(fileName, "UTF-8").replace('\\','/');
			String realname = decoded.substring(fileName.lastIndexOf('/')+1);
			String uuid = decoded.substring(realname.lastIndexOf('/')+1, realname.lastIndexOf('_'));
			String filename = decoded.substring(realname.lastIndexOf('_')+1);
			log.info("realname = "+realname);
			log.info("uuid = "+uuid);
			log.info("filename = "+filename);
			file = new File("C:/fileroom/"+URLDecoder.decode(fileName, "UTF-8").replace('\\','/'));
			log.info("원본파일"+"C:/fileroom/"+URLDecoder.decode(fileName, "UTF-8").replace('\\','/'));
			file.delete();
			service.remove(user, uuid);
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");//섬네일이 아닌 원본이미지파일을 지워준다.
				log.info("largeFileName: "+largeFileName);
				file = new File(largeFileName);
				file.delete();
				
			}
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String> ("deleted",HttpStatus.OK);
	}
}
