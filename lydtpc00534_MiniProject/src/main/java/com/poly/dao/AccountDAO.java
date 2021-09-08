package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.Accounts;

public interface AccountDAO extends JpaRepository<Accounts, String>{

	

	@Query("SELECT DISTINCT ar.account FROM Authorities ar WHERE ar.role.id IN ('DIRE', 'STAF')")
	// Lấy ra những account có vai trò DIRE và STAFF
	List<Accounts> findAdmin();
	
}
