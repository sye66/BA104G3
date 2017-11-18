package com.follow_tool_man.model;

public class Follow_tmVO {
	private String follower_Mem_No;
	private String followed_Mem_No;
	private Integer follow_Status;
	
	public Follow_tmVO() {
		super();
	}

	public String getFollower_Mem_No() {
		return follower_Mem_No;
	}

	public void setFollower_Mem_No(String follower_Mem_No) {
		this.follower_Mem_No = follower_Mem_No;
	}

	public String getFollowed_Mem_No() {
		return followed_Mem_No;
	}

	public void setFollowed_Mem_No(String followed_Mem_No) {
		this.followed_Mem_No = followed_Mem_No;
	}

	public Integer getFollow_Status() {
		return follow_Status;
	}

	public void setFollow_Status(Integer follow_Status) {
		this.follow_Status = follow_Status;
	}

	
}
