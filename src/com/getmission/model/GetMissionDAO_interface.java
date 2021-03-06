package com.getmission.model;

import java.util.*;

public interface GetMissionDAO_interface {
          public void insert(GetMissionVO getMissionVO);
          public void update(GetMissionVO getMissionVO);
          public void delete(String mission_No);
          public void takeMission(GetMissionVO getMissionVO);
          public GetMissionVO findByPrimaryKey(String mission_No);
          public List<GetMissionVO> getAll();
          public List<GetMissionVO> getAllValidMission();//拿可接全部任務
          public List<GetMissionVO> getOkAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
          public List<GetMissionVO> getAll(Map<String, String[]> map); 
          public List<GetMissionVO> findIssuerCase(String issuer_Mem_No);
          public List<GetMissionVO> successGetMission(String takecase_Mem_No);
          public List<GetMissionVO> findByMem(String mem_No);
          public List<GetMissionVO> findByMem(String mem_No, Integer mission_Status);
          public String insertReturnKey(GetMissionVO getMissionVO);
}
