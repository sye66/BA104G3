package com.artiForm.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.artiReply.model.ArtiReplyVO;

public interface ArtiFormDAO_interface {
	public void insertArti (ArtiFormVO artiFormVO);
	public void updateArti (ArtiFormVO artiFormVO);
	public void deleteArti (String arti_No);
	public ArtiFormVO findByPrimaryKey(String arti_No);
	public ArtiFormVO findArtiSearchByTitle(String arti_Title);
	public Set<ArtiFormVO> getAllArti();
	public Set<ArtiReplyVO> findReplyByArtiNo(String arti_No);
	public Set<ArtiFormVO> getAllArti4Serach(String describe);
	public Set<ArtiFormVO> findArtiByMemNo(String mem_No);

}
