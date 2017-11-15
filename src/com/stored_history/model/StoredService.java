package com.stored_history.model;

import java.sql.Timestamp;
import java.util.List;

import com.mem.model.MemVO;

public class StoredService {

	private StoredDAO_interface dao;
	
	public StoredService(){
		dao = new StoredDAO();
	}
	
	public StoredVO addStored(StoredVO storedVO){
		
		
		dao.insert(storedVO);
		
		System.out.println("--------------------");
		return storedVO;
	}
	
	public StoredVO updateStored(String stored_No, String mem_No, Timestamp stored_Date,
			Integer stored_Type, Double stored_Cost){
		
		StoredVO storedVO = new StoredVO();
		
		storedVO.setStored_No(stored_No);
		storedVO.setMem_No(mem_No);
		storedVO.setStored_Date(stored_Date);
		storedVO.setStored_Type(stored_Type);
		storedVO.setStored_Cost(stored_Cost);
		
		dao.update(storedVO);
		
		return storedVO;
		
	}
	
	public void deleteStored(String stored_No){
		dao.delete(stored_No);
	}
	
	public StoredVO getOneStored(String stored_No){
		return dao.findByPrimaryKey(stored_No);
	}
	
	public List<StoredVO> getAll(String mem_No){
		
		return dao.getAll(mem_No);
	}
	
}
