package com.relation.model;

public class RelationVO {
	
	private String mem_no;
	private String related_mem_no;
	private Integer relation_status;
	
	public RelationVO (){
		super();
	}

	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

	public String getRelated_mem_no() {
		return related_mem_no;
	}

	public void setRelated_mem_no(String related_mem_no) {
		this.related_mem_no = related_mem_no;
	}

	public Integer getRelation_status() {
		return relation_status;
	}

	public void setRelation_status(Integer relation_status) {
		this.relation_status = relation_status;
	}
	
	
}
