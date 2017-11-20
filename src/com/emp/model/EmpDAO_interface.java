package com.emp.model;

import java.util.List;
import java.util.Set;

public interface EmpDAO_interface {
	 public void insert(EmpVO empVO);
     public void update(EmpVO empVO);
     public void delete(String emp_No);
     public EmpVO findByPrimaryKey(String emp_No);
     public List<EmpVO> getAll();
     //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//   public List<EmpVO> getAll(Map<String, String[]> map);
     public List<EmpVO> getEmp_No();
	
}
