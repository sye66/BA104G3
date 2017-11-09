package com.disputecase.model;

import java.sql.Timestamp;
import java.util.List;


public class DisputeCaseService {
	private DisputeCaseDAO_interface dao;
	
	public DisputeCaseService() {
		dao = new DisputeCaseDAO();
	}
	public DisputeCaseVO addDisputeCase(
			String dispute_Case_No,String mission_No,String dispute_Mem_No,String emp_No,
			Timestamp issue_datetime,Timestamp close_Datetime,Integer dispute_Case_Status) {
		
		DisputeCaseVO disputeCaseVO = new DisputeCaseVO();
		disputeCaseVO.setDispute_Case_No(dispute_Case_No);
		disputeCaseVO.setMission_No(mission_No);
		disputeCaseVO.setDispute_Mem_No(dispute_Mem_No);
		disputeCaseVO.setEmp_No(emp_No);
		disputeCaseVO.setIssue_Datetime(issue_datetime);
		disputeCaseVO.setClose_Datetime(close_Datetime);
		disputeCaseVO.setDispute_Case_Status(dispute_Case_Status);		
		dao.insert(disputeCaseVO);
		return disputeCaseVO;
	}
	public void deleteDisputeCase(String dispute_Case_No) {
		dao.delete(dispute_Case_No);
	}
	public DisputeCaseVO updateDisputeCase(
			String dispute_Case_No,String mission_No,String dispute_Mem_No,String emp_No,
			Timestamp issue_datetime,Timestamp close_Datetime,Integer dispute_Case_Status) {
		DisputeCaseVO disputeCaseVO = new DisputeCaseVO();
		disputeCaseVO.setDispute_Case_No(dispute_Case_No);
		disputeCaseVO.setMission_No(mission_No);
		disputeCaseVO.setDispute_Mem_No(dispute_Mem_No);
		disputeCaseVO.setEmp_No(emp_No);
		disputeCaseVO.setIssue_Datetime(issue_datetime);
		disputeCaseVO.setClose_Datetime(close_Datetime);
		disputeCaseVO.setDispute_Case_Status(dispute_Case_Status);	
		dao.update(disputeCaseVO);
		return disputeCaseVO;
	}
	public DisputeCaseVO getOneDisputeCase(String dispute_Case_No) {
		return dao.findByprimaryKey(dispute_Case_No);
	}
	public List<DisputeCaseVO> getAllDisputeCase(){
		return dao.getAll();
	}
	
	
}
