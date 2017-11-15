package com.artiClass.model;

import java.util.*;

import com.artiForm.model.ArtiFormVO;

public class ArtiClassService {

	private ArtiClassDAO_interface dao;

	public ArtiClassService() {
		dao = new ArtiClassDAO();
	}

	public List<ArtiClassVO> getAll() {
		return dao.getAll();
	}

	public ArtiClassVO getOneClass(Integer arti_Cls_No) {
		return dao.findByPrimaryKey(arti_Cls_No);
	}

	public Set<ArtiFormVO> getArti_NoByArti_Cls_No(Integer arti_Cls_No) {
		return dao.getArti_NoByArti_Cls_No(arti_Cls_No);
	}

	public void deleteArti_Cls_No(Integer arti_Cls_No) {
		dao.delete(arti_Cls_No);
	}
}