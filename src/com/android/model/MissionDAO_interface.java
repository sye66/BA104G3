package com.android.model;

import java.util.List;

public interface MissionDAO_interface {
	public void insert(MissionVO missionVO);
	public void update(MissionVO missionVO);
	public void delete(String mission_No);
	public MissionVO findByPrimaryKey(String mission_NO);
	public List<MissionVO> getAll();
	public List<MissionVO> getByIssuerMem(String issuer_Mem_No);
	public List<MissionVO> getByTakecaseMem(String takecase_Mem_No);
	public List<MissionVO> getMissionByKeyword(String keyword , String keyvalue);
//	public void insert_case_candidate(String case_Candidate_No, String mission_No);
//public list<MissionVO> getAll(Map<String, String[]> map);

}