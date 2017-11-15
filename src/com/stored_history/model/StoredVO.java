package com.stored_history.model;

import java.sql.Date;
import java.sql.Timestamp;

public class StoredVO {

	private String stored_No;
	private String mem_No;
	private Timestamp stored_Date;
	private Integer stored_Type;
	private Double stored_Cost;
	
	public StoredVO() {
		super();
	}

	public String getStored_No() {
		return stored_No;
	}

	public void setStored_No(String stored_No) {
		this.stored_No = stored_No;
	}

	public String getMem_No() {
		return mem_No;
	}

	public void setMem_No(String mem_No) {
		this.mem_No = mem_No;
	}

	public Timestamp getStored_Date() {
		return stored_Date;
	}

	public void setStored_Date(Timestamp stored_Date) {
		this.stored_Date = stored_Date;
	}

	public Integer getStored_Type() {
		return stored_Type;
	}

	public void setStored_Type(Integer stored_Type) {
		this.stored_Type = stored_Type;
	}

	public Double getStored_Cost() {
		return stored_Cost;
	}

	public void setStored_Cost(Double stored_Cost) {
		this.stored_Cost = stored_Cost;
	}

	
	
	
}
