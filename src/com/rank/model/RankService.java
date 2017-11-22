package com.rank.model;

import java.util.List;

import com.rank.model.RankVO;

public class RankService {
	private RankDAO_interface dao;
	
	public RankService(){
		dao = new RankDAO();
	}
	
	public RankVO addRank(String day_Number_Rank,String day_Score_Rank,String week_Number_Rank,String month_Number_Rank, String season_Number_Rank,String week_Score_Rank,String month_Score_Rank, String season_Score_Rank){
		
		RankVO rankVO = new RankVO();
		
		rankVO.setDay_Number_Rank(day_Number_Rank);
		rankVO.setDay_Score_Rank(day_Score_Rank);
		rankVO.setWeek_Number_Rank(week_Number_Rank);
		rankVO.setMonth_Number_Rank(month_Number_Rank);
		rankVO.setSeason_Number_Rank(season_Number_Rank);
		rankVO.setWeek_Score_Rank(week_Score_Rank);
		rankVO.setMonth_Score_Rank(month_Score_Rank);
		rankVO.setSeason_Score_Rank(season_Score_Rank);
		return rankVO;
	}
	
	public void addRank(RankVO rankVO){
		dao.insert(rankVO);
	}
	
	public RankVO getOneRank(String mem_No){
		return dao.findByPrimaryKey(mem_No);
	}
	
	public List<RankVO> getAll() {
		return dao.getAll();
	}
	
	public void deleteRank(String mem_No) {
		dao.delete(mem_No);
	}
	
	public List<RankVO> getWNRank(){
		return dao.getWNRank();
	}
	
	public List<RankVO> getMNRank(){
		return dao.getMNRank();
	}
	
	public List<RankVO> getSNRank(){
		return dao.getSNRank();
	}
	
	public List<RankVO> getWCRank(){
		return dao.getWCRank();
	}
	
	public List<RankVO> getMCRank(){
		return dao.getMCRank();
	}
	
	public List<RankVO> getSCRank(){
		return dao.getSCRank();
	}
}
