package com.artiReport.model;

import java.sql.Timestamp;

public class ArtiReportVO implements java.io.Serializable {
	private String report_No;
	private String mem_No;
	private String arti_No;
	private String report_Desc;
	private Timestamp report_Time;
	private Integer arti_Cls_No;
	private String report_Status;
	
	
	public String getReport_No() {
		return report_No;
	}
	public void setReport_No(String report_No) {
		this.report_No = report_No;
	}
	public String getMem_No() {
		return mem_No;
	}
	public void setMem_No(String mem_No) {
		this.mem_No = mem_No;
	}
	public String getArti_No() {
		return arti_No;
	}
	public void setArti_No(String arti_No) {
		this.arti_No = arti_No;
	}
	public String getReport_Desc() {
		return report_Desc;
	}
	public void setReport_Desc(String report_Desc) {
		this.report_Desc = report_Desc;
	}
	public Timestamp getReport_Time() {
		return report_Time;
	}
	public void setReport_Time(Timestamp report_Time) {
		this.report_Time = report_Time;
	}
	public Integer getArti_Cls_No() {
		return arti_Cls_No;
	}
	public void setArti_Cls_No(Integer arti_Cls_No) {
		this.arti_Cls_No = arti_Cls_No;
	}
	public String getReport_Status() {
		return report_Status;
	}
	public void setReport_Status(String report_Status) {
		this.report_Status = report_Status;
	}
}
