package com.skill.model;

import java.util.List;

public class SkillService {
	private SkillDAO_interface dao;
	
	public SkillService() {
		dao = new SkillDAO();
	}
	public SkillVO addSkill(String skill_no,String skill_name,String skill_cate_no) {
		SkillVO skillVO = new SkillVO();
		skillVO.setSkill_no(skill_no);
		skillVO.setSkill_name(skill_name);
		skillVO.setSkill_cate_no(skill_cate_no);
		return skillVO;
	}
	public void deleteSkill(String skill_no) {
		dao.delete(skill_no);
	}
	public SkillVO updateSkill(String skill_no,String skill_name,String skill_cate_no) {
		SkillVO skillVO = new SkillVO();
		skillVO.setSkill_no(skill_no);
		skillVO.setSkill_name(skill_name);
		skillVO.setSkill_cate_no(skill_cate_no);
		dao.update(skillVO);
		return skillVO;
	}
	public SkillVO getOneSkill(String skill_no) {
		return dao.findByPrimaryKey(skill_no);
	}
	public List<SkillVO> getAll() {
		return dao.getall();
	}
}
