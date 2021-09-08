package com.poly.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.poly.service.CategoryService;
@Configuration
public class GlobalInterceptor implements HandlerInterceptor {
	
	@Autowired
	CategoryService service;

	//Danh sách các loại
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		request.setAttribute("cates", service.findAll());
		
		
	}
}
