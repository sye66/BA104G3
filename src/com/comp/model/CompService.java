package com.comp.model;

import java.util.List;

import com.comp.model.CompVO;



public class CompService {
	private CompDAO_interface dao;
	
	public CompService(){
		dao = new CompDAO();
	}
	
	public CompVO addEmpComp(String emp_No, String auth_No) {

		CompVO compVO = new CompVO();

		compVO.setEmp_No(emp_No);
		compVO.setAuth_No(auth_No);	
		dao.insert(compVO);

		return compVO;
	}
	
	public CompVO updateEmp(String emp_No, String auth_No) {

		CompVO compVO = new CompVO();

		compVO.setEmp_No(emp_No);
		compVO.setAuth_No(auth_No);
		dao.update(compVO);

		return compVO;
	}
	
	public CompVO getOneComp(String emp_No) {
		return dao.findByPrimaryKey(emp_No);
	}

	public List<CompVO> getAll() {
		return dao.getAll();
	}
	
	public List<CompVO> getAllAuthNo(String emp_No){
		return dao.findByPk(emp_No);
	}
}
