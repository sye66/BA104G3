package com.android.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Case_CandidateDAO implements Case_CandidateDAO_interface{
	static String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userid = "BA104G3";
	String passwd = "123456";

	
	static {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		}
		
	}
	

//	private static DataSource ds = null;
//	static {
//		try {
//			Context ctx = new InitialContext();
//			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
//		} catch (NamingException e) {
//			e.printStackTrace();
//		}
//	}
	
	private static final String INSERT_CASE_CANDIDATE = "INSERT INTO CASE_CANDIDATE(CANDIDATE_MEM_NO ,MISSION_NO ,ISSUER_INVITING) VALUES( ?, ? ,? )";
	private static final String GET_ALL_MISSION_NO_BY_CANDIDATE_MEM_NO = "SELECT MISSION_NO FROM CASE_CANDIDATE WHERE CANDIDATE_MEM_NO=? ";
	//�[���A
	private static final String GET_ALL_CANDIDATE_MEM_NO_BY_MISSION_NO = "SELECT CANDIDATE_MEM_NO FROM CASE_CANDIDATE WHERE MISSION_NO=?";
	private static final String DELETE_CASE_CANDIDATE = "DELETE FROM CASE_CANDIDATE WHERE CANDIDATE_MEM_NO = ? AND MISSION_NO = ? ";
	private static final String DELETE_BY_MISSION_NO = "DELETE FROM CASE_CANDIDATE WHERE MISSION_NO = ? ";
	
	
	@Override
	public void insertCaseCandidate(Case_CandidateVO case_CandidateVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_CASE_CANDIDATE);


			pstmt.setString(1, case_CandidateVO.getCandidate_Mem_No());
			pstmt.setString(2, case_CandidateVO.getMission_No());
			pstmt.setInt(3, case_CandidateVO.getIssuer_Inviting());
			

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}


	@Override
	public List<String> getAllMissionNoByCandidateMemNo(String candidate_Mem_No) {
		List<String> mission_NoList = new ArrayList();
		String mission_No;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_MISSION_NO_BY_CANDIDATE_MEM_NO);
			pstmt.setString(1, candidate_Mem_No);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				mission_No = rs.getString("mission_No");
				mission_NoList.add(mission_No);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return mission_NoList;
	}
	
	public List<String> getAllMissionNoByCandidateMemNo1(String candidate_Mem_No) {
		List<String> mission_NoList = new ArrayList();
		String mission_No;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_MISSION_NO_BY_CANDIDATE_MEM_NO + " AND ISSUER_INVITING =1 ");
			pstmt.setString(1, candidate_Mem_No);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				mission_No = rs.getString("mission_No");
				mission_NoList.add(mission_No);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return mission_NoList;
	}
	
	public List<String> getAllMissionNoByCandidateMemNo2(String candidate_Mem_No) {
		List<String> mission_NoList = new ArrayList();
		String mission_No;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_MISSION_NO_BY_CANDIDATE_MEM_NO+ " AND ISSUER_INVITING =2");
			pstmt.setString(1, candidate_Mem_No);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				mission_No = rs.getString("mission_No");
				mission_NoList.add(mission_No);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return mission_NoList;
	}
	
	public List<String> getAllCandidateMemNoByMissionNo(String mission_No) {
		List<String> candidate_Mem_NoList = new ArrayList();
		String candidate_Mem_No;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_CANDIDATE_MEM_NO_BY_MISSION_NO);
			pstmt.setString(1, mission_No);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				candidate_Mem_No = rs.getString("candidate_Mem_No");
				candidate_Mem_NoList.add(candidate_Mem_No);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return candidate_Mem_NoList;
	}
	
	
	public void deleteCaseCandidate(Case_CandidateVO case_CandidateVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE_CASE_CANDIDATE);


			pstmt.setString(1, case_CandidateVO.getCandidate_Mem_No());
			pstmt.setString(2, case_CandidateVO.getMission_No());
			

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	
	public void deleteByMissionNo (String mission_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE_BY_MISSION_NO);


			
			pstmt.setString(1, mission_No);
			

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}


	



}
