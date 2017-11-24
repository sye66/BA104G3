package com.android.model;

import java.io.Serializable;

public class Case_CandidateVO implements java.io.Serializable{
	private String candidate_Mem_No;
	private String mission_No;
	private Integer issuer_Inviting;
	
	public Integer getIssuer_Inviting() {
		return issuer_Inviting;
	}
	public void setIssuer_Inviting(Integer issuer_Inviting) {
		this.issuer_Inviting = issuer_Inviting;
	}
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
	
	
	
}
