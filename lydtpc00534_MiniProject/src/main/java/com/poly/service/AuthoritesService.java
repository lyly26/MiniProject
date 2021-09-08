package com.poly.service;

import java.util.List;

import com.poly.entity.Authorities;

public interface AuthoritesService {
	
	public List<Authorities> findAuthoritiesOfAdministrators();

	List<Authorities> findAll();

	Authorities save(Authorities authority);

	void delete(Integer id);
}
