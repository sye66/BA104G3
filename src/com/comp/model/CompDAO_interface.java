package com.comp.model;

import java.util.List;
import java.util.Set;

import com.emp.model.EmpVO;

public interface CompDAO_interface {
	public void insert(CompVO compVO);
    public void update(CompVO compVO);
    public void delete(CompVO compVO);
    public CompVO findByPrimaryKey(String emp_No);
    public List<CompVO> getAll();
    public Set<CompVO> findByPk(String emp_No);
}
