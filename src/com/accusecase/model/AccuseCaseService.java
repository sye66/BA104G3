package com.accusecase.model;

import java.util.List;

public class AccuseCaseService {

	private AccuseCaseDAO_interface dao;

	public AccuseCaseService() {
		dao = new AccuseCaseDAO();
	}

	public AccuseCaseVO addAccuseCase( String mission_No,String accuser_No,String emp_No,
			 String accuse_Detail, Integer accuse_State) {

		AccuseCaseVO accuseCaseVO = new AccuseCaseVO();

		
		accuseCaseVO.setMission_No(mission_No);
		accuseCaseVO.setAccuser_No(accuser_No);
		accuseCaseVO.setEmp_No(emp_No);
		accuseCaseVO.setAccuse_Detail(accuse_Detail);
		accuseCaseVO.setAccuse_State(accuse_State);
		dao.insert(accuseCaseVO);

		return accuseCaseVO;
	}

	public AccuseCaseVO updateAccuseCase(String accuse_No, String mission_No,String accuser_No,String emp_No, java.sql.Timestamp accuse_Date,
			java.sql.Timestamp close_Case_Date, String accuse_Detail, Integer accuse_State) {

		AccuseCaseVO accuseCaseVO = new AccuseCaseVO();

		accuseCaseVO.setAccuse_No(accuse_No);
		accuseCaseVO.setMission_No(mission_No);
		accuseCaseVO.setAccuser_No(accuser_No);
		accuseCaseVO.setEmp_No(emp_No);
		accuseCaseVO.setAccuse_Date(accuse_Date);
		accuseCaseVO.setClose_Case_Date(close_Case_Date);
		accuseCaseVO.setAccuse_Detail(accuse_Detail);
		accuseCaseVO.setAccuse_State(accuse_State);
		dao.update(accuseCaseVO);

		return accuseCaseVO;
	}

	public void deleteAccuseCase(String accuse_No) {
		dao.delete(accuse_No);
	}

	public AccuseCaseVO getOneAccuseCase(String accuse_No) {
		return dao.findByPrimaryKey(accuse_No);
	}
	
	public AccuseCaseVO getOneAccuseCaseBymissionAndmem(String mission_No,String Accuser_No) {
		return dao.getOneAccusecase(mission_No, Accuser_No);
	} 

	public List<AccuseCaseVO> getAll() {
		return dao.getAll();
	}
	
	public AccuseCaseVO updateAccuseCaseState(String mission_No,String accuser_No,
			  Integer accuse_State) {

		AccuseCaseVO accuseCaseVO = new AccuseCaseVO();

		accuseCaseVO.setAccuse_No(mission_No);
		accuseCaseVO.setAccuser_No(accuser_No);
		accuseCaseVO.setAccuse_State(accuse_State);
		dao.update(accuseCaseVO);

		return accuseCaseVO;
	}
	public List<AccuseCaseVO> getCaseBymission(String mission_No){
		return dao.getCaseBymission(mission_No);
	}
	
	public AccuseCaseVO updateAccuseCaseState(String accuse_No, Integer accuse_State) {

		AccuseCaseVO accuseCaseVO = new AccuseCaseVO();

		accuseCaseVO.setAccuse_No(accuse_No);
		
		accuseCaseVO.setAccuse_State(accuse_State);
		dao.update(accuseCaseVO);

		return accuseCaseVO;
	}
	
	public AccuseCaseVO updateAccuseCasebyemp(String accuse_No, String emp_No, Integer accuse_State) {

		AccuseCaseVO accuseCaseVO = new AccuseCaseVO();

		accuseCaseVO.setAccuse_No(accuse_No);
		accuseCaseVO.setEmp_No(emp_No);
		accuseCaseVO.setAccuse_State(accuse_State);
		dao.update(accuseCaseVO);

		return accuseCaseVO;
	}
	public List<AccuseCaseVO> getCaseByNotFinishmission(String mission_No,Integer accuse_State){
		return dao.getCaseByNotFinishmission(mission_No, accuse_State);
	}
}
