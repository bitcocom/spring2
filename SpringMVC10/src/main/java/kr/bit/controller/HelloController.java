package kr.bit.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController { // new HelloController()

	@RequestMapping("/hello")
	public String hello() {
		return "Hello Spring Boot~";
	}
}
