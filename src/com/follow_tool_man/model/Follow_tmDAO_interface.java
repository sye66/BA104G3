package com.follow_tool_man.model;

import java.util.List;

public interface Follow_tmDAO_interface {
	
		public void insert(Follow_tmVO follow_tmVO);
		public void update(Follow_tmVO follow_tmVO);
		public void delete(String follower_Mem_No, String followed_Mem_No);
		public Follow_tmVO findByPrimaryKey(String follower_Mem_No, String followed_Mem_No);
		public List<Follow_tmVO> getAllDependOnFollower_Mem_No(String follower_Mem_No);
		

	}

