package com.proorder.model;

import java.util.List;

import com.pro.shoppingcart.ProCartVO;


public interface ProOrderDAO_interface {
	public void insert(ProOrderVO proOrderVO);
	public void update(ProOrderVO proVO);
	public void delete(String ProOrder_No);
	public List<ProOrderVO>getAll();
	public ProOrderVO findByPrimaryKey(String proOrder_No);
	//同時新增訂單及訂單明細
	public void insertProOrder_ProOrdList(ProOrderVO proOrderVO , List<ProCartVO> list);
	//查會員所有訂單
	public List<ProOrderVO> listProOrder(String mem_No);
	//
	public void updateOrderUp(ProOrderVO proOrderVO);
}
