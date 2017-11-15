package com.stored_history.model;

import java.util.*;


public interface StoredDAO_interface {
	public void insert(StoredVO storedVO);
	public void update(StoredVO storedVO);
	public void delete(String stored_No);
	public StoredVO findByPrimaryKey(String stored_No);
	public List<StoredVO> getAll(String mem_No);
	
//	public void select(StoredVO storedVO); 

}
