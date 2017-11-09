package com.achieve.model;

import java.util.List;

public class AchieveService {
	private AchieveDAO_interface dao;
	
	public AchieveService(){
		dao = new AchieveDAO();
	}
	
	public AchieveVO addAchieve(String ach_Name, byte[] ach_Picture, String ach_Explain){
		
		AchieveVO achieveVO = new AchieveVO();
		
		achieveVO.setAch_Name(ach_Name);
		achieveVO.setAch_Picture(ach_Picture);
		achieveVO.setAch_Explain(ach_Explain);
		dao.insert(achieveVO);
		return achieveVO;
		
	}
	
	public AchieveVO updateAchieve(String ach_No, String ach_Name, byte[] ach_Picture, String ach_Explain){
		AchieveVO achieveVO = new AchieveVO();
		
		achieveVO.setAch_No(ach_No);
		achieveVO.setAch_Name(ach_Name);
		achieveVO.setAch_Picture(ach_Picture);
		achieveVO.setAch_Explain(ach_Explain);
		
		 System.out.println("99998842222");
		dao.update(achieveVO);
		return achieveVO;
		
	}
	
	public AchieveVO getOneAchieve(String ach_No){
		return dao.findByPrimaryKey(ach_No);
	}
	
	public List<AchieveVO> getAll(){
		return dao.getAll();
	}
	
	public void deleteAchieve(String ach_No) {
		dao.delete(ach_No);
	}
}
