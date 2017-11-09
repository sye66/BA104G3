package com.stored_history.model;

import java.sql.Date;

public class StoredVO {

	private String stored_no;
	private String mem_no;
	private Date stored_date;
	private Integer stored_type;
	private Double stored_cost;
	
	public StoredVO() {
		super();
	}

	public String getStored_no() {
		return stored_no;
	}

	public void setStored_no(String stored_no) {
		this.stored_no = stored_no;
	}

	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

	public Date getStored_date() {
		return stored_date;
	}

	public void setStored_date(Date stored_date) {
		this.stored_date = stored_date;
	}

	public Integer getStored_type() {
		return stored_type;
	}

	public void setStored_type(Integer stored_type) {
		this.stored_type = stored_type;
	}

	public Double getStored_cost() {
		return stored_cost;
	}

	public void setStored_cost(Double stored_cost) {
		this.stored_cost = stored_cost;
	}
	
	
	
}
