package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.entity.Product;
import com.poly.service.ProductService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/products")
public class ProductRestController {
	
	@Autowired
	ProductService productService;

	@GetMapping("{id}")
	public Product getOne(@PathVariable("id") Integer id) {
		return productService.findById(id); //lấy 1 sp theo id
	}

	@GetMapping()
	public List<Product> getList() {
		return productService.findAll();
	}

	@PostMapping()
	public Product save(@RequestBody Product product) {
		return productService.create(product);
	}

	@PutMapping("{id}")
	public Product put(@PathVariable("id") Integer id, @RequestBody Product product) {
		return productService.update(product);
	}

	@DeleteMapping("{id}")
	public void delete(@PathVariable("id") Integer id) {
		 productService.deleteById(id);
	}
}
