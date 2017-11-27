package com.protrack.model;

import java.sql.Date;
import java.util.List;

import com.pro.model.ProVO;

public class ProTrackService {
	private ProTrackDAO_interface dao;
	public ProTrackService(){
		dao = new ProTrackDAO();
	}
	public ProTrackVO addProTrack(String mem_No,String pro_No){
		ProTrackVO proTrackVO = new ProTrackVO();
		proTrackVO.setMem_No(mem_No);
		proTrackVO.setPro_No(pro_No);
		dao.insert(proTrackVO);
		return proTrackVO;
	}
	
	
	public List<ProTrackVO> getAll() {
		return dao.getAll();

	}
	public List<ProTrackVO> getOnePro(String mem_No){
		return dao.findByPrimaryKey(mem_No);
	}
	
	public void deleteProTrack(String mem_No,String pro_No){
		dao.delete(mem_No,pro_No);
	}
	
	
	
}
