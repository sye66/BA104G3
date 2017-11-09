package com.casecandidate.model;
import java.sql.Date;

public class CaseCandidateVO implements java.io.Serializable{
	private String candidate_Mem_No;
	private String mission_No;
	private String mission_Name;
	private String issuer_Mem_No;
	private String mem_Name;
	
	public String getCandidate_Mem_No() {
		return candidate_Mem_No;
	}
	public void setCandidate_Mem_No(String candidate_Mem_No) {
		this.candidate_Mem_No = candidate_Mem_No;
	}
	public String getMission_No() {
		return mission_No;
	}
	public void setMission_No(String mission_No) {
		this.mission_No = mission_No;
	}
	public String getMission_Name() {
		return mission_Name;
	}
	public void setMission_Name(String mission_Name) {
		this.mission_Name = mission_Name;
	}
	public String getIssuer_Mem_No() {
		return issuer_Mem_No;
	}
	public void setIssuer_Mem_No(String issuer_Mem_No) {
		this.issuer_Mem_No = issuer_Mem_No;
	}
	public String getMem_Name() {
		return mem_Name;
	}
	public void setMem_Name(String mem_Name) {
		this.mem_Name = mem_Name;
	}
	
	
}
