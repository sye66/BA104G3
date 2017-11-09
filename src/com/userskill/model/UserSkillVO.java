package com.userskill.model;

public class UserSkillVO {
	private String mem_no;
	private String skill_no;
	private String skill_detail;
	private byte[] skill_cert;
	public String getMem_no() {
		return mem_no;
	}
	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}
	public String getSkill_no() {
		return skill_no;
	}
	public void setSkill_no(String skill_no) {
		this.skill_no = skill_no;
	}
	public String getSkill_detail() {
		return skill_detail;
	}
	public void setSkill_detail(String skill_detail) {
		this.skill_detail = skill_detail;
	}
	public byte[] getSkill_cert() {
		return skill_cert;
	}
	public void setSkill_cert(byte[] skill_cert) {
		this.skill_cert = skill_cert;
	}
	
}
