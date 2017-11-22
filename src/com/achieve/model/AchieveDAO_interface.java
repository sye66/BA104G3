package com.achieve.model;

import java.util.List;

import com.achieve.model.AchieveVO;

public interface AchieveDAO_interface {
	public void insert(AchieveVO achieveVO);
    public void update(AchieveVO achieveVO);
    public void delete(String ach_No);
    public AchieveVO findByPrimaryKey(String ach_No);
    public List<AchieveVO> getAll();
    public List<AchieveVO> getThree(String ach_No);
    
   
}

