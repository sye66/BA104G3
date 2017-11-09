package com.userskill.model;

public class UserSkillVO {
	private String mem_No;
	private String skill_No;
	private String skill_Detail;
	private byte[] skill_Cert;
	public String getMem_No() {
		return mem_No;
	}
	public void setMem_No(String mem_no) {
		this.mem_No = mem_no;
	}
	public String getSkill_No() {
		return skill_No;
	}
	public void setSkill_No(String skill_no) {
		this.skill_No = skill_no;
	}
	public String getSkill_Detail() {
		return skill_Detail;
	}
	public void setSkill_Detail(String skill_detail) {
		this.skill_Detail = skill_detail;
	}
	public byte[] getSkill_Cert() {
		return skill_Cert;
	}
	public void setSkill_Cert(byte[] skill_cert) {
		this.skill_Cert = skill_cert;
	}
	
}
