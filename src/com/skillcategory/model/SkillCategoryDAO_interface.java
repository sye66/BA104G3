package com.skillcategory.model;

import java.util.List;

public interface SkillCategoryDAO_interface {
	public void insert(SkillCategoryVO skillCategoryVO);
	public void delete(String skill_Cate_No);
	public void update(SkillCategoryVO skillCategoryVO);
	public SkillCategoryVO findByPrimaryKey(String skill_Cate_No);
	public List<SkillCategoryVO> getall();
}
