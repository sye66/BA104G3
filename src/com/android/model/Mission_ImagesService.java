package com.android.model;



public class Mission_ImagesService {
	private Mission_ImagesDAO_interface dao;

	public Mission_ImagesService() {
		dao = new Mission_ImagesDAO();
	}
	
	public Mission_ImagesVO insertMissionImages(String mission_No,String issuer_Mem_No, byte[] issuer_Images){
		Mission_ImagesVO mission_ImagesVO = new Mission_ImagesVO();
		mission_ImagesVO.setIssuer_Mem_No(issuer_Mem_No);
		mission_ImagesVO.setMission_No(mission_No);
		mission_ImagesVO.setIssuer_Images(issuer_Images);
		dao.insert(mission_ImagesVO);
		return mission_ImagesVO;
	}
	
	public void deleteMissionImagesByMissionNo(String mission_No){
		Mission_ImagesVO mission_ImagesVO = new Mission_ImagesVO();
		dao.deleteByMissionNo(mission_No);
		
	}
	
	public Mission_ImagesVO insertMissionImagesNoimage(String mission_No,String issuer_Mem_No){
		Mission_ImagesVO mission_ImagesVO = new Mission_ImagesVO();
		mission_ImagesVO.setIssuer_Mem_No(issuer_Mem_No);
		mission_ImagesVO.setMission_No(mission_No);
		dao.insertNoImage(mission_No,issuer_Mem_No);
		return mission_ImagesVO;
	}
	
}
