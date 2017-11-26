package com.mem.model;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.Date;
import java.util.List;

import javax.mail.search.IntegerComparisonTerm;

public class MemService {

	private MemDAO_interface dao;

	public MemService() {
		dao = new MemDAO();
	}

	public MemVO loginMem(String mem_Email) {

		return dao.loginMem(mem_Email);
	}
	
//	public MemVO findByMemId(String mem_Id) {
//		
//		return dao.findByMemId(mem_Id);
//	}
	

	public MemVO recharge(MemVO memVO) {

		dao.recharge(memVO);

		return memVO;
	}
	
	public MemVO updateByEmp(MemVO memVO){

		dao.updateByEmp(memVO);

		return memVO;
	}
	
	public MemVO updatePw(MemVO memVO) {
		
		dao.updatePw(memVO);

		return memVO;
	}

	public MemVO addMem(String mem_Pw, String mem_Name, String mem_Id, Date mem_Bday, String mem_Tel, String mem_Pho,
			Integer mem_Gend, String mem_Email, byte[] mem_Pic, String mem_Intro, Integer mem_Code, Integer mem_State,
			Double mem_Gps_Lat, Double mem_Gps_Lng, String mem_Ip, Date mem_Date, Integer mission_Count,
			String mem_Address, Integer mem_Search, Integer mem_Point) {

		MemVO memVO = new MemVO();

		memVO.setMem_Pw(mem_Pw);
		memVO.setMem_Name(mem_Name);
		memVO.setMem_Id(mem_Id);
		memVO.setMem_Bday(mem_Bday);
		memVO.setMem_Tel(mem_Tel);
		memVO.setMem_Pho(mem_Pho);
		memVO.setMem_Gend(mem_Gend);
		memVO.setMem_Email(mem_Email);
		memVO.setMem_Pic(mem_Pic);
		memVO.setMem_Intro(mem_Intro);
		memVO.setMem_Code(mem_Code);
		memVO.setMem_State(mem_State);
		memVO.setMem_Gps_Lat(mem_Gps_Lat);
		memVO.setMem_Gps_Lng(mem_Gps_Lng);
		memVO.setMem_Ip(mem_Ip);
		memVO.setMem_Date(mem_Date);
		memVO.setMission_Count(mission_Count);
		memVO.setMem_Address(mem_Address);
		memVO.setMem_Search(mem_Search);
		memVO.setMem_Point(mem_Point);
		dao.insert(memVO);

		return memVO;
	}

	public MemVO registerMem(String mem_Pw, String mem_Name, String mem_Id, Date mem_Bday, String mem_Tel,
			String mem_Pho, Integer mem_Gend, String mem_Email, byte[] mem_Pic, String mem_Intro, Integer mem_State,
			String mem_Ip, Date mem_Date, String mem_Address, Integer mem_Search, Integer mem_Code) {

		MemVO memVO = new MemVO();

		memVO.setMem_Pw(mem_Pw);
		memVO.setMem_Name(mem_Name);
		memVO.setMem_Id(mem_Id);
		memVO.setMem_Bday(mem_Bday);
		memVO.setMem_Tel(mem_Tel);
		memVO.setMem_Pho(mem_Pho);
		memVO.setMem_Gend(mem_Gend);
		memVO.setMem_Email(mem_Email);
		memVO.setMem_Pic(mem_Pic);
		memVO.setMem_Intro(mem_Intro);
		memVO.setMem_Code(mem_Code);
		memVO.setMem_State(mem_State);
		// memVO.setMem_Gps_Lat(mem_Gps_Lat);
		// memVO.setMem_Gps_Lng(mem_Gps_Lng);
		memVO.setMem_Ip(mem_Ip);
		memVO.setMem_Date(mem_Date);
		// memVO.setMission_Count(mission_Count);
		memVO.setMem_Address(mem_Address);
		memVO.setMem_Search(mem_Search);
		// memVO.setMem_Point(mem_Point);

		dao.register(memVO);

		return memVO;

	}

	public MemVO updateByMem(String mem_No, String mem_Pw, String mem_Name, String mem_Id, Date mem_Bday,
			String mem_Tel, String mem_Pho, Integer mem_Gend, String mem_Email, byte[] mem_Pic, String mem_Intro,
			String mem_Address, Integer mem_Search ,Integer mem_State) {

		MemVO memVO = new MemVO();

		memVO.setMem_No(mem_No);
		memVO.setMem_Pw(mem_Pw);
		memVO.setMem_Name(mem_Name);
		memVO.setMem_Id(mem_Id);
		memVO.setMem_Bday(mem_Bday);
		memVO.setMem_Tel(mem_Tel);
		memVO.setMem_Pho(mem_Pho);
		memVO.setMem_Gend(mem_Gend);
		memVO.setMem_Email(mem_Email);
		memVO.setMem_Pic(mem_Pic);
		memVO.setMem_Intro(mem_Intro);
		memVO.setMem_Address(mem_Address);
		memVO.setMem_Search(mem_Search);
		memVO.setMem_State(mem_State);

		dao.updateByMem(memVO);

		return memVO;

	}
	
	
	
	
	

	public MemVO updateMem(String mem_No, String mem_Pw, String mem_Name, String mem_Id, Date mem_Bday, String mem_Tel,
			String mem_Pho, Integer mem_Gend, String mem_Email, byte[] mem_Pic, String mem_Intro, Integer mem_Code,
			Integer mem_State, Double mem_Gps_Lat, Double mem_Gps_Lng, String mem_Ip, Date mem_Date,
			Integer mission_Count, String mem_Address, Integer mem_Search, Integer mem_Point) {

		MemVO memVO = new MemVO();

		memVO.setMem_No(mem_No);
		memVO.setMem_Pw(mem_Pw);
		memVO.setMem_Name(mem_Name);
		memVO.setMem_Id(mem_Id);
		memVO.setMem_Bday(mem_Bday);
		memVO.setMem_Tel(mem_Tel);
		memVO.setMem_Pho(mem_Pho);
		memVO.setMem_Gend(mem_Gend);
		memVO.setMem_Email(mem_Email);
		memVO.setMem_Pic(mem_Pic);
		memVO.setMem_Intro(mem_Intro);
		memVO.setMem_Code(mem_Code);
		memVO.setMem_State(mem_State);
		memVO.setMem_Gps_Lat(mem_Gps_Lat);
		memVO.setMem_Gps_Lng(mem_Gps_Lng);
		memVO.setMem_Ip(mem_Ip);
		memVO.setMem_Date(mem_Date);
		memVO.setMission_Count(mission_Count);
		memVO.setMem_Address(mem_Address);
		memVO.setMem_Search(mem_Search);
		memVO.setMem_Point(mem_Point);

		dao.update(memVO);

		return memVO;
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
	
	public List<MemVO> getAllForFriend(String mem_No){
		return dao.getAllForFriend(mem_No);
	}
	

	public MemVO memAuthentication(MemVO memVO) {

		// 可以更新資料，順便回傳需要的資料

		System.out.println("----------------memV1 :" + memVO.getMem_No());
		System.out.println("----------------memV1 :" + memVO.getMem_Email());
		System.out.println("----------------memV1 :" + memVO.getMem_Date());
		System.out.println("----------------memV1 :" + memVO.getMem_Id());

		MemVO memVO1 = dao.Authentication(memVO);

		System.out.println("----------------memVO2 :" + memVO1.getMem_No());
		System.out.println("----------------memVO2 :" + memVO1.getMem_Email());
		System.out.println("----------------memVO2 :" + memVO1.getMem_Date());
		System.out.println("----------------memVO2 :" + memVO1.getMem_Id());

		return memVO1;

	}

	public MemVO updateMemPoint(String mem_No, Integer mem_Point) {

		MemVO memVO = new MemVO();

		memVO.setMem_No(mem_No);
		memVO.setMem_Point(mem_Point);

		dao.updateMemPoint(memVO);

		return memVO;
	}
	
	/**
	 * @author Sander
	 * @param mem_No
	 * @param mem_Point
	 * @return
	 * 增加會員積分
	 */
	public MemVO IncreaseMemPoint(String mem_No, Integer mem_Point) {

		MemVO memVO = dao.findByPrimaryKey(mem_No);
		// 抓出原本積分
		Integer origin_Mem_Point = memVO.getMem_Point();
		// 加入得到積分
		Integer got_Paid_Mem_point = origin_Mem_Point + mem_Point; 
		memVO.setMem_Point(got_Paid_Mem_point);
		dao.updateMemPoint(memVO);
		System.out.printf("會員: %s,原積分: %d, 加總後積分: %d\n",mem_No,origin_Mem_Point,got_Paid_Mem_point);

		return memVO;
	}
	/**
	 * @author Sander
	 * @param mem_No
	 * @param mem_Point
	 * @return
	 * 增加會員積分
	 */
	public MemVO DecreaseMemPoint(String mem_No, Integer mem_Point) {

		MemVO memVO = dao.findByPrimaryKey(mem_No);
		// 抓出原本積分
		Integer origin_Mem_Point = memVO.getMem_Point();
		// 加入得到積分
		Integer got_Paid_Mem_point = origin_Mem_Point - mem_Point; 
		memVO.setMem_Point(got_Paid_Mem_point);
		dao.updateMemPoint(memVO);
		System.out.printf("會員: %s,原積分: %d, 扣分後積分: %d\n",mem_No,origin_Mem_Point,got_Paid_Mem_point);

		return memVO;
	}

}
