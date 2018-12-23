package org.whehtk22.sample;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.apache.tika.Tika;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)//테스트 시 필요한 클래스지정
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j//Lombok을 이용해서 로그를 기록하는 Logger를 변수로 생성
public class DeleteTest {

	//@Test
	public void test() throws IOException {
		log.info("삭제 테스트");
		 String path = "C:\\upload\\"+"2018\\11\\11"+"\\"+"e672c2d5-8b31-47bb-a9de-d8e596c0cc43"+"_"+"파리나이트.jpg";
		   Path file = (Path) Paths.get(path);
		   log.info("파일 존재 여부"+Files.deleteIfExists((java.nio.file.Path) file));
		   log.info("파일");
		   Tika tika = new Tika();//파일의 타입을 찾아주는 클래스.
		   }
	}
