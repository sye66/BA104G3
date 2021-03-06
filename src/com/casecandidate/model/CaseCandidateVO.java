package com.casecandidate.model;
import java.sql.Date;

public class CaseCandidateVO implements java.io.Serializable{
	private String candidate_Mem_No;
	private String mission_No;
	private String mission_Name;
	private String issuer_Mem_No;
	private String mem_Name;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((candidate_Mem_No == null) ? 0 : candidate_Mem_No.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CaseCandidateVO other = (CaseCandidateVO) obj;
		if (candidate_Mem_No == null) {
			if (other.candidate_Mem_No != null)
				return false;
		} else if (!candidate_Mem_No.equals(other.candidate_Mem_No))
			return false;
		return true;
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
