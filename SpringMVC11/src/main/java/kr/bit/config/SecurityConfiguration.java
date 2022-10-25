package kr.bit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfiguration {
 
	@Autowired
	private UserDetailsServiceImpl userDetailsService;
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		
		http.csrf().disable();
		http.authorizeHttpRequests()
			.antMatchers("/", "/member/**").permitAll()
			.antMatchers("/board/**").authenticated()
			
			.and()
			.formLogin()
			.loginPage("/member/login")
			.defaultSuccessUrl("/board/list")
			
			.and()
			.logout()
			.logoutUrl("/member/logout")
			.logoutSuccessUrl("/");
		
		 http.userDetailsService(userDetailsService);
		
		return http.build();
	}
}
