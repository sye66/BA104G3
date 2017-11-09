package com.rank.model;

import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class RankDAO implements RankDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT = 
			"INSERT INTO RANK(mem_No,day_Number_Rank,day_Score_Rank,week_Number_Rank,month_Number_Rank,season_Number_Rank,week_Score_Rank,month_Score_Rank,season_Score_Rank)VALUES(?,?,?,?,?,?,?,?,?)";
	private static final String GET_ALL = 
			"SELECT EMP_NO,EMP_NAME,EMP_PWD,EMP_MAIL,EMP_JOB,EMP_PHONE,EMP_STATE FROM EMP order by EMP_NO";
	private static final String GET_ONE = 
			"SELECT EMP_NO,EMP_NAME,EMP_PWD,EMP_MAIL,EMP_JOB,EMP_PHONE,EMP_STATE FROM EMP where EMP_NO = ?";
	private static final String UPDATE = 
			"UPDATE RANK set EMP_NAME=?, EMP_PWD=?, EMP_MAIL=?, EMP_JOB=?, EMP_PHONE=?, EMP_STATE=? where EMP_NO = ?";
	private static final String DELETE = 
			"DELETE FROM emp2 where empno = ?";

	@Override
	public void insert(RankVO rankVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(RankVO rankVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public RankVO findByPrimaryKey(String mem_No) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<RankVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(String mem_No) {
		// TODO Auto-generated method stub
		
	}

}
