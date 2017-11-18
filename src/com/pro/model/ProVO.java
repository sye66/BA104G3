package com.pro.model;

import java.sql.Date;

public class ProVO implements java.io.Serializable{
	private String pro_No;
	private String pro_Class_No;
	private String pro_Name;
	private String pro_Info;
	private Integer pro_Price;
	private String pro_Status;
	private Integer pro_Discount;
	private Date pro_Dis_StartDate;
	private Date pro_Dis_EndDate;
	private byte[] pro_Pic;
	
	public ProVO(){
	}

	public String getPro_No() {
		return pro_No;
	}

	public void setPro_No(String pro_No) {
		this.pro_No = pro_No;
	}

	public String getPro_Name() {
		return pro_Name;
	}

	public void setPro_Name(String pro_Name) {
		this.pro_Name = pro_Name;
	}
	
	public Integer getPro_Price() {
		return pro_Price;
	}

	public void setPro_Price(Integer pro_Price) {
		this.pro_Price = pro_Price;
	}

	public String getPro_Info() {
		return pro_Info;
	}

	public void setPro_Info(String pro_Info) {
		this.pro_Info = pro_Info;
	}

	

	public byte[] getPro_Pic() {
		return pro_Pic;
	}

	public void setPro_Pic(byte[] pro_Pic) {
		this.pro_Pic = pro_Pic;
	}
	public String getPro_Class_No() {
		return pro_Class_No;
	}

	public void setPro_Class_No(String pro_ClassNo) {
		this.pro_Class_No = pro_ClassNo;
	}

	public String getPro_Status() {
		return pro_Status;
	}

	public void setPro_Status(String pro_Status) {
		this.pro_Status = pro_Status;
	}

	public Integer getPro_Discount() {
		return pro_Discount;
	}

	public void setPro_Discount(Integer pro_Discount) {
		this.pro_Discount = pro_Discount;
	}

	public Date getPro_Dis_StartDate() {
		return pro_Dis_StartDate;
	}

	public void setPro_Dis_StartDate(Date pro_Dis_StartDate) {
		this.pro_Dis_StartDate = pro_Dis_StartDate;
	}

	public Date getPro_Dis_EndDate() {
		return pro_Dis_EndDate;
	}

	public void setPro_Dis_EndDate(Date pro_Dis_EndDate) {
		this.pro_Dis_EndDate = pro_Dis_EndDate;
	}
	
}
