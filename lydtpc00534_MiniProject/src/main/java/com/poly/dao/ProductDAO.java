package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.Product;

public interface ProductDAO extends JpaRepository<Product, Integer>{

	
	@Query("SELECT p FROM Product p WHERE p.category.id= ?1") //Lấy ra sp có mã loại 
	
	List<Product> findByCategoryId(String id);
	
	List<Product> findByNameContaining(String keyword);
}
