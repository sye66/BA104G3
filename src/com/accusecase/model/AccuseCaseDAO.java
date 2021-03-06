package com.accusecase.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class AccuseCaseDAO implements AccuseCaseDAO_interface {

	//  一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
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
		"INSERT INTO accuse_case (accuse_no,mission_no,accuser_no,emp_no,accuse_date,accuse_detail,accuse_state) VALUES (to_char(sysdate,'yyyy-mm-dd')||'ACC'||LPAD(to_char(ACCUSE_SEQ.NEXTVAL),7,'0'), ?, ?, ?, sysdate, ?,?)";
	private static final String GET_ALL_STMT = 
		"SELECT accuse_no,mission_no,accuser_no,emp_no,to_char(accuse_date,'yyyy-mm-dd hh:mm:ss') accuse_date,to_char(close_case_date,'yyyy-mm-dd hh:mm:ss') close_case_date,accuse_detail,accuse_state FROM accuse_case order by accuse_no";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM accuse_case where accuse_no = ?";
	private static final String DELETE = 
		"DELETE FROM accuse_case where accuse_no = ?";
	private static final String UPDATE = 
		"UPDATE accuse_case set mission_no= nvl(?,mission_no), accuser_no= nvl(?,accuser_no), emp_no= nvl(?,emp_no), accuse_date= nvl(?,accuse_date), close_case_date= nvl(?,close_case_date), accuse_detail= nvl(?,accuse_detail), accuse_state= nvl(?,accuse_state) where accuse_no = ?";

	private static final String GET_ONE_ACCUSECASE =
			"select *from accuse_case where mission_No = ? and accuser_No = ?";
	private static final String GET_ACCUSECASE_BY_MISSION=
			"SELECT * FROM ACCUSE_CASE WHERE MISSION_NO=?" ;
	private static final String NOTFINISH_ACCUSECASE_BY_MISSION=
			"SELECT * FROM ACCUSE_CASE WHERE MISSION_NO=? AND ACCUSE_STATE=?" ;
	@Override
	public void insert(AccuseCaseVO accuseCaseVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, accuseCaseVO.getMission_No());
			pstmt.setString(2, accuseCaseVO.getAccuser_No());
			pstmt.setString(3, accuseCaseVO.getEmp_No());
//			pstmt.setTimestamp(4, accuseCaseVO.getAccuse_Date());
//			pstmt.setTimestamp(4, accuseCaseVO.getClose_Case_Date());
			pstmt.setString(4, accuseCaseVO.getAccuse_Detail());
			pstmt.setInt(5, accuseCaseVO.getAccuse_State());

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
	public void update(AccuseCaseVO accuseCaseVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, accuseCaseVO.getMission_No());
			pstmt.setString(2, accuseCaseVO.getAccuser_No());
			pstmt.setString(3, accuseCaseVO.getEmp_No());
			pstmt.setTimestamp(4, accuseCaseVO.getAccuse_Date());
			pstmt.setTimestamp(5, accuseCaseVO.getClose_Case_Date());
			pstmt.setString(6, accuseCaseVO.getAccuse_Detail());
			pstmt.setInt(7, accuseCaseVO.getAccuse_State());
			pstmt.setString(8, accuseCaseVO.getAccuse_No());

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
	public void delete(String accuse_No) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, accuse_No);

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
	public AccuseCaseVO findByPrimaryKey(String accuse_No) {

		AccuseCaseVO accuseCaseVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, accuse_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為Domain objects
				accuseCaseVO = new AccuseCaseVO();
				accuseCaseVO.setAccuse_No(rs.getString("accuse_no"));
				accuseCaseVO.setMission_No(rs.getString("mission_no"));
				accuseCaseVO.setAccuser_No(rs.getString("accuser_no"));
				accuseCaseVO.setEmp_No(rs.getString("emp_no"));
				accuseCaseVO.setAccuse_Date(rs.getTimestamp("accuse_date"));
				accuseCaseVO.setClose_Case_Date(rs.getTimestamp("close_case_date"));
				accuseCaseVO.setAccuse_Detail(rs.getString("accuse_detail"));
				accuseCaseVO.setAccuse_State(rs.getInt("accuse_state"));
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
		return accuseCaseVO;
	}

	@Override
	public List<AccuseCaseVO> getAll() {
		List<AccuseCaseVO> list = new ArrayList<AccuseCaseVO>();
		AccuseCaseVO accuseCaseVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				accuseCaseVO = new AccuseCaseVO();
				accuseCaseVO.setAccuse_No(rs.getString("accuse_no"));
				accuseCaseVO.setMission_No(rs.getString("mission_no"));
				accuseCaseVO.setAccuser_No(rs.getString("accuser_no"));
				accuseCaseVO.setEmp_No(rs.getString("emp_no"));
				accuseCaseVO.setAccuse_Date(rs.getTimestamp("accuse_date"));
				accuseCaseVO.setClose_Case_Date(rs.getTimestamp("close_case_date"));
				accuseCaseVO.setAccuse_Detail(rs.getString("accuse_detail"));
				accuseCaseVO.setAccuse_State(rs.getInt("accuse_state"));
				list.add(accuseCaseVO); // Store the row in the list
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
	
	@Override
	public List<AccuseCaseVO> getCaseBymission(String mission_No) {
		List<AccuseCaseVO> list = new ArrayList<AccuseCaseVO>();
		AccuseCaseVO accuseCaseVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ACCUSECASE_BY_MISSION);
			pstmt.setString(1, mission_No);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				accuseCaseVO = new AccuseCaseVO();
				accuseCaseVO.setAccuse_No(rs.getString("accuse_no"));
				accuseCaseVO.setMission_No(rs.getString("mission_no"));
				accuseCaseVO.setAccuser_No(rs.getString("accuser_no"));
				accuseCaseVO.setEmp_No(rs.getString("emp_no"));
				accuseCaseVO.setAccuse_Date(rs.getTimestamp("accuse_date"));
				accuseCaseVO.setClose_Case_Date(rs.getTimestamp("close_case_date"));
				accuseCaseVO.setAccuse_Detail(rs.getString("accuse_detail"));
				accuseCaseVO.setAccuse_State(rs.getInt("accuse_state"));
				list.add(accuseCaseVO); // Store the row in the list
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
	
	
	@Override
	public List<AccuseCaseVO> getCaseByNotFinishmission(String mission_No,Integer accuse_State) {
		List<AccuseCaseVO> list = new ArrayList<AccuseCaseVO>();
		AccuseCaseVO accuseCaseVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(NOTFINISH_ACCUSECASE_BY_MISSION);
			pstmt.setString(1, mission_No);
			pstmt.setInt(2, accuse_State);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				accuseCaseVO = new AccuseCaseVO();
				accuseCaseVO.setAccuse_No(rs.getString("accuse_no"));
				accuseCaseVO.setMission_No(rs.getString("mission_no"));
				accuseCaseVO.setAccuser_No(rs.getString("accuser_no"));
				accuseCaseVO.setEmp_No(rs.getString("emp_no"));
				accuseCaseVO.setAccuse_Date(rs.getTimestamp("accuse_date"));
				accuseCaseVO.setClose_Case_Date(rs.getTimestamp("close_case_date"));
				accuseCaseVO.setAccuse_Detail(rs.getString("accuse_detail"));
				accuseCaseVO.setAccuse_State(rs.getInt("accuse_state"));
				list.add(accuseCaseVO); // Store the row in the list
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
	
	@Override
	public AccuseCaseVO getOneAccusecase(String mission_No,String Accuser_No) {

		AccuseCaseVO accuseCaseVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_ACCUSECASE);

			pstmt.setString(1, mission_No);
			pstmt.setString(2, Accuser_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為Domain objects
				accuseCaseVO = new AccuseCaseVO();
				accuseCaseVO.setAccuse_No(rs.getString("accuse_no"));
				accuseCaseVO.setMission_No(rs.getString("mission_no"));
				accuseCaseVO.setAccuser_No(rs.getString("accuser_no"));
				accuseCaseVO.setEmp_No(rs.getString("emp_no"));
				accuseCaseVO.setAccuse_Date(rs.getTimestamp("accuse_date"));
				accuseCaseVO.setClose_Case_Date(rs.getTimestamp("close_case_date"));
				accuseCaseVO.setAccuse_Detail(rs.getString("accuse_detail"));
				accuseCaseVO.setAccuse_State(rs.getInt("accuse_state"));
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
		return accuseCaseVO;
	}
}