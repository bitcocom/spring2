package kr.bit;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.bit.entity.Member;
import kr.bit.entity.Role;
import kr.bit.repository.MemberRepository;

@SpringBootTest
class SpringMvc11ApplicationTests {

	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Test
	void createMember() {
		Member m=new Member();
		m.setUsername("cocom");
		m.setPassword(encoder.encode("cocom"));  // 암호화
		m.setName("박에셀");
		m.setRole(Role.MANAGER);
		m.setEnabled(true);
		memberRepository.save(m); // 회원가입
	}

}
