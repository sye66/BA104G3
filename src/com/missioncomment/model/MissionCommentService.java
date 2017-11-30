package com.missioncomment.model;

import java.sql.Timestamp;
import java.util.List;

public class MissionCommentService {
	
	private MissionCommentDAO_interface dao;
	
	public MissionCommentService() {
		dao = new MissionCommentDAO();
	}
	
	public MissionCommentVO updateMissionComment(
			String reviewer,String listener,String mission_No,
			String comment_Detail, Integer comment_Point,Timestamp comment_Time
			){
		MissionCommentVO missionCommentVO = new MissionCommentVO();
		
		missionCommentVO.setReviewer(reviewer);
		missionCommentVO.setListener(listener);
		missionCommentVO.setMission_No(mission_No);
		missionCommentVO.setComment_Detail(comment_Detail);
		missionCommentVO.setComment_Point(comment_Point);
		missionCommentVO.setComment_Time(comment_Time);
		
		dao.update(missionCommentVO);
		return missionCommentVO;
	}
	
	public MissionCommentVO addMissionComment(
			String reviewer,String listener,String mission_No,
			String comment_Detail, Integer comment_Point
			){
		MissionCommentVO missionCommentVO = new MissionCommentVO();
		
		missionCommentVO.setReviewer(reviewer);
		missionCommentVO.setListener(listener);
		missionCommentVO.setMission_No(mission_No);
		missionCommentVO.setComment_Detail(comment_Detail);
		missionCommentVO.setComment_Point(comment_Point);
		
		dao.insert(missionCommentVO);
		return missionCommentVO;
	}
	
	public void delect(String reviewer,String listener,String mission_No){
		dao.delete(reviewer, listener, mission_No);
		
	}
	
	public MissionCommentVO findByPrimaryKey(String reviewer, String listener, String mission_No){
		return dao.findByPrimaryKey(reviewer, listener, mission_No);
	}
	
	public List<MissionCommentVO> getAll(){
		return dao.getAll();
	}
	
	public List<MissionCommentVO> getByReviewer(String reviewer){
		return dao.getByReviewer(reviewer);
	}
	
	public List<MissionCommentVO> getByListener(String listener){
		return dao.getByListener(listener);
	}
	
	public List<MissionCommentVO> getByMission(String mission_No){
		return dao.getByMission(mission_No);
	}
}
