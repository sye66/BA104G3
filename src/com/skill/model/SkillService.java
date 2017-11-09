package com.skill.model;

import java.util.List;

public class SkillService {
	private SkillDAO_interface dao;
	
	public SkillService() {
		dao = new SkillDAO();
	}
	public SkillVO addSkill(String skill_No,String skill_Name,String skill_Cate_No) {
		SkillVO skillVO = new SkillVO();
		skillVO.setSkill_No(skill_No);
		skillVO.setSkill_Name(skill_Name);
		skillVO.setSkill_Cate_No(skill_Cate_No);
		return skillVO;
	}
	public void deleteSkill(String skill_No) {
		dao.delete(skill_No);
	}
	public SkillVO updateSkill(String skill_No,String skill_Name,String skill_Cate_No) {
		SkillVO skillVO = new SkillVO();
		skillVO.setSkill_No(skill_No);
		skillVO.setSkill_Name(skill_Name);
		skillVO.setSkill_Cate_No(skill_Cate_No);
		dao.update(skillVO);
		return skillVO;
	}
	public SkillVO getOneSkill(String skill_No) {
		return dao.findByPrimaryKey(skill_No);
	}
	public List<SkillVO> getAll() {
		return dao.getall();
	}
}
