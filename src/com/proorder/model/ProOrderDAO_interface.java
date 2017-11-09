package com.proorder.model;

import java.util.List;


public interface ProOrderDAO_interface {
	public void insert(ProOrderVO proOrderVO);
	public void update(ProOrderVO proVO);
	public void delete(String ProOrder_No);
	public List<ProOrderVO>getAll();
	public ProOrderVO findByPrimaryKey(String ProOrder_No);
}
