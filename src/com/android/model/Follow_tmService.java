package com.android.model;

import java.util.List;


public class Follow_tmService {
	
	private Follow_tmDAO_interface dao;

	public Follow_tmService() {
		dao = new Follow_tmDAO();
	}
	
	public Follow_tmVO addFollow_tmVO(String follower_mem_no, String followed_mem_no, Integer follow_status){
		
		Follow_tmVO follow_tmVO = new Follow_tmVO();
		
		follow_tmVO.setFollower_mem_no(follower_mem_no);
		follow_tmVO.setFollowed_mem_no(followed_mem_no);
		follow_tmVO.setFollow_status(follow_status);
		
		dao.insert(follow_tmVO);
		
		return follow_tmVO;
	}
	
	
	public Follow_tmVO updateFollow_tmVO(String follower_mem_no, String followed_mem_no, Integer follow_status){
		
		Follow_tmVO follow_tmVO = new Follow_tmVO();
		
		follow_tmVO.setFollower_mem_no(follower_mem_no);
		follow_tmVO.setFollowed_mem_no(followed_mem_no);
		follow_tmVO.setFollow_status(follow_status);
		
		dao.update(follow_tmVO);
		
		return follow_tmVO;
	}
	
	public void deleteFollow_tmVO(String follower_mem_no, String followed_mem_no){
		
		dao.delete(follower_mem_no, followed_mem_no);
	}
	
	public Follow_tmVO getOneFollow_tmVO(String follower_mem_no, String followed_mem_no){
		
		return dao.findByPrimaryKey(follower_mem_no, followed_mem_no);
				
	}
	
	public List<Follow_tmVO> getAllDependOnFollower_mem_no(String follower_mem_no) {
		
		return dao.getAllDependOnFollower_mem_no(follower_mem_no);
	}
	
}
