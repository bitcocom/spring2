package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;

public interface BoardService {

	public List<Board> getList(); //전체리스트
	public void register(Board vo);// 글등록	
	public Board get(Long idx); // 상세보기
	public void delete(Long idx); // 삭제
	public void update(Board vo);// 수정
}
