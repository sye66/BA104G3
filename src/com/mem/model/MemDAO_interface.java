package com.mem.model;

import java.util.*;

import com.relation.model.RelationVO;
import com.rank.model.RankVO;

public interface MemDAO_interface {
	public MemVO loginMem(String mem_Email);
	public void insert(MemVO memVO);
	public void update(MemVO memVO);
	public void updatePw(MemVO memVO);
	public void updateByMem(MemVO memVO);
	public void delete(String mem_No);
	public MemVO findByPrimaryKey(String mem_No);
	public MemVO findByMemEmail(String mem_Email);
	public List<MemVO> getAll();
	public List<MemVO> getAll(Integer searchable);
	public List<MemVO> getAllForFriend(String mem_No);
	public void register(MemVO memVO);
	public MemVO Authentication(MemVO memVO);
	public void recharge(MemVO memVO);
	public void updateMemPoint(MemVO memVO);
	public void updateByEmp(MemVO memVO);
//	public void select(MemVO memVO);
	
}
