package com.achieve.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.achieve.model.AchieveJdbcDAO;
import com.achieve.model.AchieveVO;



public class AchieveJdbcDAO implements AchieveDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "BA104G3";
	
	private static final String INSERT = 
			"INSERT INTO ACHIEVE(ACH_NO,ACH_NAME,ACH_EXPLAIN)VALUES(ACH_SEQ.NEXTVAL,?,?)";
	private static final String GET_ALL = 
			"SELECT ACH_NO,ACH_NAME,ACH_EXPLAIN FROM ACHIEVE order by ACH_NO";
	private static final String GET_ONE = 
			"SELECT ACH_NO,ACH_NAME,ACH_EXPLAIN FROM ACHIEVE where ACH_NO = ?";
	private static final String UPDATE = 
			"UPDATE ACHIEVE set ACH_NO=?, ACH_NAME=?,ACH_PICTURE=?, ACH_EXPLAIN=? where ACH_NO = ?";
	private static final String DELETE = 
			"DELETE FROM ACHIEVE where ACH_NO = ?";
	private static final String GETTHREE =
			"select ach_name, ach_picture, ach_explain from achieve where ach_no= ?";
	

	

	@Override
	public void insert(AchieveVO achieveVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT);

			
			pstmt.setString(1, achieveVO.getAch_Name());
			pstmt.setString(2, achieveVO.getAch_Explain());

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
	public void update(AchieveVO achieveVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			
			pstmt.setString(1, achieveVO.getAch_Name());
			pstmt.setString(2, achieveVO.getAch_Explain());
			
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
	public void delete(String ach_No) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, ach_No);

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
	public AchieveVO findByPrimaryKey(String ach_No) {
		AchieveVO achieveVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setString(1, ach_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				achieveVO = new AchieveVO();
				achieveVO.setAch_No(rs.getString("ach_No"));
				achieveVO.setAch_Name(rs.getString("ach_Name"));
				achieveVO.setAch_Explain(rs.getString("ach_Explain"));
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO �]�٬� Domain objects
				achieveVO = new AchieveVO();
				achieveVO.setAch_No(rs.getString("ach_No"));
				achieveVO.setAch_Name(rs.getString("ach_Name"));
				achieveVO.setAch_Explain(rs.getString("ach_Explain"));
				
				list.add(achieveVO); // Store the row in the list
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
		
		AchieveJdbcDAO dao = new AchieveJdbcDAO();
		
				AchieveVO achieveVO = new AchieveVO();
				
				achieveVO.setAch_Name("為啥");
				achieveVO.setAch_Explain("會這樣");
				dao.insert(achieveVO);

				// 修改
//				AchieveVO achieveVO2 = new AchieveVO();
//				achieveVO2.setAch_No("E000001");
//				achieveVO2.setAch_Name("manager");
//				achieveVO2.setAch_Explain("MANA");
//				

				// 刪除
//				dao.delete(7014);

				// 查詢
				AchieveVO achieveVO3 = dao.findByPrimaryKey("AC000003");
				System.out.print(achieveVO3.getAch_No() + ",");
				System.out.print(achieveVO3.getAch_Name() + ",");
				System.out.print(achieveVO3.getAch_Explain());
				
				System.out.println("---------------------");

				// 查詢
				List<AchieveVO> list = dao.getAll();
				for (AchieveVO achieveVO4 : list) {
					System.out.print(achieveVO4.getAch_No() + ",");
					System.out.print(achieveVO4.getAch_Name() + ",");
					System.out.print(achieveVO4.getAch_Explain() + ",");
					
					System.out.println();
				}
			}

	@Override
	public List<AchieveVO> getThree(String ach_No) {
		// TODO Auto-generated method stub
		return null;
	}

	

}

