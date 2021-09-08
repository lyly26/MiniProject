package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.dao.AccountDAO;
import com.poly.entity.Accounts;
import com.poly.service.AccountsService;
@Service
public class AccountServiceImpl implements AccountsService {
	
	@Autowired
	AccountDAO dao;
	

	@Override
	public Accounts findById(String id) {
		
		return dao.findById(id).get();
	}	

	@Override
	public List<Accounts> findAll() {
		return dao.findAll();
	}

	@Override
	public List<Accounts> getAdmin() {
		
		return dao.findAdmin();
	}

	@Override
	public Accounts add(Accounts accountData) {
		return dao.save(accountData);
	}

	@Override
	public Accounts update(Accounts acc) {
		return dao.save(acc);
	}

	@Override
	public void delete(String id) {
		dao.deleteById(id);
		
	}
	

	
}
