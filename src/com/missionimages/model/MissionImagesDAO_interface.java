package com.missionimages.model;

import java.util.*;

public interface MissionImagesDAO_interface {
          public void insert(MissionImagesVO missionImagesVO);
          public void update(MissionImagesVO missionImagesVO);
          public void delete(String image_No);
          public MissionImagesVO findByPrimaryKey(String image_No);
          public MissionImagesVO findIpopho(String mission_no ,String issuer_mem_no);
          public List<MissionImagesVO> getMissionpho(String mission_no);
          public List<MissionImagesVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
