package com.android.model;


import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;


public class MissionService {
	
	private MissionDAO_interface dao;

	public MissionService() {
		dao = new MissionDAO();
	}
	
	public MissionVO addMission(String mission_Category, String mission_Name, String mission_Des, String issuer_Mem_No, String takecase_Mem_No, Timestamp mission_Release_Time, Timestamp mission_Due_Time, Timestamp mission_Start_Time, Timestamp mission_End_Time, Integer mission_State, Integer mission_Pattern, Double mission_Pay, Double mission_Gps_Lat, Double mission_Gps_Lng ){
		MissionVO mission = new MissionVO();
		
		mission.setMission_Category(mission_Category);
		mission.setMission_Name(mission_Name);
		mission.setMission_Des(mission_Des);
		mission.setIssuer_Mem_No(issuer_Mem_No);
//		mission.setTakecase_Mem_No(takecase_Mem_No);
		mission.setMission_Release_Time(mission_Release_Time);
		mission.setMission_Due_Time(mission_Due_Time);
//		mission.setMission_Start_Time(mission_Start_Time);
//		mission.setMission_End_Time(mission_End_Time);
		mission.setMission_State(mission_State);
		mission.setMission_Pattern(mission_Pattern);
		mission.setMission_Pay(mission_Pay);
		mission.setMission_Gps_Lat(mission_Gps_Lat);
		mission.setMission_Gps_Lng(mission_Gps_Lng);
		dao.insert(mission);
		return  mission;
		
	}
	
	public MissionVO updateMission(String mission_No, String mission_Category, String mission_Des, String mission_Name, String issuer_Mem_No, String takecase_Mem_No, Timestamp mission_Release_Time, Timestamp mission_Due_Time, Timestamp mission_Start_Time, Timestamp mission_End_Time, Integer mission_State, Integer mission_Pattern, Double mission_Pay, Double mission_Gps_Lat, Double mission_Gps_Lng ){
		MissionVO mission = new MissionVO();
		
		mission.setMission_No(mission_No);
		mission.setMission_Category(mission_Category);
		mission.setMission_Des(mission_Des);
		mission.setMission_Name(mission_Name);
		mission.setIssuer_Mem_No(issuer_Mem_No);
		mission.setTakecase_Mem_No(takecase_Mem_No);
		mission.setMission_Release_Time(mission_Release_Time);
		mission.setMission_Due_Time(mission_Due_Time);
		mission.setMission_Start_Time(mission_Start_Time);
		mission.setMission_End_Time(mission_End_Time);
		mission.setMission_State(mission_State);
		mission.setMission_Pattern(mission_Pattern);
		mission.setMission_Pay(mission_Pay);
		mission.setMission_Gps_Lat(mission_Gps_Lat);
		mission.setMission_Gps_Lng(mission_Gps_Lng);
		dao.update(mission);
		return mission;
		
	}
	
	
	public void deleteMission(String mission_No) {
		dao.delete(mission_No);
	}

	public MissionVO getOneMission(String mission_No) {
		return dao.findByPrimaryKey(mission_No);
	}

	public List<MissionVO> getAll() {
		return dao.getAll();
	}
	
	public List<MissionVO> getMissionByKeyword(String keyword, String keyvalue){
		return dao.getMissionByKeyword(keyword, keyvalue);
	}

}
