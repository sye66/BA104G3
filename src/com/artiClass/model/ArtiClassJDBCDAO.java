package com.artiClass.model;

import java.sql.*;
import java.util.*;

import com.artiForm.model.ArtiFormVO;

public class ArtiClassJDBCDAO implements ArtiClassDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO ARTI_CLASS (ARTI_CLS_NO,ARTI_CLS_NAME) VALUES (ARTI_CLASS_seq.NEXTVAL, ?)";
	private static final String GET_ALL_STMT = "SELECT ARTI_CLS_NO, ARTI_CLS_NAME FROM ARTI_CLASS";
	private static final String GET_ONE_STMT = "SELECT ARTI_CLS_NO, ARTI_CLS_NAME FROM ARTI_CLASS where ARTI_CLS_NO = ?";
	private static final String GET_ARTI_NO_By_CLS_NO= "SELECT ARTI_NO,MEM_NO,ARTI_TITLE,ARTI_LIKE,DESCRIBE,to_char(ARTI_TIME,'yyyy-mm-dd hh:mm:ss') ARTI_TIME,ARTI_PIC,ARTI_CLS_NO,ARTI_STATUS FROM ARTI_CLASS where ARTI_CLS_NO = ? order by ARTI_NO";
	
	private static final String DELETE_ARTI_NO = "DELETE FROM ARTI_NO where ARTI_CLS_NO = ?";
	private static final String DELETE_ARTI_CLS_NO = "DELETE FROM ARTI_CLASS where ARTI_CLS_NO = ?";	
	
	private static final String UPDATE = "UPDATE ARTI_CLASS set ARTI_CLS_NAME=? where ARTI_CLS_NO = ?";

	@Override
	public void insert(ArtiClassVO artiClassVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, artiClassVO.getArti_Cls_No());
			pstmt.setString(2, artiClassVO.getArti_Cls_Name());

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
	public void update(ArtiClassVO artiClassVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, artiClassVO.getArti_Cls_No());
			pstmt.setString(2, artiClassVO.getArti_Cls_Name());

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
	public void delete(Integer arti_Cls_No) {
		int updateCount_arti_No = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);

			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);

			// 先刪除員工
			pstmt = con.prepareStatement(DELETE_ARTI_NO);
			pstmt.setInt(1, arti_Cls_No);
			updateCount_arti_No = pstmt.executeUpdate();
			// 再刪除部門
			pstmt = con.prepareStatement(DELETE_ARTI_CLS_NO);
			pstmt.setInt(1, arti_Cls_No);
			pstmt.executeUpdate();

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("刪除文章類別編號" + arti_Cls_No + "時,共有文章" + updateCount_arti_No
					+ "篇同時被刪除");
			
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public ArtiClassVO findByPrimaryKey(Integer arti_Cls_No) {

		ArtiClassVO artiClassVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, arti_Cls_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				artiClassVO = new ArtiClassVO();
				artiClassVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
				artiClassVO.setArti_Cls_Name(rs.getString("arti_Cls_Name"));
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
		return artiClassVO;
	}

	@Override
	public List<ArtiClassVO> getAll() {
		List<ArtiClassVO> list = new ArrayList<ArtiClassVO>();
		ArtiClassVO artiClassVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				artiClassVO = new ArtiClassVO();
				artiClassVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
				artiClassVO.setArti_Cls_Name(rs.getString("arti_Cls_Name"));
				list.add(artiClassVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public Set<ArtiFormVO> getArti_NoByArti_Cls_No(Integer arti_Cls_No) {
		Set<ArtiFormVO> set = new LinkedHashSet<ArtiFormVO>();
		ArtiFormVO artiFormVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ARTI_NO_By_CLS_NO);
			pstmt.setInt(1, arti_Cls_No);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				artiFormVO = new ArtiFormVO();
				artiFormVO.setArti_No(rs.getString("arti_No"));
				artiFormVO.setMem_No(rs.getString("men_No"));
				artiFormVO.setArti_Title(rs.getString("arti_Title"));
				artiFormVO.setArti_Like(rs.getInt("arti_Like"));
				artiFormVO.setDescribe(rs.getString("describe"));
				artiFormVO.setArti_Time(rs.getTimestamp("arti_Time"));
				artiFormVO.setArti_Pic(rs.getBytes("arti_Pic"));
				artiFormVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
				artiFormVO.setArti_Status(rs.getString("arti_Status"));
				set.add(artiFormVO); // Store the row in the vector
			}
	
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return set;
	}

	public static void main(String[] args) {

		ArtiClassJDBCDAO dao = new ArtiClassJDBCDAO();

		// 新增
//		DeptVO deptVO1 = new DeptVO();
//		deptVO1.setDname("製造部");
//		deptVO1.setLoc("中國江西");
//		dao.insert(deptVO1);

		// 修改
//		DeptVO deptVO2 = new DeptVO();
//		deptVO2.setDeptno(10);
//		deptVO2.setDname("財務部2");
//		deptVO2.setLoc("臺灣台北2");
//		dao.update(deptVO2);

		// 刪除
//		dao.delete(30);

		// 查詢
//		DeptVO deptVO3 = dao.findByPrimaryKey(10);
//		System.out.print(deptVO3.getDeptno() + ",");
//		System.out.print(deptVO3.getDname() + ",");
//		System.out.println(deptVO3.getLoc());
//		System.out.println("---------------------");

		// 查詢部門
		List<ArtiClassVO> list = dao.getAll();
		for (ArtiClassVO artiC : list) {
			System.out.print(artiC.getArti_Cls_No() + ",");
			System.out.print(artiC.getArti_Cls_Name() + ",");
			System.out.println();
		}
		
		// 查詢某部門的員工
		Set<ArtiFormVO> set = dao.getArti_NoByArti_Cls_No(10);
		for (ArtiFormVO artiF : set) {
			System.out.print(artiF.getArti_No() + ",");
			System.out.print(artiF.getMem_No() + ",");
			System.out.print(artiF.getArti_Title() + ",");
			System.out.print(artiF.getArti_Like() + ",");
			System.out.print(artiF.getDescribe() + ",");
			System.out.print(artiF.getArti_Time() + ",");
			System.out.print(artiF.getArti_Pic() + ",");
			System.out.print(artiF.getArti_Cls_No() + ",");
			System.out.print(artiF.getArti_Status());
			System.out.println();
		}
	}
}
