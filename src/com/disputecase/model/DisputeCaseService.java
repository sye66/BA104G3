package com.disputecase.model;

import java.sql.Timestamp;
import java.util.List;


public class DisputeCaseService {
	private DisputeCaseDAO_interface dao;
	
	// Constructor
	public DisputeCaseService() {
		dao = new DisputeCaseDAO();
	}

	public DisputeCaseVO addDisputeCase(
			String dispute_Case_No,String mission_No,String dispute_Mem_No,String emp_No,
			Timestamp issue_datetime,Timestamp close_Datetime,Integer dispute_Case_Status, String dispute_Content, byte[] dispute_Attachment, String dispute_Reply) {
		
		DisputeCaseVO disputeCaseVO = new DisputeCaseVO();
		disputeCaseVO.setDispute_Case_No(dispute_Case_No);
		disputeCaseVO.setMission_No(mission_No);
		disputeCaseVO.setDispute_Mem_No(dispute_Mem_No);
		disputeCaseVO.setEmp_No(emp_No);
		disputeCaseVO.setIssue_Datetime(issue_datetime);
		disputeCaseVO.setClose_Datetime(close_Datetime);
		disputeCaseVO.setDispute_Case_Status(dispute_Case_Status);
		disputeCaseVO.setDispute_Content(dispute_Content);
		disputeCaseVO.setDispute_Content(dispute_Content);
		disputeCaseVO.setDispute_Attachment(dispute_Attachment);
		disputeCaseVO.setDispute_Reply(dispute_Reply);
		dao.insert(disputeCaseVO);
		System.out.println("DISPUTEDAO_SERVICE新增成功");
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
	public DisputeCaseVO replyDisputeCase(String dispute_Case_No, Timestamp close_Datetime, Integer dispute_Case_Status, String dispute_Reply) {
		DisputeCaseVO disputeCaseVO = dao.findByprimaryKey(dispute_Case_No);
		disputeCaseVO.setClose_Datetime(close_Datetime);
		disputeCaseVO.setDispute_Case_Status(dispute_Case_Status);
		disputeCaseVO.setDispute_Content(dispute_Reply);
		dao.update(disputeCaseVO);
		System.out.println("Service更新送出");
		return disputeCaseVO;
	}
	public DisputeCaseVO getOneDisputeCase(String dispute_Case_No) {
		return dao.findByprimaryKey(dispute_Case_No);
	}
	public List<DisputeCaseVO> getAllDisputeCase(){
		return dao.getAll();
	}
	public List<DisputeCaseVO> getDisputeCaseByMem(String mem_No){
		return dao.findByMem(mem_No);
	}
	public List<DisputeCaseVO> getDisputeCaseByStatus(Integer dispute_Case_Status){
		return dao.findByStatus(dispute_Case_Status);
	}
	public List<DisputeCaseVO> getDisputeCaseByStatus(Integer dispute_Case_Status, String emp_No){
		return dao.findByStatus(dispute_Case_Status, emp_No);
	}
}
