package com.mem.model;

import java.util.*;

public interface MemDAO_interface {
	public MemVO loginMem(String mem_email);
	public void insert(MemVO memVO);
	public void update(MemVO memVO);
	public void delete(String mem_no);
	public MemVO findByPrimaryKey(String mem_no);
	public List<MemVO> getAll();
	
//	public void select(MemVO memVO); 
}
