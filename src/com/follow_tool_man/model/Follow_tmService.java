package com.follow_tool_man.model;

import java.util.List;

import com.stored_history.model.StoredVO;

public class Follow_tmService {
	
	private Follow_tmDAO_interface dao;

	public Follow_tmService() {
		dao = new Follow_tmDAO();
	}
	
	public Follow_tmVO addFollow_tmVO(String follower_Mem_No, String followed_Mem_No, Integer follow_Status){
		
		Follow_tmVO follow_tmVO = new Follow_tmVO();
		
		follow_tmVO.setFollower_Mem_No(follower_Mem_No);
		follow_tmVO.setFollowed_Mem_No(followed_Mem_No);
		follow_tmVO.setFollow_Status(follow_Status);
		
		dao.insert(follow_tmVO);
		
		return follow_tmVO;
	}
	
	
	public Follow_tmVO updateFollow_tmVO(String follower_Mem_No, String followed_Mem_No, Integer follow_Status){
		
		Follow_tmVO follow_tmVO = new Follow_tmVO();
		
		follow_tmVO.setFollower_Mem_No(follower_Mem_No);
		follow_tmVO.setFollowed_Mem_No(followed_Mem_No);
		follow_tmVO.setFollow_Status(follow_Status);
		
		dao.update(follow_tmVO);
		
		return follow_tmVO;
	}
	
	public void deleteFollow_tmVO(String follower_Mem_No, String followed_Mem_No){
		
		dao.delete(follower_Mem_No, followed_Mem_No);
	}
	
	public Follow_tmVO getOneFollow_tmVO(String follower_Mem_No, String followed_Mem_No){
		
		return dao.findByPrimaryKey(follower_Mem_No, followed_Mem_No);
				
	}
	
	public List<Follow_tmVO> getAllDependOnFollower_Mem_No(String follower_Mem_No) {
		
		Follow_tmVO follow_tmVO = new Follow_tmVO();
		follow_tmVO.setFollowed_Mem_No(follower_Mem_No);
		
		return dao.getAllDependOnFollower_Mem_No(follower_Mem_No);
	}
	
}
