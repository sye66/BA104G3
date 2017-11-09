package com.skill.model;

import java.util.List;

public interface SkillDAO_interface {
	public void insert(SkillVO skillVO);
	public void delete(String skill_no);
	public void update(SkillVO skillVO);
	public SkillVO findByPrimaryKey(String skill_no);
	public List<SkillVO> getall();
}