package com.missioncomment.model;

import java.sql.Timestamp;

public class MissionCommentVO implements java.io.Serializable{
	private String reviewer;
	private String listener;
	private String mission_No;
	private String comment_Detail;
	private Integer comment_Point;
	private Timestamp comment_Time;
	
	public String getReviewer() {
		return reviewer;
	}
	public void setReviewer(String reviewer) {
		this.reviewer = reviewer;
	}
	public String getListener() {
		return listener;
	}
	public void setListener(String listener) {
		this.listener = listener;
	}
	public String getMission_No() {
		return mission_No;
	}
	public void setMission_No(String mission_No) {
		this.mission_No = mission_No;
	}
	public String getComment_Detail() {
		return comment_Detail;
	}
	public void setComment_Detail(String comment_Detail) {
		this.comment_Detail = comment_Detail;
	}
	public Integer getComment_Point() {
		return comment_Point;
	}
	public void setComment_Point(Integer comment_Point) {
		this.comment_Point = comment_Point;
	}
	public Timestamp getComment_Time() {
		return comment_Time;
	}
	public void setComment_Time(Timestamp comment_Time) {
		this.comment_Time = comment_Time;
	}
	

}
