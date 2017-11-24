package com.artiReply.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.artiForm.model.ArtiFormVO;

public class ArtiReplyService {
	
	private ArtiReplyDAO_interface dao;
	
	public ArtiReplyService(){
		dao = new ArtiReplyDAO();
	}
	
	public ArtiReplyVO addArtiReply(String mem_No, String arti_No, String reply_Desc,  java.sql.Timestamp reply_Time, Integer arti_Cls_No){
		ArtiReplyVO artiReplyVO = new ArtiReplyVO();
		
		artiReplyVO.setMem_No(mem_No);
		artiReplyVO.setArti_No(arti_No);
		artiReplyVO.setReply_Desc(reply_Desc);
		artiReplyVO.setReply_Time(reply_Time);
		artiReplyVO.setArti_Cls_No(arti_Cls_No);
		dao.insertReply(artiReplyVO);
		
		return artiReplyVO;
	}
	
	public ArtiReplyVO newAddArtiReply(String mem_No, String arti_No,  java.sql.Timestamp reply_Time, Integer arti_Cls_No){
		ArtiReplyVO artiReplyVO = new ArtiReplyVO();
		
		artiReplyVO.setMem_No(mem_No);
		artiReplyVO.setArti_No(arti_No);
		artiReplyVO.setReply_Time(reply_Time);
		artiReplyVO.setArti_Cls_No(arti_Cls_No);
		dao.insertReply(artiReplyVO);
		
		return artiReplyVO;
	}
		
	public ArtiReplyVO updateArtiReply(String reply_No, String mem_No, String arti_No, String reply_Desc, java.sql.Timestamp reply_Time, Integer arti_Cls_No){
		ArtiReplyVO artiReplyVO = new ArtiReplyVO();
		System.out.println("============================================="+reply_No);
		artiReplyVO.setReply_No(reply_No);
		artiReplyVO.setMem_No(mem_No);
		artiReplyVO.setArti_No(arti_No);
		artiReplyVO.setReply_Desc(reply_Desc);
		artiReplyVO.setReply_Time(reply_Time);
		artiReplyVO.setArti_Cls_No(arti_Cls_No);
		dao.updateReply(artiReplyVO);
		
		return artiReplyVO;
	}
	
	public ArtiReplyVO updateArtiReplyFMSet(String reply_No){
		ArtiReplyVO artiReplyVO = new ArtiReplyVO();
		artiReplyVO.setReply_No(reply_No);
		dao.updateReply(artiReplyVO);
		
		return artiReplyVO;
	}
	
	public void deleteArtiReply(String reply_No, String mem_No){
		dao.deleteReply(reply_No, mem_No);
	}
	
	public ArtiReplyVO getOneArtiReply(String reply_No){
		return dao.findByPrimaryKey(reply_No);
	}

	public Set<ArtiReplyVO> getAllReply(){
		return dao.getAllReply();
	}
	
	public Set<ArtiReplyVO> findReplyByArtiNo(String arti_No){
		return dao.findReplyByArtiNo(arti_No);
	}
	
	public Set<ArtiReplyVO> findReplyByArtiClsNo(Integer arti_Cls_No){
		return dao.findReplyByArtiClsNo(arti_Cls_No);
	}

}
