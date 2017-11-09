package com.relation.model;

import java.util.List;

public class RelationService {

	private RelationDAO_interface dao;
	
	public RelationService(){
		dao = new RelationDAO();
	}
	
	public RelationVO addRelationVO(String mem_no, String related_mem_no, Integer relation_status){
		
		RelationVO relationVO = new RelationVO();
		
		relationVO.setMem_no(mem_no);
		relationVO.setRelated_mem_no(related_mem_no);
		relationVO.setRelation_status(relation_status);
		
		dao.insert(relationVO);
		
		return relationVO;
	}
	
	public RelationVO updaterelationVO(String mem_no, String related_mem_no, Integer relation_status){
		
		RelationVO relationVO = new RelationVO();
		
		relationVO.setRelation_status(relation_status);
		relationVO.setMem_no(mem_no);
		relationVO.setRelated_mem_no(related_mem_no);
	
		
		dao.update(relationVO);
		
		return relationVO;
	}
	
	public void deleteRelationVO(String mem_no, String related_mem_no){
		
		dao.delete(mem_no, related_mem_no);
	}
	
	public RelationVO getOneRelationVO(String mem_no, String related_mem_no){
		
		return dao.findByPrimaryKey(mem_no, related_mem_no);
	}
	
	public List<RelationVO> getAllRelationWithMem_no(String mem_no){
		
		return dao.getAllRelationWithMem_no(mem_no);
	}
}
