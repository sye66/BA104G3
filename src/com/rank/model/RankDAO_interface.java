package com.rank.model;

import java.util.List;

import com.rank.model.RankVO;

public interface RankDAO_interface {
	 public void insert(RankVO rankVO);
     public void delete(String mem_No);
     public RankVO findByPrimaryKey(String mem_No);
     public List<RankVO> getAll();
     public List<RankVO> getWNRank();
     public List<RankVO> getMNRank();
     public List<RankVO> getSNRank();
     public List<RankVO> getWCRank();
     public List<RankVO> getMCRank();
     public List<RankVO> getSCRank();
}
