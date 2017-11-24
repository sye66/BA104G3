package com.android.model;

import java.util.List;

public interface Follow_tmDAO_interface {
	
		public void insert(Follow_tmVO follow_tmVO);
		public void update(Follow_tmVO follow_tmVO);
		public void delete(String follower_mem_no, String followed_mem_no);
		public Follow_tmVO findByPrimaryKey(String follower_mem_no, String followed_mem_no);
		public List<Follow_tmVO> getAllDependOnFollower_mem_no(String follower_mem_no);
		

	}

