package kr.bit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.bit.entity.CustomUser;
import kr.bit.entity.Member;
import kr.bit.repository.MemberRepository;

@Service
public class UserDetailsServiceImpl implements UserDetailsService{

	@Autowired
	private MemberRepository memberRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		Member member=memberRepository.findById(username).get();
		if(member==null) {
			throw new UsernameNotFoundException(username+" 없음");
		}
		
		return new CustomUser(member); // User(3가지 권한정보)+Member(다른 회원정보)
	}

}
