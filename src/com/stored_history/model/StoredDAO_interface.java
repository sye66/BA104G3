package com.stored_history.model;

import java.util.*;


public interface StoredDAO_interface {
	public void insert(StoredVO storedVO);
	public void update(StoredVO storedVO);
	public void delete(String stored_no);
	public StoredVO findByPrimaryKey(String stored_no);
	public List<StoredVO> getAll();
	
//	public void select(StoredVO storedVO); 

}
