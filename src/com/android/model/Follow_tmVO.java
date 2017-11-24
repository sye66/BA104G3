package com.android.model;

public class Follow_tmVO {
	private String follower_mem_no;
	private String followed_mem_no;
	private Integer follow_status;
	
	public Follow_tmVO() {
		super();
	}

	public String getFollower_mem_no() {
		return follower_mem_no;
	}

	public void setFollower_mem_no(String follower_mem_no) {
		this.follower_mem_no = follower_mem_no;
	}

	public String getFollowed_mem_no() {
		return followed_mem_no;
	}

	public void setFollowed_mem_no(String followed_mem_no) {
		this.followed_mem_no = followed_mem_no;
	}

	public Integer getFollow_status() {
		return follow_status;
	}

	public void setFollow_status(Integer follow_status) {
		this.follow_status = follow_status;
	}
	
	
}
