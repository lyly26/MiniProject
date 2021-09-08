package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.dao.ProductDAO;
import com.poly.entity.Product;
import com.poly.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
		
		@Autowired
		ProductDAO dao;

		@Override
		public List<Product> findAll() {
			return dao.findAll();
		}

		@Override
		public Product findById(Integer id) {

			return dao.findById(id).get();
		}

		@Override
		public List<Product> findByCategoryId(String id) { //Lấy các loại sp theo id 
			
			return dao.findByCategoryId(id); //gọi lại pthuc trong dao
		}

		@Override
		public Product create(Product product) {
			
			return dao.save(product);
		}

		@Override
		public Product update(Product product) {
			
			return dao.save(product);
		}

		@Override
		public void deleteById(Integer id) {
			
			dao.deleteById(id);
		}
		
		@Override
		public List<Product> findByNameContaining(String keyword) {
			return dao.findByNameContaining(keyword);
		}
}
