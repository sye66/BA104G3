package com.proclass.model;

import java.util.List;
import java.util.Set;

import com.pro.model.ProVO;

public interface ProClassDAO_interface {
	public void insert(ProClassVO proClassVO);
	public void update(ProClassVO proClassVO);
	public void delete(String pro_Class_No);
	public List<ProClassVO>getAll();
	public ProClassVO findByPrimaryKey(String pro_Class_No);
	public Set<ProVO>getOneClassPro(String pro_Class_Name);
}
