package com.getmission.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.apache.catalina.tribes.util.StringManager;

public class GetMissionService {

	private GetMissionDAO_interface dao;

	public GetMissionService() {
		dao = new GetMissionDAO();
	}

	public GetMissionVO addMission(
			
			String mission_Category,
			String mission_Name,
			String mission_Des,
			String issuer_Mem_No,
			String takecase_Mem_No,
			Timestamp mission_Release_Time,
			Timestamp mission_Due_Time,
			Timestamp mission_Start_Time,
			Timestamp mission_End_Time,
			Integer mission_State,
			Integer mission_Pattern,
			Double mission_Pay,
			Double mission_Gps_Lat,
			Double mission_Gps_Lng) {

		GetMissionVO getMissionVO = new GetMissionVO();

		
		getMissionVO.setMission_Category(mission_Category);
		getMissionVO.setMission_Name(mission_Name);
		getMissionVO.setMission_Des(mission_Des);
		getMissionVO.setIssuer_Mem_No(issuer_Mem_No);
		getMissionVO.setTakecase_Mem_No(takecase_Mem_No);
		getMissionVO.setMission_Release_Time(mission_Release_Time);
		getMissionVO.setMission_Due_Time(mission_Due_Time);
		getMissionVO.setMission_Start_Time(mission_Start_Time);
		getMissionVO.setMission_End_Time(mission_End_Time);
		getMissionVO.setMission_State(mission_State);
		getMissionVO.setMission_Pattern(mission_Pattern);
		getMissionVO.setMission_Pay(mission_Pay);
		getMissionVO.setMission_Gps_Lat(mission_Gps_Lat);
		getMissionVO.setMission_Gps_Lng(mission_Gps_Lng);
		
		dao.insert(getMissionVO);

		return getMissionVO;
	}

	public GetMissionVO updateMission(
			String mission_No,
			String mission_Category,
			String mission_Name,
			String mission_Des,
			String issuer_Mem_No,
			String takecase_Mem_No,
			Timestamp mission_Release_Time,
			Timestamp mission_Due_Time,
			Timestamp mission_Start_Time,
			Timestamp mission_End_Time,
			Integer mission_State,
			Integer mission_Pattern,
			Double mission_Pay,
			Double mission_Gps_Lat,
			Double mission_Gps_Lng) {

		GetMissionVO getMissionVO = new GetMissionVO();

		getMissionVO.setMission_No(mission_No);
		getMissionVO.setMission_Category(mission_Category);
		getMissionVO.setMission_Name(mission_Name);
		getMissionVO.setMission_Des(mission_Des);
		getMissionVO.setIssuer_Mem_No(issuer_Mem_No);
		getMissionVO.setTakecase_Mem_No(takecase_Mem_No);
		getMissionVO.setMission_Release_Time(mission_Release_Time);
		getMissionVO.setMission_Due_Time(mission_Due_Time);
		getMissionVO.setMission_Start_Time(mission_Start_Time);
		getMissionVO.setMission_End_Time(mission_End_Time);
		getMissionVO.setMission_State(mission_State);
		getMissionVO.setMission_Pattern(mission_Pattern);
		getMissionVO.setMission_Pay(mission_Pay);
		getMissionVO.setMission_Gps_Lat(mission_Gps_Lat);
		getMissionVO.setMission_Gps_Lng(mission_Gps_Lng);
		dao.update(getMissionVO);

		return getMissionVO;
	}
	
	public GetMissionVO updateOneMission(
			String mission_No,
			String takecase_Mem_No,
			Timestamp mission_Start_Time,
			Timestamp mission_End_Time,
			Integer mission_State
			) {

		GetMissionVO getMissionVO = new GetMissionVO();
		getMissionVO.setMission_No(mission_No);
		getMissionVO.setTakecase_Mem_No(takecase_Mem_No);
		getMissionVO.setMission_Start_Time(mission_Start_Time);
		getMissionVO.setMission_End_Time(mission_End_Time);
		getMissionVO.setMission_State(mission_State);
		dao.update(getMissionVO);

		return getMissionVO;
	}

	
	public void deleteMission(String mission_No) {
		dao.delete(mission_No);
	}

	public GetMissionVO getOneMission(String mission_No) {
		return dao.findByPrimaryKey(mission_No);
	}
	
	public List<GetMissionVO> findIssuerCase(String issuer_Mem_No){
		return dao.findIssuerCase(issuer_Mem_No);
	}

	public List<GetMissionVO> getAll() {
		return dao.getAll();
	}
	
	public List<GetMissionVO> getAllValidMission(){
		return dao.getAllValidMission();
	}
	
	public List<GetMissionVO> getOkAll(){
		return dao.getOkAll();
	}
	
	public List<GetMissionVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	
	public GetMissionVO takeMission(
		String mission_No,
		Integer mission_State) {

	GetMissionVO getMissionVO = new GetMissionVO();
	getMissionVO.setMission_No(mission_No);
	getMissionVO.setMission_State(mission_State);
	dao.takeMission(getMissionVO);
		
		return getMissionVO;
	}
	
	public List<GetMissionVO> successGetMission(String takecase_Mem_No){
		return dao.successGetMission(takecase_Mem_No);
	}
	
	public List<GetMissionVO> findByMem(String issuer_Mem_No, Integer mission_Statuts){
		return dao.findByMem(issuer_Mem_No, mission_Statuts);
	}
	
	
	/**
	 * @author Sander
	 * @param mission_No
	 * @param mission_Status
	 * @return GetMissionVO
	 * 更改任務狀態
	 */
	public GetMissionVO updateOneMissionStatus(String mission_No, Integer mission_Status) {
		GetMissionVO getMissionVO = dao.findByPrimaryKey(mission_No);
		getMissionVO.setMission_State(mission_Status);
		dao.update(getMissionVO);
		return getMissionVO;
	}
	/**
	 * @author Sander
	 * @param mission_No
	 * @return GetMissionVO
	 * 任務"開始"，傳入任務編號會找出該VO並設定狀態4，並裝入現在時間。
	 */
	public GetMissionVO missionStart(String mission_No) {
		// 找出任務VO
		GetMissionVO getMissionVO = dao.findByPrimaryKey(mission_No);
		// 狀態:身分確認
		getMissionVO.setMission_State(4);
		// 取得現在時間
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		getMissionVO.setMission_Start_Time(timestamp);
		dao.update(getMissionVO);
		return getMissionVO;
	}
	/**
	 * @author Sander
	 * @param mission_No
	 * @return GetMissionVO
	 * 任務"結束"，傳入任務編號會找出該VO並設定狀態5，並裝入現在時間。
	 */
	public GetMissionVO missionFinish(String mission_No) {
		// 找出任務VO
		GetMissionVO getMissionVO = dao.findByPrimaryKey(mission_No);
		// 狀態:已完成
		getMissionVO.setMission_State(5);
		// 取得現在時間
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		getMissionVO.setMission_End_Time(timestamp);
		dao.update(getMissionVO);
		return getMissionVO;
	}
	
	public GetMissionVO missionDisputeCase(String mission_No) {
		// 找出任務VO
		GetMissionVO getMissionVO = dao.findByPrimaryKey(mission_No);
		// 狀態:已完成
		getMissionVO.setMission_State(8);
		// 取得現在時間
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		getMissionVO.setMission_End_Time(timestamp);
		dao.update(getMissionVO);
		return getMissionVO;
	}

	public String addMissionReturnKey(
			
			String mission_Category,
			String mission_Name,
			String mission_Des,
			String issuer_Mem_No,
			String takecase_Mem_No,
			Timestamp mission_Release_Time,
			Timestamp mission_Due_Time,
			Timestamp mission_Start_Time,
			Timestamp mission_End_Time,
			Integer mission_State,
			Integer mission_Pattern,
			Double mission_Pay,
			Double mission_Gps_Lat,
			Double mission_Gps_Lng) {

		GetMissionVO getMissionVO = new GetMissionVO();

		
		getMissionVO.setMission_Category(mission_Category);
		getMissionVO.setMission_Name(mission_Name);
		getMissionVO.setMission_Des(mission_Des);
		getMissionVO.setIssuer_Mem_No(issuer_Mem_No);
		getMissionVO.setTakecase_Mem_No(takecase_Mem_No);
		getMissionVO.setMission_Release_Time(mission_Release_Time);
		getMissionVO.setMission_Due_Time(mission_Due_Time);
		getMissionVO.setMission_Start_Time(mission_Start_Time);
		getMissionVO.setMission_End_Time(mission_End_Time);
		getMissionVO.setMission_State(mission_State);
		getMissionVO.setMission_Pattern(mission_Pattern);
		getMissionVO.setMission_Pay(mission_Pay);
		getMissionVO.setMission_Gps_Lat(mission_Gps_Lat);
		getMissionVO.setMission_Gps_Lng(mission_Gps_Lng);
		
		String key = dao.insertReturnKey(getMissionVO);

		return key;
	}

}
