package com.proordlist.model;

public class ProOrdListVO implements java.io.Serializable{
	private String ord_No;
	private String pro_No;
	private Integer ordPro_Count;
	private Double ordPro_Price;
	
	public String getOrd_No() {
		return ord_No;
	}
	public void setOrd_No(String ord_No) {
		this.ord_No = ord_No;
	}
	public String getPro_No() {
		return pro_No;
	}
	public void setPro_No(String pro_No) {
		this.pro_No = pro_No;
	}
	public Integer getOrdPro_Count() {
		return ordPro_Count;
	}
	public void setOrdPro_Count(Integer ordPro_Count) {
		this.ordPro_Count = ordPro_Count;
	}
	public Double getOrdPro_Price() {
		return ordPro_Price;
	}
	public void setOrdPro_Price(Double ordPor_Price) {
		this.ordPro_Price = ordPor_Price;
	}
	
}
