package com.artiReply.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.artiForm.model.ArtiFormVO;

public interface ArtiReplyDAO_interface {
	public void insertReply (ArtiReplyVO artiReplyVO);
	public void updateReply (ArtiReplyVO artiReplyVO);
	public void updateArtiReplyFMSet (ArtiReplyVO artiReplyVO);
	
	public void deleteReply (String reply_No, String mem_No);
	
	public ArtiReplyVO findByPrimaryKey (String reply_No);
	public Set<ArtiReplyVO> getAllReply();
	public Set<ArtiReplyVO> findReplyByArtiNo(String arti_No);
	public Set<ArtiReplyVO> findReplyByArtiClsNo(Integer arti_Cls_No);
}
