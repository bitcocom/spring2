package kr.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.Board;
import kr.bit.service.BoardService;
import lombok.extern.log4j.Log4j;

@Controller  // POJO
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	BoardService boardService;
	
	@GetMapping("/list")
	public String getList(Model model) {
		List<Board> list=boardService.getList();
		// 객체바인딩
		model.addAttribute("list", list); // Model
		return "board/list"; // View
 	}
	@GetMapping("/register")
	public String register() {
		return "board/register";
	}
	
	@PostMapping("/register")
	public String register(Board vo, RedirectAttributes rttr) { // 파라메터수집(vo)<-- 한글인코딩
		boardService.register(vo); // 게시물등록(vo->idx, boardGroup)
		System.out.println(vo);
		rttr.addFlashAttribute("result", vo.getIdx()); // ${result}
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public String get(@RequestParam("idx") int idx, Model model) {
		Board vo=boardService.get(idx);
		model.addAttribute("vo", vo);
		return "board/get"; // /WEB-INF/views/board/get.jsp
	}
	@GetMapping("/modify")
	public String modify(@RequestParam("idx") int idx, Model model) {
		Board vo=boardService.get(idx);
		model.addAttribute("vo", vo);
		return "board/modify"; // /WEB-INF/views/board/modify.jsp
	}
	@PostMapping("/modify")
	public String modify(Board vo) {
		boardService.modify(vo); //수정		
		return "redirect:/board/list";
	}
	@GetMapping("/remove")
	public String remove(int idx) {
		boardService.remove(idx);
		return "redirect:/board/list";
	}
	@GetMapping("/reply")
	public String reply(int idx, Model model) {
		Board vo=boardService.get(idx);
		model.addAttribute("vo", vo);
		return "board/reply"; // /WEB-INF/views/board/reply.jsp
	}
	@PostMapping("/reply")
	public String reply(Board vo) {
		// 답글에 필요한 처리....
		boardService.replyProcess(vo); // 답글 저장됨
		return "redirect:/board/list";
	}
}
