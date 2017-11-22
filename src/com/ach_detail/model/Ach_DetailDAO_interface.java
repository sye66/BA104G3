package com.ach_detail.model;

import java.util.List;

import com.ach_detail.model.Ach_DetailVO;

public interface Ach_DetailDAO_interface {
	public void insert(Ach_DetailVO ach_detailVO);
    
	public void delete(String mem_No);
    public Ach_DetailVO findByPrimaryKey(String mem_No);
    public List<Ach_DetailVO> getAll();
    public List<Ach_DetailVO> getPersonal(String mem_No);
}
