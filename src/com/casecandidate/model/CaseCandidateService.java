package com.casecandidate.model;

import java.util.List;

public class CaseCandidateService {

	private CaseCandidateDAO_interface dao;

	public CaseCandidateService() {
		dao = new CaseCandidateDAO();
	}

	public CaseCandidateVO addCaseCandidate(String candidate_Mem_No, String mission_No) {

		CaseCandidateVO caseCandidateVO = new CaseCandidateVO();

		caseCandidateVO.setCandidate_Mem_No(candidate_Mem_No);
		caseCandidateVO.setMission_No(mission_No);
		

		return caseCandidateVO;
	}

	public CaseCandidateVO updateCaseCandidate(String candidate_Mem_No, String mission_No) {

		CaseCandidateVO caseCandidateVO = new CaseCandidateVO();

		caseCandidateVO.setCandidate_Mem_No(candidate_Mem_No);
		caseCandidateVO.setMission_No(mission_No);
		dao.update(caseCandidateVO);

		return caseCandidateVO;
	}

	public void deleteCaseCandidate(String candidate_Mem_No, String mission_No) {
		dao.delete(candidate_Mem_No,  mission_No);
	}

	public CaseCandidateVO getOneCase(String candidate_Mem_No) {
		return dao.findByCandidate(candidate_Mem_No);
	}

	public CaseCandidateVO getOneCaseCandidate(String mission_No) {
		return dao.findByMission(mission_No);
	}
	
	public List<CaseCandidateVO> getAll() {
		return dao.getAll();
	}
}
