package com.android.model;

import java.util.List;

public interface Case_CandidateDAO_interface {
	public void insertCaseCandidate(Case_CandidateVO case_CandidateVO);
	public void deleteCaseCandidate(Case_CandidateVO case_CandidateVO);
	public List<String> getAllMissionNoByCandidateMemNo(String candidate_No);
	public void deleteByMissionNo(String mission_No);
	public List<String> getAllCandidateMemNoByMissionNo(String mission_No);
}
