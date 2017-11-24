package com.android.model;

public class RelationVO {
	
	private String mem_No;
	private String related_Mem_No;
	private Integer relation_Status;
	
	public RelationVO (){
		super();
	}

	public String getMem_No() {
		return mem_No;
	}

	public void setMem_No(String mem_No) {
		this.mem_No = mem_No;
	}

	public String getRelated_Mem_No() {
		return related_Mem_No;
	}

	public void setRelated_Mem_No(String related_Mem_No) {
		this.related_Mem_No = related_Mem_No;
	}

	public Integer getRelation_Status() {
		return relation_Status;
	}

	public void setRelation_Status(Integer relation_Status) {
		this.relation_Status = relation_Status;
	}

	
	
}