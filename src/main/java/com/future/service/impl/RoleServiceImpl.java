package com.future.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.future.dao.RoleMapper;
import com.future.domain.Role;
import com.future.service.RoleServiceI;

@Service
@Transactional
public class RoleServiceImpl implements RoleServiceI {

	@Autowired
	private RoleMapper roleMapper;

	public List<Role> getAllRole() {
		return roleMapper.getAllRole();
	}
}  
