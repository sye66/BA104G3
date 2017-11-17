package com.casecandidate.model;

import java.util.*;

public interface CaseCandidateDAO_interface {
          public void insert(CaseCandidateVO caseCandidateVO);
          public void update(CaseCandidateVO caseCandidateVO);
          public void delete(String candidate_Mem_No, String mission_No);
          public void deleteOneCase(String mission_No);
          public List<CaseCandidateVO> findByMission(String mission_No);
          public List<CaseCandidateVO> findByCandidate(String candidate_Mem_No);
          
          public List<CaseCandidateVO> getAll();

}
