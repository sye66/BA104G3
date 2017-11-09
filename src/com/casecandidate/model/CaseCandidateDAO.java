package com.casecandidate.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CaseCandidateDAO implements CaseCandidateDAO_interface {

	// �@�����ε{����,�w��@�Ӹ�Ʈw ,�@�Τ@��DataSource�Y�i
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = 
		"INSERT INTO case_candidate (candidate_mem_no,mission_no) VALUES (?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT candidate_mem_no,mission_no FROM case_candidate order by candidate_mem_no , mission_no";
	private static final String GET_ONE_MISSION = 
		"SELECT CD.MISSION_NO, M.MISSION_NAME, M.ISSUER_MEM_NO,CD.CANDIDATE_MEM_NO, ME.MEM_NAME FROM CASE_CANDIDATE CD JOIN MISSION M ON CD.MISSION_NO = M.MISSION_NO JOIN MEM ME ON  CD.CANDIDATE_MEM_NO = ME.MEM_NOWHERE CD.MISSION_NO = ?";
	private static final String DELETE = 
		"DELETE FROM case_candidate where candidate_mem_no=?,mission_no = ?";
	private static final String UPDATE = 
		"UPDATE case_candidate set candidate_mem_no=?, mission_no=? where candidate_mem_no=? and mission_no = ?";
	private static final String GET_ONE_CANDIDATE = 
		"SELECT candidate_mem_no,mission_no FROM case_candidate where  candidate_mem_no = ?";
	
	
	@Override
	public void insert(CaseCandidateVO caseCandidateVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, caseCandidateVO.getCandidate_Mem_No());
			pstmt.setString(2, caseCandidateVO.getMission_No());
			

			pstmt.executeUpdate();

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
	public void update(CaseCandidateVO caseCandidateVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, caseCandidateVO.getCandidate_Mem_No());
			pstmt.setString(2, caseCandidateVO.getMission_No());
			

			pstmt.executeUpdate();

			// Handle any driver errors
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
	public void delete(String candidate_Mem_No,String mission_No) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1,candidate_Mem_No );
			pstmt.setString(2, mission_No);

			pstmt.executeUpdate();

			// Handle any driver errors
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
	public CaseCandidateVO findByMission(String mission_No) {

		CaseCandidateVO caseCandidateVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_MISSION);

			pstmt.setString(1, mission_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為Domain objects
				caseCandidateVO = new CaseCandidateVO();
				caseCandidateVO.setCandidate_Mem_No(rs.getString("candidate_Mem_No"));
				caseCandidateVO.setMem_Name(rs.getString("mem_Name"));
				caseCandidateVO.setMission_No(rs.getString("mission_No"));
				caseCandidateVO.setMission_Name(rs.getString("mission_Name"));
				caseCandidateVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
				
				
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return caseCandidateVO;
	}

	@Override
	public CaseCandidateVO findByCandidate(String candidate_Mem_No) {

		CaseCandidateVO caseCandidateVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_MISSION);

			pstmt.setString(1, candidate_Mem_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				caseCandidateVO = new CaseCandidateVO();
				caseCandidateVO.setCandidate_Mem_No(rs.getString("candidate_Mem_No"));
				caseCandidateVO.setMission_No(rs.getString("mission_No"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return caseCandidateVO;
	}
	
	@Override
	public List<CaseCandidateVO> getAll() {
		List<CaseCandidateVO> list = new ArrayList<CaseCandidateVO>();
		CaseCandidateVO caseCandidateVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO �]�٬� Domain objects
				caseCandidateVO = new CaseCandidateVO();
				caseCandidateVO.setCandidate_Mem_No(rs.getString("candidate_Mem_No"));
				caseCandidateVO.setMission_No(rs.getString("mission_No"));
				list.add(caseCandidateVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return list;
	}
}