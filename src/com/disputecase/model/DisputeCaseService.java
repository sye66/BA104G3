package com.disputecase.model;

import java.sql.Timestamp;
import java.util.List;


public class DisputeCaseService {
	private DisputeCaseDAO_interface dao;
	
	public DisputeCaseService() {
		dao = new DisputeCaseDAO();
	}
	public DisputeCaseVO addDisputeCase(
			String dispute_case_no,String mission_no,String dispute_mem_no,String emp_no,
			Timestamp issue_datetime,Timestamp close_datetime,Integer dispute_case_status) {
		
		DisputeCaseVO disputeCaseVO = new DisputeCaseVO();
		disputeCaseVO.setDispute_case_no(dispute_case_no);
		disputeCaseVO.setMission_no(mission_no);
		disputeCaseVO.setDispute_mem_no(dispute_mem_no);
		disputeCaseVO.setEmp_no(emp_no);
		disputeCaseVO.setIssue_datetime(issue_datetime);
		disputeCaseVO.setClose_datetime(close_datetime);
		disputeCaseVO.setDispute_case_status(dispute_case_status);		
		dao.insert(disputeCaseVO);
		return disputeCaseVO;
	}
	public void deleteDisputeCase(String dispute_case_no) {
		dao.delete(dispute_case_no);
	}
	public DisputeCaseVO updateDisputeCase(
			String dispute_case_no,String mission_no,String dispute_mem_no,String emp_no,
			Timestamp issue_datetime,Timestamp close_datetime,Integer dispute_case_status) {
		DisputeCaseVO disputeCaseVO = new DisputeCaseVO();
		disputeCaseVO.setDispute_case_no(dispute_case_no);
		disputeCaseVO.setMission_no(mission_no);
		disputeCaseVO.setDispute_mem_no(dispute_mem_no);
		disputeCaseVO.setEmp_no(emp_no);
		disputeCaseVO.setIssue_datetime(issue_datetime);
		disputeCaseVO.setClose_datetime(close_datetime);
		disputeCaseVO.setDispute_case_status(dispute_case_status);	
		dao.update(disputeCaseVO);
		return disputeCaseVO;
	}
	public DisputeCaseVO getOneDisputeCase(String dispute_case_no) {
		return dao.findByprimaryKey(dispute_case_no);
	}
	public List<DisputeCaseVO> getAllDisputeCase(){
		return dao.getAll();
	}
	
	
}
