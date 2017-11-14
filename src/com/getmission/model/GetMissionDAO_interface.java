package com.getmission.model;

import java.util.*;

public interface GetMissionDAO_interface {
          public void insert(GetMissionVO getMissionVO);
          public void update(GetMissionVO getMissionVO);
          public void delete(String mission_No);
          public void takeMission(GetMissionVO getMissionVO);
          public GetMissionVO findByPrimaryKey(String mission_No);
          public List<GetMissionVO> getAll();
          
          
          /**
           * @author Sander
           * 用會員去搜尋他的所有的Mission，以狀態做區隔
           * @param 發案人會員編號
           * @param 任務狀態，可以查詢待接案或是已結案
           */
          public List<GetMissionVO> findByMem(String issuer_Mem_no, Integer mission_Status);
          
      	  /**
           * @author Sander
           * Overload findByMem，直接抓出這個會員所有的任務，不分狀態
           * @param 發案人會員編號
           */
          public List<GetMissionVO> findByMem(String issuer_Mem_no);
          
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
