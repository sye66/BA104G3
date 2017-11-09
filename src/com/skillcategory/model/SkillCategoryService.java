package com.skillcategory.model;

import java.util.List;

public class SkillCategoryService {
	private SkillCategoryDAO_interface dao;
	
	public SkillCategoryService() {
		dao = new SkillCategoryDAO();
	}
	
	public SkillCategoryVO addSklCate(String skill_Cate_No, String skill_Cate_Name) {
		SkillCategoryVO skillCategoryVO = new SkillCategoryVO();
		skillCategoryVO.setSkill_Cate_No(skill_Cate_No);
		skillCategoryVO.setSkill_Cate_Name(skill_Cate_Name);
		dao.insert(skillCategoryVO);
		return skillCategoryVO;
	}
	public void deleteSklCate(String skill_Cate_No) {
		dao.delete(skill_Cate_No);
	}
	public SkillCategoryVO updateSklCate(String skill_Cate_No, String skill_Cate_Name) {
		SkillCategoryVO skillCategoryVO = new SkillCategoryVO();
		skillCategoryVO.setSkill_Cate_No(skill_Cate_No);
		skillCategoryVO.setSkill_Cate_Name(skill_Cate_Name);
		dao.update(skillCategoryVO);
		return skillCategoryVO;
	}
	public SkillCategoryVO getOneSkillCate(String skill_Cate_No) {
		return dao.findByPrimaryKey(skill_Cate_No);
	}
	public List<SkillCategoryVO> getAllSklCate(){
		return dao.getall();
	}
}