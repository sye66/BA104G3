package com.relation.model;

import java.util.List;


public interface RelationDAO_interface {

	public void insert(RelationVO relationVO);
	public void update(RelationVO relationVO);
	public void delete(String mem_No, String related_Mem_No);
	public RelationVO findByPrimaryKey(String mem_No, String related_Mem_No);
	public List<RelationVO> getAllRelationWithMem_No(String mem_No);
	public List<RelationVO> getWhoAddme(String related_Mem_No);
	public List<RelationVO> getAll();
	List<RelationVO> getAllFriends(String related_Mem_No);

}
