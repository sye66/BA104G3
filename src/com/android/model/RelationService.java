package com.android.model;

import java.util.List;

public class RelationService {

	private RelationDAO_interface dao;
	
	public RelationService(){
		dao = new RelationDAO();
	}
	
	public List<RelationVO> getAllFriends(String related_Mem_No){
		RelationVO relationVO = new RelationVO();
		relationVO.setRelated_Mem_No(related_Mem_No);
//		 List<RelationVO> list =dao.getWhoAddme("M000001");
//		 System.out.println( "svc取得的LIST長度"+list.size());
		return dao.getAllFriends(related_Mem_No);
		
	}
	
	
	
	public List<RelationVO> getWhoAddme(String related_Mem_No){
		RelationVO relationVO = new RelationVO();
		relationVO.setRelated_Mem_No(related_Mem_No);
//		 List<RelationVO> list =dao.getWhoAddme("M000001");
//		 System.out.println( "svc取得的LIST長度"+list.size());
		return dao.getWhoAddme(related_Mem_No);
		
	}
	
	
	public RelationVO addRelationVO(String mem_No, String related_Mem_No, Integer relation_Status){
		
		RelationVO relationVO = new RelationVO();
		
		relationVO.setMem_No(mem_No);
		relationVO.setRelated_Mem_No(related_Mem_No);
		relationVO.setRelation_Status(relation_Status);
		
		dao.insert(relationVO);
		
		return relationVO;
	}
	
	public RelationVO updaterelationVO(String mem_No, String related_Mem_No, Integer relation_Status){
		
		RelationVO relationVO = new RelationVO();
		
		relationVO.setRelation_Status(relation_Status);
		relationVO.setMem_No(mem_No);
		relationVO.setRelated_Mem_No(related_Mem_No);
	
		
		dao.update(relationVO);
		
		return relationVO;
	}
	
	public void deleteRelationVO(String mem_No, String related_Mem_No){
		
		dao.delete(mem_No, related_Mem_No);
	}
	
	public RelationVO getOneRelationVO(String mem_No, String related_Mem_No){
		
		return dao.findByPrimaryKey(mem_No, related_Mem_No);
	}
	
	public List<RelationVO> getAllRelationWithMem_No(String mem_No){
		
		return dao.getAllRelationWithMem_No(mem_No);
	}
	
	public List<RelationVO> getAllFriendWithMem_No(String mem_No){
		return dao.getAllFriendWithMem_No(mem_No);
	}
	
	public List<RelationVO> getAll(){
		
		return dao.getAll();
	}
}