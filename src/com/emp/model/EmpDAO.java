package com.emp.model;

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

import com.emp.model.EmpVO;

public class EmpDAO implements EmpDAO_interface{
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
			"INSERT INTO EMP(EMP_NO,EMP_NAME,EMP_PWD,EMP_MAIL,EMP_JOB,EMP_PHONE,EMP_STATE)VALUES('E'||LPAD(MEM_NO.NEXTVAL,6,'0'),?,?,?,?,?,?)";
	private static final String GET_ALL = 
			"SELECT EMP_NO,EMP_NAME,EMP_PWD,EMP_MAIL,EMP_JOB,EMP_PHONE,EMP_STATE FROM EMP order by EMP_NO";
	private static final String GET_ONE = 
			"SELECT EMP_NO,EMP_NAME,EMP_PWD,EMP_MAIL,EMP_JOB,EMP_PHONE,EMP_STATE FROM EMP where EMP_NO = ?";
	private static final String UPDATE = 
			"UPDATE EMP set EMP_NAME=?, EMP_MAIL=?, EMP_JOB=?, EMP_PHONE=?, EMP_STATE=? where EMP_NO = ?";
	private static final String DELETE = 
			"DELETE FROM EMP where EMP_NO = ?";
	private static final String GETEMPNO = 
			"SELECT EMP_NO FROM EMP ORDER BY EMP_NO";
	@Override
	public void insert(EmpVO empVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);

			pstmt.setString(1, empVO.getEmp_Name());
			pstmt.setString(2, empVO.getEmp_Pwd());
			pstmt.setString(3, empVO.getEmp_Mail());
			pstmt.setString(4, empVO.getEmp_Job());
			pstmt.setString(5, empVO.getEmp_Phone());
			pstmt.setString(6, empVO.getEmp_State());

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
	public void update(EmpVO empVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, empVO.getEmp_Name());
//			pstmt.setString(2, empVO.getEmp_Pwd());
			pstmt.setString(2, empVO.getEmp_Mail());
			pstmt.setString(3, empVO.getEmp_Job());
			pstmt.setString(4, empVO.getEmp_Phone());
			pstmt.setString(5, empVO.getEmp_State());
			pstmt.setString(6, empVO.getEmp_No());

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
	public EmpVO findByPrimaryKey(String emp_No) {
		EmpVO empVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setString(1, emp_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				empVO = new EmpVO();
				empVO.setEmp_No(rs.getString("emp_No"));
				empVO.setEmp_Name(rs.getString("emp_Name"));
				empVO.setEmp_Pwd(rs.getString("emp_Pwd"));
				empVO.setEmp_Mail(rs.getString("emp_Mail"));
				empVO.setEmp_Job(rs.getString("emp_Job"));
				empVO.setEmp_Phone(rs.getString("emp_Phone"));
				empVO.setEmp_State(rs.getString("emp_State"));
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
		return empVO;
	}
	@Override
	public List<EmpVO> getAll() {
		List<EmpVO> list = new ArrayList<EmpVO>();
		EmpVO empVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO �]�٬� Domain objects
				empVO = new EmpVO();
				empVO.setEmp_No(rs.getString("emp_No"));
				empVO.setEmp_Name(rs.getString("emp_Name"));
				empVO.setEmp_Pwd(rs.getString("emp_Pwd"));
				empVO.setEmp_Mail(rs.getString("emp_Mail"));
				empVO.setEmp_Job(rs.getString("emp_Job"));
				empVO.setEmp_Phone(rs.getString("emp_Phone"));
				empVO.setEmp_State(rs.getString("emp_State"));
				list.add(empVO); // Store the row in the list
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
	public List<EmpVO> getEmp_No() {
		List<EmpVO> list = new ArrayList<EmpVO>();
		EmpVO empVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GETEMPNO);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO �]�٬� Domain objects
				empVO = new EmpVO();
				empVO.setEmp_No(rs.getString("emp_No"));
				list.add(empVO); // Store the row in the list
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
	public void delete(String emp_No) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, emp_No);

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
