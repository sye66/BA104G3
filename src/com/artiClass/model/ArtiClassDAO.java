package com.artiClass.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.artiForm.model.ArtiFormVO;

public class ArtiClassDAO implements ArtiClassDAO_interface {

	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO ARTI_CLASS (ARTI_CLS_NO,ARTI_CLS_NAME) VALUES (ARTI_CLASS_seq.NEXTVAL, ?)";
	private static final String GET_ALL_STMT = "SELECT ARTI_CLS_NO,ARTI_CLS_NAME FROM ARTI_CLASS";
	private static final String GET_ONE_STMT = "SELECT ARTI_CLS_NO,ARTI_CLS_NAME FROM ARTI_CLASS where ARTI_CLS_NO = ?";
	private static final String GET_ARTI_NO_By_CLS_NO= "SELECT ARTI_NO,MEM_NO,ARTI_TITLE,ARTI_LIKE,DESCRIBE,to_char(ARTI_TIME,'yyyy-mm-dd hh:mm:ss') ARTI_TIME,ARTI_PIC,ARTI_CLS_NO,ARTI_STATUS FROM ARTI_FORM where ARTI_CLS_NO = ? order by ARTI_NO";
	
	private static final String DELETE_ARTI_NO = "DELETE FROM ARTI_FORM where ARTI_CLS_NO = ?";
	private static final String DELETE_ARTI_CLASS = "DELETE FROM ARTI_CLASS where ARTI_CLS_NO = ?";	
	
	private static final String UPDATE = "UPDATE ARTI_CLASS set ARTI_CLS_NAME=? where ARTI_CLS_NO = ?";

	@Override
	public void insert(ArtiClassVO artiClassVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, artiClassVO.getArti_Cls_No());
			pstmt.setString(2, artiClassVO.getArti_Cls_Name());

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
	public void update(ArtiClassVO artiClassVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, artiClassVO.getArti_Cls_No());
			pstmt.setString(2, artiClassVO.getArti_Cls_Name());
			
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
	public void delete(Integer arti_Cls_No) {
		int updateCount_artiNo = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();

			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);

			// 先刪除員工
			pstmt = con.prepareStatement(DELETE_ARTI_NO);
			pstmt.setInt(1, arti_Cls_No);
			updateCount_artiNo = pstmt.executeUpdate();
			// 再刪除部門
			
			
			pstmt = con.prepareStatement(DELETE_ARTI_CLASS);
			pstmt.setInt(1, arti_Cls_No);
			pstmt.executeUpdate();

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("刪除文章類別編號" + arti_Cls_No + "時,共有文章" + updateCount_artiNo
					+ "篇同時被刪除");
			
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

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, arti_Cls_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				artiClassVO = new ArtiClassVO();
				artiClassVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
				artiClassVO.setArti_Cls_Name(rs.getString("arti_Cls_Name"));
			}

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

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				artiClassVO = new ArtiClassVO();
				artiClassVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
				artiClassVO.setArti_Cls_Name(rs.getString("arti_Cls_Name"));
				list.add(artiClassVO); // Store the row in the list
			}

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
		System.out.println("list.size()="+list.size());
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
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ARTI_NO_By_CLS_NO);
			pstmt.setInt(1, arti_Cls_No);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				artiFormVO = new ArtiFormVO();
				artiFormVO.setArti_No(rs.getString("arti_No"));
				artiFormVO.setMem_No(rs.getString("mem_No"));
				artiFormVO.setArti_Title(rs.getString("arti_Title"));
				artiFormVO.setArti_Like(rs.getInt("arti_Like"));
				artiFormVO.setDescribe(rs.getString("describe"));
				artiFormVO.setArti_Time(rs.getTimestamp("arti_Time"));
				artiFormVO.setArti_Pic(rs.getBytes("arti_Pic"));
				artiFormVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
				artiFormVO.setArti_Status(rs.getString("arti_Status"));
				set.add(artiFormVO); // Store the row in the vector
			}
	
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
}
