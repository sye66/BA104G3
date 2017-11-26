package com.getmission.model;
import java.sql.Date;
import java.sql.Timestamp;


public class GetMissionVO implements java.io.Serializable{
	private String mission_No;
	private String mission_Category;
	private String mission_Name;
	private String mission_Des;
	private String issuer_Mem_No;
	private String takecase_Mem_No;
	private Timestamp mission_Release_Time;
	private Timestamp mission_Due_Time;
	private Timestamp mission_Start_Time;
	private Timestamp mission_End_Time;
	private Integer mission_State;
	private Integer mission_Pattern;
	private Double mission_Pay;
	private Double mission_Gps_Lat;
	private Double mission_Gps_Lng;
	
	
	
	public String getMission_No() {
		return mission_No;
	}
	public void setMission_No(String mission_No) {
		this.mission_No = mission_No;
	}
	public String getMission_Category() {
		return mission_Category;
	}
	public void setMission_Category(String mission_Category) {
		this.mission_Category = mission_Category;
	}
	public String getMission_Name() {
		return mission_Name;
	}
	public void setMission_Name(String mission_Name) {
		this.mission_Name = mission_Name;
	}
	public String getMission_Des() {
		return mission_Des;
	}
	public void setMission_Des(String mission_Des) {
		this.mission_Des = mission_Des;
	}
	public String getIssuer_Mem_No() {
		return issuer_Mem_No;
	}
	public void setIssuer_Mem_No(String issuer_Mem_No) {
		this.issuer_Mem_No = issuer_Mem_No;
	}
	public String getTakecase_Mem_No() {
		return takecase_Mem_No;
	}
	public void setTakecase_Mem_No(String takecase_Mem_No) {
		this.takecase_Mem_No = takecase_Mem_No;
	}
	public Timestamp getMission_Release_Time() {
		return mission_Release_Time;
	}
	public void setMission_Release_Time(Timestamp mission_Release_Time) {
		this.mission_Release_Time = mission_Release_Time;
	}
	public Timestamp getMission_Due_Time() {
		return mission_Due_Time;
	}
	public void setMission_Due_Time(Timestamp mission_Due_Time) {
		this.mission_Due_Time = mission_Due_Time;
	}
	public Timestamp getMission_Start_Time() {
		return mission_Start_Time;
	}
	public void setMission_Start_Time(Timestamp mission_Start_Time) {
		this.mission_Start_Time = mission_Start_Time;
	}
	public Timestamp getMission_End_Time() {
		return mission_End_Time;
	}
	public void setMission_End_Time(Timestamp mission_End_Time) {
		this.mission_End_Time = mission_End_Time;
	}
	public Integer getMission_State() {
		return mission_State;
	}
	public void setMission_State(Integer mission_State) {
		this.mission_State = mission_State;
	}
	public Integer getMission_Pattern() {
		return mission_Pattern;
	}
	public void setMission_Pattern(Integer mission_Pattern) {
		this.mission_Pattern = mission_Pattern;
	}
	public Double getMission_Pay() {
		return mission_Pay;
	}
	public void setMission_Pay(Double mission_Pay) {
		this.mission_Pay = mission_Pay;
	}
	
	public Double getMission_Gps_Lat() {
		return mission_Gps_Lat;
	}
	public void setMission_Gps_Lat(Double mission_Gps_Lat) {
		this.mission_Gps_Lat = mission_Gps_Lat;
	}
	public Double getMission_Gps_Lng() {
		return mission_Gps_Lng;
	}
	public void setMission_Gps_Lng(Double mission_Gps_Lng) {
		this.mission_Gps_Lng = mission_Gps_Lng;
	}
}
