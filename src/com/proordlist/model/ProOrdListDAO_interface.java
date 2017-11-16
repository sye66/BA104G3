package com.proordlist.model;

import java.sql.Connection;
import java.util.List;


public interface ProOrdListDAO_interface {
	public void insert(ProOrdListVO proOrderVO,Connection con);
	public void update(ProOrdListVO proOrdListVO);
	public void delete(String ord_No);
	public List<ProOrdListVO>getAll();
	public List<ProOrdListVO> findByPrimaryKey(String ord_No);
}
