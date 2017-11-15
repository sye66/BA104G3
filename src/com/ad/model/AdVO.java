package com.ad.model;

import java.sql.Timestamp;

public class AdVO  implements java.io.Serializable{
	private String ad_No;
	private byte[] ad_Pic;
	private String ad_Desc;
	private Timestamp ad_Start;
	private Timestamp ad_End;
	private String ad_Fty_No;
	private String ad_Fty_Name;
	
	
	public String getAd_No() {
		return ad_No;
	}
	public void setAd_No(String ad_No) {
		this.ad_No = ad_No;
	}
	public byte[] getAd_Pic() {
		return ad_Pic;
	}
	public void setAd_Pic(byte[] ad_Pic) {
		this.ad_Pic = ad_Pic;
	}
	public String getAd_Desc() {
		return ad_Desc;
	}
	public void setAd_Desc(String ad_Desc) {
		this.ad_Desc = ad_Desc;
	}
	public Timestamp getAd_Start() {
		return ad_Start;
	}
	public void setAd_Start(Timestamp ad_Start) {
		this.ad_Start = ad_Start;
	}
	public Timestamp getAd_End() {
		return ad_End;
	}
	public void setAd_End(Timestamp ad_End) {
		this.ad_End = ad_End;
	}
	public String getAd_Fty_No() {
		return ad_Fty_No;
	}
	public void setAd_Fty_No(String ad_Fty_No) {
		this.ad_Fty_No = ad_Fty_No;
	}
	public String getAd_Fty_Name() {
		return ad_Fty_Name;
	}
	public void setAd_Fty_Name(String ad_Fty_Name) {
		this.ad_Fty_Name = ad_Fty_Name;
	}

}