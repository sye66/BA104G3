package com.artiForm.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.artiReply.model.ArtiReplyVO;

public class ArtiFormService {
	
	private ArtiFormDAO_interface dao;
	
	public ArtiFormService (){
		dao = new ArtiFormJDBCDAO();
	}
	
	public ArtiFormVO addArtiForm(String arti_No, String mem_No,String arti_Title,Integer arti_Like,String describe, java.sql.Timestamp arti_Time,
			byte[] arti_Pic, Integer arti_Cls_No, String arti_Status){
		
		ArtiFormVO artiFormVO = new ArtiFormVO();
				
		artiFormVO.setArti_No(arti_No);
		artiFormVO.setMem_No(mem_No);
		artiFormVO.setArti_Title(arti_Title);
		artiFormVO.setArti_Like(arti_Like);
		artiFormVO.setDescribe(describe);
		artiFormVO.setArti_Time(arti_Time);
		artiFormVO.setArti_Pic(arti_Pic);
		artiFormVO.setArti_Cls_No(arti_Cls_No);
		artiFormVO.setArti_Status(arti_Status);
		
		dao.insertArti(artiFormVO);
		
		return artiFormVO;
	}
	
	public ArtiFormVO updateArtiForm(String arti_No, String mem_No,String arti_Title,Integer arti_Like,String describe, java.sql.Timestamp arti_Time,
			byte[] arti_Pic, Integer arti_Cls_No, String arti_Status){
		
		ArtiFormVO artiFormVO = new ArtiFormVO();
		
		artiFormVO.setArti_No(arti_No);
		artiFormVO.setMem_No(mem_No);
		artiFormVO.setArti_Title(arti_Title);
		artiFormVO.setArti_Like(arti_Like);
		artiFormVO.setDescribe(describe);
		artiFormVO.setArti_Time(arti_Time);
		artiFormVO.setArti_Pic(arti_Pic);
		artiFormVO.setArti_Cls_No(arti_Cls_No);
		artiFormVO.setArti_Status(arti_Status);
		
		dao.updateArti(artiFormVO);
		
		return artiFormVO;
		
	}
	
	public void deleteArtiForm (String arti_No){
		dao.deleteArti(arti_No);
	}
	
	public ArtiFormVO getOneArtiForm(String arti_No){
		return dao. findByPrimaryKey(arti_No);
	}
	
	public ArtiFormVO getOneArtiSearchByTitle(String arti_Title){
		
		return dao.findArtiSearchByTitle(arti_Title);
	}
	
	public void updateArti_Like(String arti_No, Integer arti_Like, String arti_Status) {
		dao.updateArti_Like(arti_No, arti_Like, arti_Status);
	}

	public Set<ArtiFormVO> getAll(){
		return dao.getAllArti();
	}

	public Set<ArtiReplyVO> findReplyByArtiNo(String arti_No){
		return dao.findReplyByArtiNo(arti_No);
	}
	
	public Set<ArtiFormVO> getAllArti4Serach(String describe){
		return dao.getAllArti4Serach(describe);
	}
	
	public Set<ArtiFormVO> findArtiByMemNo(String mem_No){
		return dao.findArtiByMemNo(mem_No);
	}

//	public List<ArtiReplyVO> findReplyByArtiClsNo (Map<String, String[]> map){
//		return dao.findReplyByArtiClsNo(map);
//	}
}
