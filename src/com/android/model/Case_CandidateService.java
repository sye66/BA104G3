package com.android.model;


import java.util.List;

public class Case_CandidateService {

	private Case_CandidateDAO_interface dao;

	public Case_CandidateService() {
		dao = new Case_CandidateDAO();
	}
	
	public Case_CandidateVO insertCaseCandidate(String candidate_Mem_No, String mission_No, Integer issuer_Inviting){
		Case_CandidateVO case_CandidateVO = new Case_CandidateVO();
		case_CandidateVO.setCandidate_Mem_No(candidate_Mem_No);
		case_CandidateVO.setMission_No(mission_No);
		case_CandidateVO.setIssuer_Inviting(issuer_Inviting);
		dao.insertCaseCandidate(case_CandidateVO);
		return case_CandidateVO;
	}
	
	public Case_CandidateVO deleteCaseCandidate(String candidate_Mem_No, String mission_No){
		Case_CandidateVO case_CandidateVO = new Case_CandidateVO();
		case_CandidateVO.setCandidate_Mem_No(candidate_Mem_No);
		case_CandidateVO.setMission_No(mission_No);
		dao.deleteCaseCandidate(case_CandidateVO);
		return case_CandidateVO;
	}
	
	//
	public Case_CandidateVO deleteCaseCandidateByMissionNo(String mission_No){
		Case_CandidateVO case_CandidateVO = new Case_CandidateVO();
		case_CandidateVO.setMission_No(mission_No);
		dao.deleteByMissionNo(mission_No);
		return case_CandidateVO;
	}
	
	public List<String> getAllMissionNoByCandidateMemNo(String candidate_Mem_No) {
		return dao.getAllMissionNoByCandidateMemNo(candidate_Mem_No);
	}
	
//	public List<String> getAllMissionNoByCandidateMemNo1(String candidate_Mem_No) {
//		return dao.getAllMissionNoByCandidateMemNo1(candidate_Mem_No);
//	}
//	
//	public List<String> getAllMissionNoByCandidateMemNo2(String candidate_Mem_No) {
//		return dao.getAllMissionNoByCandidateMemNo2(candidate_Mem_No);
//	}
	
	public List<String> getAllCandidateMemNoByMissionNo(String mission_No){
		return dao.getAllCandidateMemNoByMissionNo(mission_No);
	}
}
