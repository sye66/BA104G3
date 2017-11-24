package com.android.model;

import java.util.*;

public interface AccuseCaseDAO_interface {
          public void insert(AccuseCaseVO accuseCaseVO);
          public void update(AccuseCaseVO accuseCaseVO);
          public void delete(String accuse_No);
          public AccuseCaseVO findByPrimaryKey(String accuse_No);
          public List<AccuseCaseVO> getAll();
          //?��?��????�詢(?��?��???��????Map)(???? List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
