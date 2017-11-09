package com.accusecase.model;
import java.sql.Date;

public class AccuseCaseVO implements java.io.Serializable{
	private String accuse_No;
	private String mission_No;
	private String accuser_No;
	private String emp_No;
	private Date accuse_Date;
	private Date closed_Case_Date;
	private String accuse_Detail;
	private Integer accuse_State;
	
	public String getAccuse_No() {
		return accuse_No;
	}
	public void setAccuse_No(String accuse_No) {
		this.accuse_No = accuse_No;
	}
	public String getMission_No() {
		return mission_No;
	}
	public void setMission_No(String mission_No) {
		this.mission_No = mission_No;
	}
	public String getAccuser_No() {
		return accuser_No;
	}
	public void setAccuser_No(String accuser_No) {
		this.accuser_No = accuser_No;
	}
	public String getEmp_No() {
		return emp_No;
	}
	public void setEmp_No(String emp_No) {
		this.emp_No = emp_No;
	}
	public Date getAccuse_Date() {
		return accuse_Date;
	}
	public void setAccuse_Date(Date accuse_Date) {
		this.accuse_Date = accuse_Date;
	}
	public Date getClosed_Case_Date() {
		return closed_Case_Date;
	}
	public void setClosed_Case_Date(Date closed_Case_Date) {
		this.closed_Case_Date = closed_Case_Date;
	}
	public String getAccuse_Detail() {
		return accuse_Detail;
	}
	public void setAccuse_Detail(String accuse_Detail) {
		this.accuse_Detail = accuse_Detail;
	}
	public Integer getAccuse_State() {
		return accuse_State;
	}
	public void setAccuse_State(Integer accuse_State) {
		this.accuse_State = accuse_State;
	}
	
	
}
