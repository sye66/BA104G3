package com.mem.model;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.Date;
import java.util.List;

public class MemService {

	private MemDAO_interface dao;
	
	public MemService(){
		dao = new MemDAO();
	}
	
	public MemVO loginMem(String mem_email){
		
		return dao.loginMem(mem_email);
	}
	
	public MemVO addMem(String mem_pw, String mem_name, String mem_id, Date mem_bday,
			String mem_tel, String mem_pho, Integer mem_gend, String mem_email,
			byte[] mem_pic, String mem_intro, Integer mem_code, Integer mem_state,
			Double mem_gps_lat, Double mem_gps_lng, String mem_ip, Date mem_date,
			Integer mission_count, String mem_address, Integer mem_search, Integer mem_point){
		
		MemVO memVO = new MemVO();
		
		
		
		memVO.setMem_pw(mem_pw);
		memVO.setMem_name(mem_name);
		memVO.setMem_id(mem_id);
		memVO.setMem_bday(mem_bday);
		memVO.setMem_tel(mem_tel);
		memVO.setMem_pho(mem_pho);
		memVO.setMem_gend(mem_gend);
		memVO.setMem_email(mem_email);
		memVO.setMem_pic(mem_pic);
		memVO.setMem_intro(mem_intro);
		memVO.setMem_code(mem_code);
		memVO.setMem_state(mem_state);
		memVO.setMem_gps_lat(mem_gps_lat);
		memVO.setMem_gps_lng(mem_gps_lng);
		memVO.setMem_ip(mem_ip);
		memVO.setMem_date(mem_date);
		memVO.setMission_count(mission_count);
		memVO.setMem_address(mem_address);
		memVO.setMem_search(mem_search);
		memVO.setMem_point(mem_point);
		dao.insert(memVO);
		
		return memVO;
	}
	
	public MemVO updateMem(String mem_no ,String mem_pw, String mem_name, String mem_id, Date mem_bday,
			String mem_tel, String mem_pho, Integer mem_gend, String mem_email,
			byte[] mem_pic, String mem_intro, Integer mem_code, Integer mem_state,
			Double mem_gps_lat, Double mem_gps_lng, String mem_ip, Date mem_date,
			Integer mission_count, String mem_address, Integer mem_search, Integer mem_point){
		
		MemVO memVO = new MemVO();
		
		
		
		memVO.setMem_no(mem_no);
		memVO.setMem_pw(mem_pw);
		memVO.setMem_name(mem_name);
		memVO.setMem_id(mem_id);
		memVO.setMem_bday(mem_bday);
		memVO.setMem_tel(mem_tel);
		memVO.setMem_pho(mem_pho);
		memVO.setMem_gend(mem_gend);
		memVO.setMem_email(mem_email);
		memVO.setMem_pic(mem_pic);
		memVO.setMem_intro(mem_intro);
		memVO.setMem_code(mem_code);
		memVO.setMem_state(mem_state);
		memVO.setMem_gps_lat(mem_gps_lat);
		memVO.setMem_gps_lng(mem_gps_lng);
		memVO.setMem_ip(mem_ip);
		memVO.setMem_date(mem_date);
		memVO.setMission_count(mission_count);
		memVO.setMem_address(mem_address);
		memVO.setMem_search(mem_search);
		memVO.setMem_point(mem_point);

		dao.update(memVO);
		
		return memVO;
	}
	
	public void deleteMem(String mem_no){
		dao.delete(mem_no);
	}
	
	public MemVO getOneMem(String mem_no){
		return dao.findByPrimaryKey(mem_no);
	}
	
	public List<MemVO> getAll(){
		return dao.getAll();
	}
}
