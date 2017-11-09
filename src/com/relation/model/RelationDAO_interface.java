package com.relation.model;

import java.util.List;


public interface RelationDAO_interface {

	public void insert(RelationVO relationVO);
	public void update(RelationVO relationVO);
	public void delete(String mem_no, String related_mem_no);
	public RelationVO findByPrimaryKey(String mem_no, String related_mem_no);
	public List<RelationVO> getAllRelationWithMem_no(String mem_no);
	

}
