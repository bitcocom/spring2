package kr.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class HelloController { // new HelloController()

	@RequestMapping("/")
	public String hello() {
		return "index"; // /WEB-INF/index.jsp
	}
}
