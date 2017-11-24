package com.ad.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.artiForm.model.ArtiFormVO;
import com.artiReply.model.ArtiReplyVO;

public class AdService {
	
	private AdDAO_interface dao;
	
	public AdService(){
		dao = new AdDAO();
	}
	
	public AdVO addAd(String ad_No, byte[] ad_Pic, String ad_Desc, Timestamp ad_Start, Timestamp ad_End, String ad_Fty_No, String ad_Fty_Name){
		AdVO adVO = new AdVO();
		
		adVO.setAd_No(ad_No);
		adVO.setAd_Pic(ad_Pic);
		adVO.setAd_Desc(ad_Desc);
		adVO.setAd_Start(ad_Start);
		adVO.setAd_End(ad_End);
		adVO.setAd_Fty_No(ad_Fty_No);
		adVO.setAd_Fty_Name(ad_Fty_Name);
		dao.insertAd(adVO);
		
		return adVO;
	}
	
	public AdVO updateAd(String ad_No, byte[] ad_Pic, String ad_Desc, Timestamp ad_Start, Timestamp ad_End, String ad_Fty_No, String ad_Fty_Name){
		AdVO adVO = new AdVO();
		
		adVO.setAd_No(ad_No);
		adVO.setAd_Pic(ad_Pic);
		adVO.setAd_Desc(ad_Desc);
		adVO.setAd_Start(ad_Start);
		adVO.setAd_End(ad_End);
		adVO.setAd_Fty_No(ad_Fty_No);
		adVO.setAd_Fty_Name(ad_Fty_Name);
		dao.insertAd(adVO);
		
		return adVO;
		
	}
	
	public void deleteAd(String ad_No){
		dao.deleteAd(ad_No);
	}
	
	public AdVO getOneAd(String ad_No){
		return dao.findByPrimaryKey(ad_No);
	}
	
	
	public Set<AdVO> getAllAd(){
		return dao.getAllAd();
	}
	
	public List<AdVO> getAllAD(Map<String, String[]> map) {
		return dao.getAllAD(map);
	}
	
	public Set<AdVO> findAdByFtyNo(String ad_Fty_No){
		return dao.findAdByFtyNo(ad_Fty_No);
	}
	
}
