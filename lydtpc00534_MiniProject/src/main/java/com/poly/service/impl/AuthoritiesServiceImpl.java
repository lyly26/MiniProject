package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.dao.AccountDAO;
import com.poly.dao.AuthoritiesDAO;
import com.poly.entity.Accounts;
import com.poly.entity.Authorities;
import com.poly.service.AuthoritesService;
@Service
public class AuthoritiesServiceImpl implements AuthoritesService {
	
	@Autowired
	AccountDAO dAccountDAO;
	@Autowired
	AuthoritiesDAO dao;

	public List<Authorities> findAuthoritiesOfAdministrators() {
		List<Accounts> accounts = dAccountDAO.findAdmin();
		System.out.println(dao.authoritiesOf(accounts));
		return dao.authoritiesOf(accounts);
	}

	@Override
	public List<Authorities> findAll() {
		return dao.findAll();
	}

	@Override
	public Authorities save(Authorities authorities) {
		return dao.save(authorities);
	}

	@Override
	public void delete(Integer id) {
		dao.deleteById(id);

	}
}
