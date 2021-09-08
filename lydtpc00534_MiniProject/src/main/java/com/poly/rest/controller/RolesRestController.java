package com.poly.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.entity.Roles;
import com.poly.service.RoleService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/roles")
public class RolesRestController {
	
	@Autowired
	RoleService service;

	@GetMapping()
	public List<Roles> get() {
		return service.findAll();
	}
	
}
