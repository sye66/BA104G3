package com.ach_detail.model;

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

import com.ach_detail.model.Ach_DetailVO;


public class Ach_DetailDAO implements Ach_DetailDAO_interface{
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
			"INSERT INTO ACH_DETAIL(MEM_NO,ACH_NO,ACH_TIME)VALUES(?,?,?)";
	private static final String GET_ALL = 
			"SELECT MEM_NO,ACH_NO,ACH_TIME FROM ACH_DETAIL order by MEM_NO";
	private static final String GET_ONE = 
			"SELECT MEM_NO,ACH_NO,ACH_TIME FROM ACH_DETAIL where MEM_NO = ?";
	private static final String DELETE = 
			"DELETE FROM ACH_DETAIL where MEM_NO = ?";
	private static final String GETPERSONAL =
			"select mem_no,ach_no,TO_CHAR(ACH_TIME,'YYYY-MM-DD') ACH_TIME from ach_detail where mem_no=?";
	
	@Override
	public void insert(Ach_DetailVO ach_detailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);

			pstmt.setString(1, ach_detailVO.getMem_No());
			pstmt.setString(2, ach_detailVO.getAch_No());
			pstmt.setDate(3, ach_detailVO.getAch_Time());

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
	public Ach_DetailVO findByPrimaryKey(String mem_No) {
		
		Ach_DetailVO ach_DetailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setString(1, mem_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				ach_DetailVO = new Ach_DetailVO();
				ach_DetailVO.setMem_No(rs.getString("mem_No"));
				ach_DetailVO.setAch_No(rs.getString("ach_No"));
				ach_DetailVO.setAch_Time(rs.getDate("ach_Time"));
				
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
		return ach_DetailVO;
	}

	@Override
	public List<Ach_DetailVO> getAll() {
		List<Ach_DetailVO> list = new ArrayList<Ach_DetailVO>();
		Ach_DetailVO ach_DetailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO �]�٬� Domain objects
				ach_DetailVO = new Ach_DetailVO();
				ach_DetailVO.setMem_No(rs.getString("mem_No"));
				ach_DetailVO.setAch_No(rs.getString("ach_No"));
				ach_DetailVO.setAch_Time(rs.getDate("ach_Time"));
				list.add(ach_DetailVO); // Store the row in the list
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
	public void delete(String mem_No) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, mem_No);

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
	public List<Ach_DetailVO> getPersonal(String mem_No) {
		List<Ach_DetailVO> list = new ArrayList<Ach_DetailVO>();
		Ach_DetailVO ach_DetailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GETPERSONAL);

			pstmt.setString(1, mem_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				ach_DetailVO = new Ach_DetailVO();
				ach_DetailVO.setMem_No(rs.getString("mem_No"));
				ach_DetailVO.setAch_No(rs.getString("ach_No"));
				ach_DetailVO.setAch_Time(rs.getDate("ach_Time"));
				list.add(ach_DetailVO);
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