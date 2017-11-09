package com.disputecase.model;

import java.sql.Timestamp;

public class DisputeCaseVO {
	String dispute_Case_No;
	String mission_No;
	String dispute_Mem_No;
	String emp_No;
	Timestamp issue_Datetime;
	Timestamp close_Datetime;
	Integer dispute_Case_Status;
	public String getDispute_Case_No() {
		return dispute_Case_No;
	}
	public void setDispute_Case_No(String dispute_Case_No) {
		this.dispute_Case_No = dispute_Case_No;
	}
	public String getMission_No() {
		return mission_No;
	}
	public void setMission_No(String mission_No) {
		this.mission_No = mission_No;
	}
	public String getDispute_Mem_No() {
		return dispute_Mem_No;
	}
	public void setDispute_Mem_No(String dispute_Mem_No) {
		this.dispute_Mem_No = dispute_Mem_No;
	}
	public String getEmp_No() {
		return emp_No;
	}
	public void setEmp_No(String emp_No) {
		this.emp_No = emp_No;
	}
	public Timestamp getIssue_Datetime() {
		return issue_Datetime;
	}
	public void setIssue_Datetime(Timestamp issue_Fatetime) {
		this.issue_Datetime = issue_Fatetime;
	}
	public Timestamp getClose_Datetime() {
		return close_Datetime;
	}
	public void setClose_Datetime(Timestamp close_Datetime) {
		this.close_Datetime = close_Datetime;
	}
	public Integer getDispute_Case_Status() {
		return dispute_Case_Status;
	}
	public void setDispute_Case_Status(Integer dispute_Case_Status) {
		this.dispute_Case_Status = dispute_Case_Status;
	}
}
