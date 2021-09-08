package com.poly.rest.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.poly.entity.Accounts;
import com.poly.service.AccountsService;

@CrossOrigin("*")	
@RestController
@RequestMapping("/rest/accounts")
public class AccountRestController {
	
	@Autowired
	AccountsService service;
	

	@GetMapping()
	public List<Accounts> getAccounts(@RequestParam("admins") Optional<Boolean> admin) {
		if (admin.orElse(false)) {
			return service.getAdmin();
		}
		return service.findAll();
	}
	
	@PostMapping
	public Accounts add(@RequestBody Accounts AccountData){ // khoi tao
		return service.add(AccountData);
	}
	
	@PutMapping("{id}")
	public Accounts update(@PathVariable("id") String id ,@RequestBody Accounts acc) {
		return service.update(acc);
	}
	
	@DeleteMapping("{id}")
	public void delete(@PathVariable("id") String id) {
		service.delete(id);
	}
	
	
}
