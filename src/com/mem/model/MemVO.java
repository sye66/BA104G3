package com.mem.model;

import java.sql.Date;

public class MemVO {
	private String mem_No;
	private String mem_Pw;
	private String mem_Name;
	private String mem_Id;
	private Date mem_Bday;
	private String mem_Tel;
	private String mem_Pho;
	private Integer mem_Gend;
	private String mem_Email;
	private byte[] mem_Pic;
	private String mem_Intro;
	private Integer mem_Code;
	private Integer mem_State;
	private Double mem_Gps_Lat;
	private Double mem_Gps_Lng;
	private String mem_Ip;
	private Date mem_Date;
	private Integer mission_Count;
	private String mem_Address;
	private Integer mem_Search;
	private Integer mem_Point;
	
	
	public MemVO() {
		super();
	}
	

	public String getMem_No() {
		return mem_No;
	}


	public void setMem_No(String mem_No) {
		this.mem_No = mem_No;
	}


	public String getMem_Pw() {
		return mem_Pw;
	}


	public void setMem_Pw(String mem_Pw) {
		this.mem_Pw = mem_Pw;
	}


	public String getMem_Name() {
		return mem_Name;
	}


	public void setMem_Name(String mem_Name) {
		this.mem_Name = mem_Name;
	}


	public String getMem_Id() {
		return mem_Id;
	}


	public void setMem_Id(String mem_Id) {
		this.mem_Id = mem_Id;
	}


	public Date getMem_Bday() {
		return mem_Bday;
	}


	public void setMem_Bday(Date mem_Bday) {
		this.mem_Bday = mem_Bday;
	}


	public String getMem_Tel() {
		return mem_Tel;
	}


	public void setMem_Tel(String mem_Tel) {
		this.mem_Tel = mem_Tel;
	}


	public String getMem_Pho() {
		return mem_Pho;
	}


	public void setMem_Pho(String mem_Pho) {
		this.mem_Pho = mem_Pho;
	}


	public Integer getMem_Gend() {
		return mem_Gend;
	}


	public void setMem_Gend(Integer mem_Gend) {
		this.mem_Gend = mem_Gend;
	}


	public String getMem_Email() {
		return mem_Email;
	}


	public void setMem_Email(String mem_Email) {
		this.mem_Email = mem_Email;
	}


	public byte[] getMem_Pic() {
		return mem_Pic;
	}


	public void setMem_Pic(byte[] mem_Pic) {
		this.mem_Pic = mem_Pic;
	}


	public String getMem_Intro() {
		return mem_Intro;
	}


	public void setMem_Intro(String mem_Intro) {
		this.mem_Intro = mem_Intro;
	}


	public Integer getMem_Code() {
		return mem_Code;
	}


	public void setMem_Code(Integer mem_Code) {
		this.mem_Code = mem_Code;
	}


	public Integer getMem_State() {
		return mem_State;
	}


	public void setMem_State(Integer mem_State) {
		this.mem_State = mem_State;
	}


	public Double getMem_Gps_Lat() {
		return mem_Gps_Lat;
	}


	public void setMem_Gps_Lat(Double mem_Gps_Lat) {
		this.mem_Gps_Lat = mem_Gps_Lat;
	}


	public Double getMem_Gps_Lng() {
		return mem_Gps_Lng;
	}


	public void setMem_Gps_Lng(Double mem_Gps_Lng) {
		this.mem_Gps_Lng = mem_Gps_Lng;
	}


	public String getMem_Ip() {
		return mem_Ip;
	}


	public void setMem_Ip(String mem_Ip) {
		this.mem_Ip = mem_Ip;
	}


	public Date getMem_Date() {
		return mem_Date;
	}


	public void setMem_Date(Date mem_Date) {
		this.mem_Date = mem_Date;
	}


	public Integer getMission_Count() {
		return mission_Count;
	}


	public void setMission_Count(Integer mission_Count) {
		this.mission_Count = mission_Count;
	}


	public String getMem_Address() {
		return mem_Address;
	}


	public void setMem_Address(String mem_Address) {
		this.mem_Address = mem_Address;
	}


	public Integer getMem_Search() {
		return mem_Search;
	}


	public void setMem_Search(Integer mem_Search) {
		this.mem_Search = mem_Search;
	}

	public Integer getMem_Point() {
		return mem_Point;
	}


	public void setMem_Point(Integer mem_Point) {
		this.mem_Point = mem_Point;
	}


	@Override
	public String toString() {
		return "MemVO [mem_Date=" + mem_Date + "]";
	}
	
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((mem_Email == null) ? 0 : mem_Email.hashCode());
		result = prime * result + ((mem_No == null) ? 0 : mem_No.hashCode());
		return result;
	}


	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MemVO other = (MemVO) obj;
		if (mem_Email == null) {
			if (other.mem_Email != null)
				return false;
		} else if (!mem_Email.equals(other.mem_Email))
			return false;
		if (mem_No == null) {
			if (other.mem_No != null)
				return false;
		} else if (!mem_No.equals(other.mem_No))
			return false;
		return true;
	}
	
}
