package com.disputecase.model;

import java.util.List;

public interface DisputeCaseDAO_interface {
	public void insert(DisputeCaseVO disputeCaseVO);
	public void delete(String dispute_case_no);
	public void update(DisputeCaseVO disputeCaseVO);
	public DisputeCaseVO findByprimaryKey(String dispute_case_no);
	public List<DisputeCaseVO> findByMem(String mem_No);
	public List<DisputeCaseVO> findByStatus(Integer dispute_Case_Status);
	public List<DisputeCaseVO> findByStatus(Integer dispute_Case_Status, String emp_No);
	public List<DisputeCaseVO> getAll();
	public Integer getCountByStatus(Integer dispute_Case_Status);
}
