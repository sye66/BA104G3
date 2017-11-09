package com.missionimages.model;
import java.sql.Date;

public class MissionImagesVO implements java.io.Serializable{
	private String image_No;
	private String mission_No;
	private String issuer_Mem_No;
	private byte[] issuer_images;
	
	public String getImage_No() {
		return image_No;
	}
	public void setImage_No(String image_No) {
		this.image_No = image_No;
	}
	public String getMission_No() {
		return mission_No;
	}
	public void setMission_No(String mission_No) {
		this.mission_No = mission_No;
	}
	public String getIssuer_Mem_No() {
		return issuer_Mem_No;
	}
	public void setIssuer_Mem_No(String issuer_Mem_No) {
		this.issuer_Mem_No = issuer_Mem_No;
	}
	public byte[] getIssuer_images() {
		return issuer_images;
	}
	public void setIssuer_images(byte[] issuer_images) {
		this.issuer_images = issuer_images;
	}
	
}
