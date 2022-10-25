package kr.bit.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import kr.bit.entity.Member;

public interface MemberRepository extends JpaRepository<Member, String>{

}
