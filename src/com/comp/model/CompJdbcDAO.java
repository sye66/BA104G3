package com.comp.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.comp.model.CompVO;

public class CompJdbcDAO implements CompDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "123456";
	
	private static final String INSERT = 
			"INSERT INTO COMP(EMP_NO,AUTH_NO)VALUES(?,?)";
	private static final String GET_ALL = 
			"SELECT EMP_NO,AUTH_NO FROM COMP order by EMP_NO";
	private static final String GET_ONE = 
			"SELECT EMP_NO,AUTH_NO FROM COMP where EMP_NO = ?";
	private static final String UPDATE = 
			"UPDATE COMP set AUTH_NO=? where EMP_NO = ?";
	private static final String DELETE = 
			"DELETE from COMP where Auth_No=? and EMP_NO =?";
	private static final String GET_AUTH_NO = 
			"SELECT AUTH_NO FROM COMP WHERE EMP_NO=?";
	

	
	@Override
	public void insert(CompVO compVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1, compVO.getEmp_No());
			pstmt.setString(2, compVO.getAuth_No());

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
	public void update(CompVO compVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, compVO.getAuth_No());
			pstmt.setString(2, compVO.getEmp_No());

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
	public void delete(CompVO compVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, compVO.getAuth_No());
			pstmt.setString(2, compVO.getEmp_No());

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
	public CompVO findByPrimaryKey(String emp_No) {
		CompVO compVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setString(1, emp_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				compVO = new CompVO();
				compVO.setEmp_No(rs.getString("emp_No"));
				compVO.setAuth_No(rs.getString("auth_No"));
				
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
		return compVO;
	}

	@Override
	public List<CompVO> getAll() {
		List<CompVO> list = new ArrayList<CompVO>();
		CompVO compVO = null;

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
				compVO = new CompVO();
				compVO.setEmp_No(rs.getString("emp_No"));
				compVO.setAuth_No(rs.getString("auth_No"));
				
				
				list.add(compVO); // Store the row in the list
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
			CompJdbcDAO dao = new CompJdbcDAO();
			
			CompVO compVO = new CompVO();
			compVO.setEmp_No("E000016");
			compVO.setAuth_No("AU000003");
			compVO.setAuth_No("AU000002");
			compVO.setAuth_No("AU000001");
			
//			
//			CompVO compVO2 = new CompVO();
//			compVO2.setAuth_No("AU000002");
//			compVO2.setEmp_No("E000002");
//			dao.delete(compVO2);
			
			List<CompVO> list1 = dao.findByPk("E000001");
			for(CompVO compVO5 : list1){
				System.out.println(compVO5.getAuth_No());
			}
			
			
			
			
			
			// 查詢
//			CompVO compVO3 = dao.findByPrimaryKey("E000001");
//			System.out.print(compVO3.getEmp_No() + ",");
//			System.out.print(compVO3.getAuth_No() + ",");
//						
//			System.out.println("---------------------");
//
//			// 查詢
//			List<CompVO> list = dao.getAll();
//			for (CompVO compVO4 : list) {
//				System.out.print(compVO4.getEmp_No() + ",");
//				System.out.print(compVO4.getAuth_No() + ",");
//							
//				System.out.println();
			}
		

	@Override
	public List<CompVO> findByPk(String emp_No) {
		List<CompVO> list1 = new ArrayList<CompVO>();
		CompVO compVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_AUTH_NO);
			
			pstmt.setString(1, emp_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				compVO = new CompVO();
				compVO.setAuth_No(rs.getString("auth_No"));
				list1.add(compVO);
			}
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		return list1;
	}
}