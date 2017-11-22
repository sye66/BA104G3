package com.android.model;

import java.sql.Date;
import java.util.List;

import com.android.model.MemVO;

public class MemService {
	private MemDAO_interface dao;
	
	public MemService(){
		dao = new MemDAO();
	}
	
	public MemVO addMem( String mem_Pw, String mem_Name, String mem_Id, Date mem_Bday, String mem_Tel, String mem_Pho, Integer mem_Gend, String mem_Email, byte[] mem_Pic, String mem_Intro, Integer mem_Code, Integer mem_State, Double mem_Gps_Lat, Double mem_Gps_Lng, String mem_Ip, Date mem_Date, Integer mission_Count, String mem_Address, Integer mem_Search, Integer mem_Point){
		MemVO mem = new MemVO();
		mem.setMem_Pw(mem_Pw);
		mem.setMem_Name(mem_Name);
		mem.setMem_Id(mem_Id);
		mem.setMem_Bday(mem_Bday);
		mem.setMem_Tel(mem_Tel);
		mem.setMem_Pho(mem_Pho);
		mem.setMem_Gend(mem_Gend);
		mem.setMem_Email(mem_Email);
		mem.setMem_Pic(mem_Pic);
		mem.setMem_Intro(mem_Intro);
		mem.setMem_Code(mem_Code);
		mem.setMem_State(mem_State);
		mem.setMem_Gps_Lat(mem_Gps_Lat);
		mem.setMem_Gps_Lng(mem_Gps_Lng);
		mem.setMem_Ip(mem_Ip);
		mem.setMem_Date(mem_Date);
		mem.setMission_Count(mission_Count);
		mem.setMem_Address(mem_Address);
		mem.setMem_Search(mem_Search);
		mem.setMem_Point(mem_Point);

		return  mem;
		
	}
	
	public MemVO updateMem(String mem_No, String mem_Pw, String mem_Name, String mem_Id, Date mem_Bday, String mem_Tel, String mem_Pho, Integer mem_Gend, String mem_Email, byte[] mem_Pic, String mem_Intro, Integer mem_Code, Integer mem_State, Double mem_Gps_Lat, Double mem_Gps_Lng, String mem_Ip, Date mem_Date, Integer mission_Count, String mem_Address, Integer mem_Search, Integer mem_Point) {
		MemVO mem = new MemVO();
		
		mem.setMem_No(mem_No);
		mem.setMem_Pw(mem_Pw);
		mem.setMem_Name(mem_Name);
		mem.setMem_Id(mem_Id);
		mem.setMem_Bday(mem_Bday);
		mem.setMem_Tel(mem_Tel);
		mem.setMem_Pho(mem_Pho);
		mem.setMem_Gend(mem_Gend);
		mem.setMem_Email(mem_Email);
		mem.setMem_Pic(mem_Pic);
		mem.setMem_Intro(mem_Intro);
		mem.setMem_Code(mem_Code);
		mem.setMem_State(mem_State);
		mem.setMem_Gps_Lat(mem_Gps_Lat);
		mem.setMem_Gps_Lng(mem_Gps_Lng);
		mem.setMem_Ip(mem_Ip);
		mem.setMem_Date(mem_Date);
		mem.setMission_Count(mission_Count);
		mem.setMem_Address(mem_Address);
		mem.setMem_Search(mem_Search);
		mem.setMem_Point(mem_Point);
		
		return mem;
		
	}
	
	
	public void deleteMem(String mem_No) {
		dao.delete(mem_No);
	}

	public MemVO getOneMem(String mem_No) {
		return dao.findByPrimaryKey(mem_No);
	}

	public List<MemVO> getAll() {
		return dao.getAll();
	}
}
