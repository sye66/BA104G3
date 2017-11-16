package com.protrack.model;

import java.util.List;


public interface ProTrackDAO_interface {
	public void insert(ProTrackVO proTrackVO);
	public void delete(String mem_No,String pro_No);
	public List<ProTrackVO>getAll();
	public List<ProTrackVO> findByPrimaryKey(String mem_No);
}
