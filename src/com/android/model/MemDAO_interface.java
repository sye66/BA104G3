package com.android.model;

import java.util.List;


public interface MemDAO_interface {
	 public void insert(MemVO memVO);
     public void update(MemVO memVO);
     public void delete(String mem_No);
     public MemVO findByPrimaryKey(String mem_No);
     public List<MemVO> getAll();
     public List<MemVO> getAll(String mem_No);
}
