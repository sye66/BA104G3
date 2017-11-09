package com.userskill.model;

import java.util.List;

public class UserSkillService {
	private UserSkillDAO_interface dao;
	
	public UserSkillService() {
		dao = new UserSkillDAO();
	}
	public UserSkillVO addSkill(String mem_no, String skill_no, String skill_detail,byte[] skill_cert) {
		UserSkillVO userSkillVO = new UserSkillVO();
		userSkillVO.setMem_No(mem_no);
		userSkillVO.setSkill_No(skill_no);
		userSkillVO.setSkill_Detail(skill_detail);
		userSkillVO.setSkill_Cert(skill_cert);
		dao.insert(userSkillVO);
		return userSkillVO;
	}
	
	public void deleteSkill(String mem_no, String skill_no) {
		dao.delete(mem_no, skill_no);
	}
	
	public UserSkillVO updateSkill(String mem_no, String skill_no, String skill_detail,byte[] skill_cert){
		UserSkillVO userSkillVO = new UserSkillVO();
		userSkillVO.setMem_No(mem_no);
		userSkillVO.setSkill_No(skill_no);
		userSkillVO.setSkill_Detail(skill_detail);
		userSkillVO.setSkill_Cert(skill_cert);
		dao.update(userSkillVO);
		return userSkillVO;
	}
	public UserSkillVO getOneSkill(String mem_no, String skill_no) {
		return dao.findByPrimaryKey(mem_no, skill_no);
	}
	public List<UserSkillVO> getAllSkill(){
		return dao.getall();	
	}
	
}
