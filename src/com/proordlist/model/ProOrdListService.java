package com.proordlist.model;

import java.sql.Connection;
import java.sql.Date;
import java.util.List;

import com.pro.model.ProVO;

public class ProOrdListService {
	private ProOrdListDAO_interface dao;
	public ProOrdListService(){
		dao = new ProOrdListJDBCDAO();
	}
	
	public ProOrdListVO addProOrdList(String ord_No,String pro_No,Integer ordPro_Count,Double ordPor_Price,Connection con){
		ProOrdListVO proOrdListVO = new ProOrdListVO();
		proOrdListVO.setOrd_No(ord_No);
		proOrdListVO.setPro_No(pro_No);
		proOrdListVO.setOrdPro_Count(ordPro_Count);
		proOrdListVO.setOrdPro_Price(ordPor_Price);
		dao.insert(proOrdListVO,con);
		return proOrdListVO;
		
	}

	public ProOrdListVO updateProOrdList(String ord_No,String pro_No,Integer ordPro_Count,Double ordPor_Price){
		ProOrdListVO proOrdListVO = new ProOrdListVO();
		proOrdListVO.setOrd_No(ord_No);
		proOrdListVO.setPro_No(pro_No);
		proOrdListVO.setOrdPro_Count(ordPro_Count);
		proOrdListVO.setOrdPro_Price(ordPor_Price);
		dao.update(proOrdListVO);
		return proOrdListVO;
		
	}
		
		
	public List<ProOrdListVO> getAll() {
		return dao.getAll();

	}
	public List<ProOrdListVO> getOneProOrdListVO(String ord_No){
		return dao.findByPrimaryKey(ord_No);
	}
	
	public void deletePro(String ord_No){
		dao.delete(ord_No);
	}
	
}


