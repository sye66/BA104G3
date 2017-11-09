package com.ach_detail.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;
import com.ach_detail.model.Ach_DetailVO;

public class Ach_DetailJdbcDAO implements Ach_DetailDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "BA104G3";
	
	private static final String INSERT = 
			"INSERT INTO ACH_DETAIL(MEM_NO,ACH_NO,ACH_TIME)VALUES(MEM_NO.NEXTVAL,ACH_SEQ.NEXTVAL,?)";
	private static final String GET_ALL = 
			"SELECT MEM_NO,ACH_NO,TO_CHAR(ACH_TIME,'YYYY-MM-DD') ACH_TIME FROM Ach_Detail order by MEM_NO";
	private static final String GET_ONE = 
			"SELECT MEM_NO,ACH_NO,TO_CHAR(ACH_TIME,'YYYY-MM-DD') ACH_TIME FROM Ach_Detail where MEM_NO = ?";
	private static final String DELETE = 
			"DELETE FROM Ach_Detail where MEM_NO = ?";

	

	@Override
	public void insert(Ach_DetailVO ach_DetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setDate(1,ach_DetailVO.getAch_Time());
			
			pstmt.executeUpdate();
			
		}catch (ClassNotFoundException e) {
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
	public void delete(String mem_No) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, mem_No);

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
	public Ach_DetailVO findByPrimaryKey(String mem_No) {
		Ach_DetailVO ach_DetailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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
	
	
	public static void main(String[] args) {
		
		Ach_DetailJdbcDAO dao = new Ach_DetailJdbcDAO();
		
		Ach_DetailVO ach_DetailVO = new Ach_DetailVO();
		
		
		ach_DetailVO.setAch_Time(java.sql.Date.valueOf("2017-03-30"));
		dao.insert(ach_DetailVO);
		
		//do.delete();
		
		// 查詢
		Ach_DetailVO ach_DetailVO3 = dao.findByPrimaryKey("M000001");
		System.out.print(ach_DetailVO3.getMem_No() + ",");
		System.out.print(ach_DetailVO3.getAch_No() + ",");
		System.out.print(ach_DetailVO3.getAch_Time());
		
		System.out.println("---------------------");

		// 查詢
		List<Ach_DetailVO> list = dao.getAll();
		for (Ach_DetailVO ach_DetailVO4 : list) {
			System.out.print(ach_DetailVO4.getMem_No() + ",");
			System.out.print(ach_DetailVO4.getAch_No() + ",");
			System.out.print(ach_DetailVO4.getAch_Time() + ",");
			
			System.out.println();
		}
	}

}
