package com.proorder.model;

import java.sql.Date;

public class ProOrderVO implements java.io.Serializable{
	private String ord_No;
	private String mem_No;
	private Date ord_Date;
	private Double ord_Price;
	private String ord_Consignee;
	private String ord_Address;
	private String ord_Phone;
	private String ord_Shipinfo;
	private Date ord_Ship_Date;
	
	public String getOrd_No() {
		return ord_No;
	}
	public void setOrd_No(String ord_No) {
		this.ord_No = ord_No;
	}
	public String getMem_No() {
		return mem_No;
	}
	public void setMem_No(String mem_No) {
		this.mem_No = mem_No;
	}
	public Date getOrd_Date() {
		return ord_Date;
	}
	public void setOrd_Date(Date ord_Date) {
		this.ord_Date = ord_Date;
	}
	public Double getOrd_Price() {
		return ord_Price;
	}
	public void setOrd_Price(Double ord_Price) {
		this.ord_Price = ord_Price;
	}
	public String getOrd_Consignee() {
		return ord_Consignee;
	}
	public void setOrd_Consignee(String ord_Consignee) {
		this.ord_Consignee = ord_Consignee;
	}
	public String getOrd_Address() {
		return ord_Address;
	}
	public void setOrd_Address(String ord_Address) {
		this.ord_Address = ord_Address;
	}
	public String getOrd_Phone() {
		return ord_Phone;
	}
	public void setOrd_Phone(String ord_Phone) {
		this.ord_Phone = ord_Phone;
	}
	public String getOrd_Shipinfo() {
		return ord_Shipinfo;
	}
	public void setOrd_Shipinfo(String ord_Shipinfo) {
		this.ord_Shipinfo = ord_Shipinfo;
	}
	public Date getOrd_Ship_Date() {
		return ord_Ship_Date;
	}
	public void setOrd_Ship_Date(Date ord_Ship_Date) {
		this.ord_Ship_Date = ord_Ship_Date;
	}
	
	
	
}
