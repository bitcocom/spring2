package kr.bit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.repository.BoardRepository;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardRepository boardRepository;
	
	@Override
	public List<Board> getList() {
		List<Board> list=boardRepository.findAll();
		return list;
	}

	@Override
	public void register(Board vo) {
		boardRepository.save(vo);
	}

	@Override
	public Board get(Long idx) {
		Optional<Board> vo=boardRepository.findById(idx);
		return vo.get();
	}

	@Override
	public void delete(Long idx) {
		boardRepository.deleteById(idx);		
	}

	@Override
	public void update(Board vo) {
		boardRepository.save(vo); // insert, update
	}

}
