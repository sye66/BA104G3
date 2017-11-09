package com.protrack.model;

import java.util.List;


public interface ProTrackDAO_interface {
	public void insert(ProTrackVO proTrackVO);
	public void delete(ProTrackVO proTrackVO);
	public List<ProTrackVO>getAll();
	public List<ProTrackVO> findByPrimaryKey(String mem_No);
}
