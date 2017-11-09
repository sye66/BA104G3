package com.skillcategory.model;

import java.util.List;

public class SkillCategoryService {
	private SkillCategoryDAO_interface dao;
	
	public SkillCategoryService() {
		dao = new SkillCategoryDAO();
	}
	
	public SkillCategoryVO addSklCate(String skill_cate_no, String skill_cate_name) {
		SkillCategoryVO skillCategoryVO = new SkillCategoryVO();
		skillCategoryVO.setSkill_cate_no(skill_cate_no);
		skillCategoryVO.setSkill_cate_name(skill_cate_name);
		dao.insert(skillCategoryVO);
		return skillCategoryVO;
	}
	public void deleteSklCate(String skill_cate_no) {
		dao.delete(skill_cate_no);
	}
	public SkillCategoryVO updateSklCate(String skill_cate_no, String skill_cate_name) {
		SkillCategoryVO skillCategoryVO = new SkillCategoryVO();
		skillCategoryVO.setSkill_cate_no(skill_cate_no);
		skillCategoryVO.setSkill_cate_name(skill_cate_name);
		dao.update(skillCategoryVO);
		return skillCategoryVO;
	}
	public SkillCategoryVO getOneSkillCate(String skill_cate_no) {
		return dao.findByPrimaryKey(skill_cate_no);
	}
	public List<SkillCategoryVO> getAllSklCate(){
		return dao.getall();
	}
}