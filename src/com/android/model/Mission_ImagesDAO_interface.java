package com.android.model;

import java.util.List;


public interface Mission_ImagesDAO_interface {
	//insert«Ý½T»{
	public void insert(String mission_No);
	public void insertNoImage(String mission_No,String issuer_Mem_No);
	public void insert(Mission_ImagesVO mission_ImagesVO);
	public void insertNoImage(Mission_ImagesVO mission_ImagesVO);
	public void update(String image_No);
	public void delete(String image_No);
	public void deleteByMissionNo(String mission_No);
	public Mission_ImagesVO findByPrimaryKey(String image_No);
	public List<Mission_ImagesVO> getAll();
	public List<String> getImageNoByMissionNo(String mission_No);
	public byte[] getIssuerImageByMissionNo(String mission_No);
}
