package com.missionimages.model;

import java.util.List;

public class MissionImagesService {

	private MissionImagesDAO_interface dao;

	public MissionImagesService() {
		dao = new MissionImagesDAO();
	}

	public MissionImagesVO addMissionImages( String mission_No, String issuer_Mem_No,
			byte[] issuer_images) {

		MissionImagesVO missionImagesVO = new MissionImagesVO();

		
		missionImagesVO.setMission_No(mission_No);
		missionImagesVO.setIssuer_Mem_No(issuer_Mem_No);
		missionImagesVO.setIssuer_images(issuer_images);
		dao.insert(missionImagesVO);

		return missionImagesVO;
	}

	public MissionImagesVO updateMissionImages(String image_No, String mission_No, String issuer_Mem_No,
			byte[] issuer_images) {

		MissionImagesVO missionImagesVO = new MissionImagesVO();

		missionImagesVO.setImage_No(image_No);
		missionImagesVO.setMission_No(mission_No);
		missionImagesVO.setIssuer_Mem_No(issuer_Mem_No);
		missionImagesVO.setIssuer_images(issuer_images);
		
		dao.update(missionImagesVO);

		return missionImagesVO;
	}

	public void deleteMissionImages(String image_No) {
		dao.delete(image_No);
	}

	public MissionImagesVO getOneImage(String image_No) {
		return dao.findByPrimaryKey(image_No);
	}

	public List<MissionImagesVO> getAll() {
		return dao.getAll();
	}
	
	
	public MissionImagesVO findIpopho(String mission_no ,String issuer_mem_no){
		return dao.findIpopho(mission_no, issuer_mem_no);
	};
	
    public List<MissionImagesVO> getMissionpho(String mission_No){
    	return dao.getMissionpho(mission_No);
    };
}
