package com.achieve.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.achieve.model.AchieveVO;

public class AchieveDAO implements AchieveDAO_interface{
	
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
			"INSERT INTO ACHIEVE(ACH_NO,ACH_NAME,ACH_PICTURE,ACH_EXPLAIN)VALUES('AC'||LPAD(MEM_NO.NEXTVAL,6,'0'),?,?,?)";
	private static final String GET_ALL = 
			"SELECT ACH_NO,ACH_NAME,ACH_PICTURE,ACH_EXPLAIN FROM ACHIEVE order by ACH_NO";
	private static final String GET_ONE = 
			"SELECT ACH_NO,ACH_NAME,ACH_PICTURE,ACH_EXPLAIN FROM ACHIEVE where ACH_NO = ?";
	private static final String UPDATE = 
			"UPDATE ACHIEVE set ACH_NAME=?, ACH_PICTURE=?,ACH_EXPLAIN=? where ACH_NO = ?";
	private static final String DELETE = 
			"DELETE FROM ACHIEVE where ACH_NO = ?";
	
	
	@Override
	public void insert(AchieveVO achieveVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);

			pstmt.setString(1, achieveVO.getAch_Name());
			pstmt.setBytes(2, achieveVO.getAch_Picture());
			pstmt.setString(3, achieveVO.getAch_Explain());
			
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
	public void update(AchieveVO achieveVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, achieveVO.getAch_Name());
			pstmt.setBytes(2, achieveVO.getAch_Picture());
			pstmt.setString(3, achieveVO.getAch_Explain());
			pstmt.setString(4, achieveVO.getAch_No());
			
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
	public AchieveVO findByPrimaryKey(String ach_No) {
		AchieveVO achieveVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setString(1, ach_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				achieveVO = new AchieveVO();
				achieveVO.setAch_No(rs.getString("ach_No"));
				achieveVO.setAch_Name(rs.getString("ach_Name"));
				achieveVO.setAch_Picture(rs.getBytes("ach_Picture"));
				achieveVO.setAch_Explain(rs.getString("ach_Explain"));
				
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
		return achieveVO;
	}

	@Override
	public List<AchieveVO> getAll() {
		List<AchieveVO> list = new ArrayList<AchieveVO>();
		AchieveVO achieveVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO �]�٬� Domain objects
				achieveVO = new AchieveVO();
				achieveVO.setAch_No(rs.getString("ach_No"));
				achieveVO.setAch_Name(rs.getString("ach_Name"));
				achieveVO.setAch_Picture(rs.getBytes("ach_Picture"));
				achieveVO.setAch_Explain(rs.getString("ach_Explain"));
				list.add(achieveVO); // Store the row in the list
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
	public void delete(String ach_No) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, ach_No);

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
}