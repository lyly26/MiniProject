package com.poly.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.entity.Product;
import com.poly.service.ProductService;

@Controller
public class HomeController {

	@Autowired
	ProductService service;

	@RequestMapping({ "/", "/home/index" })
	public String home() {
		return "redirect:/product/list";
	}

	@RequestMapping("/home/about")
	public String about() {
		return "home/about";
	}
	
//	@RequestMapping("/home/contact")
//	public String contact() {
//		return "home/contact";
//	}
	
	
	@RequestMapping("/product/list")
	public String list(Model model, @RequestParam("cid") Optional<String> id) { //lộc sp theo loại, @RequestParam("cid") tham số tùy chọn, nếu có hthi theo loại 
		if (id.isPresent()) { //mếu có mã koaji thì lộc theo loại 
			
			List<Product> list = service.findByCategoryId(id.get()); //Lấy id
			model.addAttribute("items", list);
		} else {  //không có lộc tất cả
			List<Product> list = service.findAll(); //Lấy tất cả các sp
			model.addAttribute("items", list);      //Đưa list vào model -- chuyển sang gdien hiện ra
		}
		return "home/main";
	}
	
	
	//chi tiết sản phẩm
	@RequestMapping("/product/details/{id}") 
	public String detail(Model model, @PathVariable("id") Integer id) { //Lấy mã sp thông qua đối số @PathVariable 
		
		//Truy vấn sp gọi thep mã
		Product product = service.findById(id);
		//Đưa sp vào model
		model.addAttribute("item", product);
		return "home/product_details";
	}
	
	/* =============================== */
			
	@RequestMapping({ "/admin", "/admin/home/index" })
	public String admin() {
		return "redirect:/admin/index.html";
	}
	
	@PostMapping("/product/findkeyword")
	public String findKeyWord(Model model, @RequestParam("keyword") String keyword) {
		List<Product> list = service.findByNameContaining(keyword);
		if(list.isEmpty()) {
			return "redirect:/product/list";
		}
		model.addAttribute("list", list);
		return "product/list";
	}

}
