package com.stored_history.model;

import java.sql.Date;
import java.util.List;

import com.mem.model.MemVO;

public class StoredService {

	private StoredDAO_interface dao;
	
	public StoredService(){
		dao = new StoredDAO();
	}
	
	public StoredVO addStored(String mem_no, Date stored_date, Integer stored_type,
			Double stored_cost){
		
		StoredVO storedVO = new StoredVO();
		
		storedVO.setMem_no(mem_no);
		storedVO.setStored_date(stored_date);
		storedVO.setStored_type(stored_type);
		storedVO.setStored_cost(stored_cost);
		
		dao.insert(storedVO);
		
		return storedVO;
	}
	
	public StoredVO updateStored(String stored_no, String mem_no, Date stored_date,
			Integer stored_type, Double stored_cost){
		
		StoredVO storedVO = new StoredVO();
		
		storedVO.setStored_no(stored_no);
		storedVO.setMem_no(mem_no);
		storedVO.setStored_date(stored_date);
		storedVO.setStored_type(stored_type);
		storedVO.setStored_cost(stored_cost);
		
		dao.update(storedVO);
		
		return storedVO;
		
	}
	
	public void deleteStored(String stored_no){
		dao.delete(stored_no);
	}
	
	public StoredVO getOneStored(String stored_no){
		return dao.findByPrimaryKey(stored_no);
	}
	
	public List<StoredVO> getAll(){
		return dao.getAll();
	}
	
}
