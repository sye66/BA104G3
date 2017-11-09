package com.getmission.model;

import java.util.*;

public interface GetMissionDAO_interface {
          public void insert(GetMissionVO getMissionVO);
          public void update(GetMissionVO getMissionVO);
          public void delete(String mission_No);
          public void takeMission(GetMissionVO getMissionVO);
          public GetMissionVO findByPrimaryKey(String mission_No);
          public List<GetMissionVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
