package com.comp.model;

import java.util.List;

import com.emp.model.EmpVO;

public interface CompDAO_interface {
	public void insert(CompVO compVO);
    public void update(CompVO compVO);
    public void delete(String emp_No);
    public CompVO findByPrimaryKey(String emp_No);
    public List<CompVO> getAll();
}
