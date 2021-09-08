package com.poly.service;

import java.util.List;

import com.poly.entity.Product;

public interface ProductService {
	
	List<Product> findAll();

	Product findById(Integer id);

	List<Product> findByCategoryId(String id); 

	Product create(Product product);

	Product update(Product product);

	void deleteById(Integer id);
	
	List<Product> findByNameContaining(String keyword);
	
}
