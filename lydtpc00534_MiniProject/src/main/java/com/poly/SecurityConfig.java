package com.poly;


import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.poly.entity.Accounts;
import com.poly.service.AccountsService;

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
@EnableWebSecurity
public class SecurityConfig  extends WebSecurityConfigurerAdapter{
	
	@Autowired
	AccountsService accountsService;

	@Autowired
	BCryptPasswordEncoder pEncoder;


	// Cung cấp nguồn dữ liệu đăng nhập
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(username -> {
			try {
				Accounts accounts = accountsService.findById(username);
				String password = accounts.getPassword(); // lấy ra password
				String[] roles = accounts.getAuthorities().stream().map(au -> au.getRole().getId())
						.collect(Collectors.toList()).toArray(new String[0]);
				return User.withUsername(username).password(pEncoder.encode(password)).roles(roles).build();
			} catch (Exception e) {
				throw new UsernameNotFoundException(username + e);
			}
		});
	}
	
	//Phân quyến sử dụng
		@Override
		protected void configure(HttpSecurity http) throws Exception {
			http.csrf().disable().cors().disable();
			http.authorizeRequests()
			.antMatchers("/order/**")
			.authenticated()
			.antMatchers("/admin/**", "/assets/admin/**").hasAnyRole("PM", "ADMIN")
			.antMatchers("/rest/authorities").hasRole("ADMIN")
			.anyRequest().permitAll();
			

			http.formLogin()
				.loginPage("/security/login/form") // form đăng nhập
				.loginProcessingUrl("/security/login") // action submit đúng đchi
				.defaultSuccessUrl("/security/login/success", false) //đăng nhâp thành công -- chỉ qua trang success
				.failureUrl("/security/login/error") // đăng nhập sai hoặc lỗi
				.usernameParameter("username") // default [username]
				.passwordParameter("password"); // default [password]

			http.rememberMe().tokenValiditySeconds(86400); // default [remember-me]

			http.exceptionHandling().accessDeniedPage("/security/unauthoried"); // truy xuất không hợp lệ, không đúng quyền

			http.logout().logoutUrl("/security/logoff").logoutSuccessUrl("/security/logoff/success");
		}
	
	//Cơ chế mã hóa mật khẩu
	@Bean
	public BCryptPasswordEncoder getPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	// Cho phép truy xuất REST API từ bên ngoài (domain khác)
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers(HttpMethod.OPTIONS, "/**");
	}

	
}

