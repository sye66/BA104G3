package com.rank.model;

import java.util.List;

import com.rank.model.RankVO;

public interface RankDAO_interface {
	 public void insert(RankVO rankVO);
     public void update(RankVO rankVO);
     public void delete(String mem_No);
     public RankVO findByPrimaryKey(String mem_No);
     public List<RankVO> getAll();
}
