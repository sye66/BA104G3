package com.mem.model;

import java.util.*;

public interface MemDAO_interface {
	public MemVO loginMem(String mem_Email);
	public void insert(MemVO memVO);
	public void update(MemVO memVO);
	public void updateByMem(MemVO memVO);
	public void delete(String mem_No);
	public MemVO findByPrimaryKey(String mem_No);
	public MemVO findByMemEmail(String mem_Email);
	public List<MemVO> getAll();
	public void register(MemVO memVO);
	public MemVO Authentication(MemVO memVO);
	
//	public void select(MemVO memVO); 
}
