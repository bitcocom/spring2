package kr.bit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.bit.entity.Board;

@Repository // 생략                      (CRUD Method)
public interface BoardRepository extends JpaRepository<Board, Long>{
		
   	// public List<Board> findAll();
	// -> select * from Board
	// public Board findById(Long idx);
	//-> select * from Board where idx=#{idx}
	// 쿼리메서드
	// public Board findByWriter(String writer);
	// ->select * from Board where writer=#{writer}
	
}
