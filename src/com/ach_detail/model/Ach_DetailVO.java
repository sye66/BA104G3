package com.ach_detail.model;

import java.sql.Date;

public class Ach_DetailVO {
	private String mem_No;
	private String ach_No;
	private Date ach_Time;
	
	public String getMem_No() {
		return mem_No;
	}
	public void setMem_No(String mem_No) {
		this.mem_No = mem_No;
	}
	public String getAch_No() {
		return ach_No;
	}
	public void setAch_No(String ach_No) {
		this.ach_No = ach_No;
	}
	public Date getAch_Time() {
		return ach_Time;
	}
	public void setAch_Time(Date ach_Time) {
		this.ach_Time = ach_Time;
	}
}
