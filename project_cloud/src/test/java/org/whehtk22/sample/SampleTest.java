package org.whehtk22.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)//테스트 시 필요한 클래스지정
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j//Lombok을 이용해서 로그를 기록하는 Logger를 변수로 생성
public class SampleTest {

	@Setter(onMethod_ = {@Autowired})
	private Restaurant restaurant;
	
	//@Test//테스트 대상 표시
	public void testExist() {
		assertNotNull(restaurant);
		
		log.info(restaurant);
		log.info("---------------------------------");
		log.info(restaurant.getChef());
		
	}
}
