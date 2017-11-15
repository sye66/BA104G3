package com.artiForm.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class ArtiFormVO implements Serializable {
	
	private String arti_No;
	private String mem_No;
	private String arti_Title;
	private Integer arti_Like;
	private String describe;
	private Timestamp arti_Time;
	private byte[] arti_Pic;
	private Integer arti_Cls_No;
	private String arti_Status;
	
	
	public String getArti_No() {
		return arti_No;
	}
	public void setArti_No(String arti_No) {
		this.arti_No = arti_No;
	}
	public String getMem_No() {
		return mem_No;
	}
	public void setMem_No(String mem_No) {
		this.mem_No = mem_No;
	}
	public String getArti_Title() {
		return arti_Title;
	}
	public void setArti_Title(String arti_Title) {
		this.arti_Title = arti_Title;
	}
	public Integer getArti_Like() {
		return arti_Like;
	}
	public void setArti_Like(Integer arti_Like) {
		this.arti_Like = arti_Like;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public Timestamp getArti_Time() {
		return arti_Time;
	}
	public void setArti_Time(Timestamp arti_Time) {
		this.arti_Time = arti_Time;
	}
	public byte[] getArti_Pic() {
		return arti_Pic;
	}
	public void setArti_Pic(byte[] arti_Pic) {
		this.arti_Pic = arti_Pic;
	}
	public Integer getArti_Cls_No() {
		return arti_Cls_No;
	}
	public void setArti_Cls_No(Integer arti_Cls_No) {
		this.arti_Cls_No = arti_Cls_No;
	}
	public String getArti_Status() {
		return arti_Status;
	}
	public void setArti_Status(String arti_Status) {
		this.arti_Status = arti_Status;
	}
	

}
