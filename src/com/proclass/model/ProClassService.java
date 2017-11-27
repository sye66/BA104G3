package com.proclass.model;

import java.util.List;
import java.util.Set;

import com.pro.model.ProVO;


public class ProClassService {
	private ProClassDAO_interface dao;
	public ProClassService(){
		dao = new ProClassDAO();
	}
	
	public ProClassVO addProClass(String pro_Class_Name){
		ProClassVO proClassVO = new ProClassVO();
		proClassVO.setPro_Class_Name(pro_Class_Name);
		dao.insert(proClassVO);
		return proClassVO;
	}
	
	public ProClassVO updateProClass(String pro_Class_No , String pro_Class_Name){
		ProClassVO proClassVO = new ProClassVO();
		proClassVO.setPro_Class_No(pro_Class_No);
		proClassVO.setPro_Class_Name(pro_Class_Name);
		dao.insert(proClassVO);
		return proClassVO;
	}
	
	public List<ProClassVO> getAll() {
		return dao.getAll();

	}
	public ProClassVO getOneClass(String pro_Class_No){
		return dao.findByPrimaryKey(pro_Class_No);
	}
	
	public void deleteProClass(String pro_Class_No){
		dao.delete(pro_Class_No);
	}
	public Set<ProVO> getOneClassPro(String pro_Class_No) {
		return dao.getOneClassPro(pro_Class_No);

	}
}
