package com.poly.service;

import java.util.List;

import com.poly.entity.Accounts;

public interface AccountsService {
	
	Accounts findById(String id);

	List<Accounts> findAll();

	List<Accounts> getAdmin();

	Accounts add(Accounts accountData);

	Accounts update(Accounts acc);

	void delete(String id);

}
