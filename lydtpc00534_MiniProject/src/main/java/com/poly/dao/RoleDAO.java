package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.entity.Roles;



public interface RoleDAO extends JpaRepository<Roles, String>{

}
