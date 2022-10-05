package kr.bit.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.bit.mapper.BoardMapperTest;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardServiceTest {
     
	@Autowired
	BoardService boardService;
	
	@Test
	public void testGetList() {
		// List<Board>
		boardService.getList().forEach(vo->log.info(vo));
	}
}
