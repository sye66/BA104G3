package com.casecandidate.model;

import java.util.*;

public interface CaseCandidateDAO_interface {
          public void insert(CaseCandidateVO caseCandidateVO);
          public void update(CaseCandidateVO caseCandidateVO);
          public void delete(String candidate_Mem_No, String mission_No);
          public CaseCandidateVO findByMission(String mission_No);
          public CaseCandidateVO findByCandidate(String candidate_Mem_No);
          
          public List<CaseCandidateVO> getAll();

}
