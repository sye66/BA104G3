package com.artiReply.model;

import java.sql.Timestamp;

public class ArtiReplyVO implements java.io.Serializable {
	private String reply_No;
	private String mem_No;
	private String arti_No;
	private String reply_Desc;
	private Timestamp reply_Time;
	private Integer arti_Cls_No;
	
	public String getReply_No() {
		return reply_No;
	}
	public void setReply_No(String reply_No) {
		this.reply_No = reply_No;
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
	public String getReply_Desc() {
		return reply_Desc;
	}
	public void setReply_Desc(String reply_Desc) {
		this.reply_Desc = reply_Desc;
	}
	public Timestamp getReply_Time() {
		return reply_Time;
	}
	public void setReply_Time(Timestamp reply_Time) {
		this.reply_Time = reply_Time;
	}
	public Integer getArti_Cls_No() {
		return arti_Cls_No;
	}
	public void setArti_Cls_No(Integer arti_Cls_No) {
		this.arti_Cls_No = arti_Cls_No;
	}
}
