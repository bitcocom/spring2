package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.Member;

public interface BoardService {

	public List<Board> getList(Criteria cri);	
	public Member login(Member vo);
	public void register(Board vo);
	public Board get(int idx);
	public void modify(Board vo);
	public void remove(int idx);
	public void replyProcess(Board vo);
	public int totalCount(Criteria cri);
}
