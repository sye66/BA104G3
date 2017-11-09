package com.disputecase.model;

import java.sql.Timestamp;

public class DisputeCaseVO {
	String dispute_case_no;
	String mission_no;
	String dispute_mem_no;
	String emp_no;
	Timestamp issue_datetime;
	Timestamp close_datetime;
	Integer dispute_case_status;
	public String getDispute_case_no() {
		return dispute_case_no;
	}
	public void setDispute_case_no(String dispute_case_no) {
		this.dispute_case_no = dispute_case_no;
	}
	public String getMission_no() {
		return mission_no;
	}
	public void setMission_no(String mission_no) {
		this.mission_no = mission_no;
	}
	public String getDispute_mem_no() {
		return dispute_mem_no;
	}
	public void setDispute_mem_no(String dispute_mem_no) {
		this.dispute_mem_no = dispute_mem_no;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public Timestamp getIssue_datetime() {
		return issue_datetime;
	}
	public void setIssue_datetime(Timestamp issue_datetime) {
		this.issue_datetime = issue_datetime;
	}
	public Timestamp getClose_datetime() {
		return close_datetime;
	}
	public void setClose_datetime(Timestamp close_datetime) {
		this.close_datetime = close_datetime;
	}
	public Integer getDispute_case_status() {
		return dispute_case_status;
	}
	public void setDispute_case_status(Integer dispute_case_status) {
		this.dispute_case_status = dispute_case_status;
	}
}
