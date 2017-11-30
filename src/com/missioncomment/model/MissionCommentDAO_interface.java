package com.missioncomment.model;

import java.util.List;

public interface MissionCommentDAO_interface {
	public void insert(MissionCommentVO missionCommentVO);
	public void update(MissionCommentVO missionCommentVO);
	public void delete(String reviewer,String listener,String mission_No);
	public MissionCommentVO findByPrimaryKey(String reviewer, String listener, String mission_No);
	public List<MissionCommentVO> getAll();
	public List<MissionCommentVO> getByReviewer(String reviewer);
	public List<MissionCommentVO> getByListener(String listener);
	public List<MissionCommentVO> getByMission(String mission_No);
}
