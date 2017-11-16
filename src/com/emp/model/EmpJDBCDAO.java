package com.emp.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.emp.model.EmpVO;

public class EmpJDBCDAO implements EmpDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "BA104G3";
	
	private static final String INSERT = 
			"INSERT INTO EMP(EMP_NO,EMP_NAME,EMP_PWD,EMP_MAIL,EMP_JOB,EMP_PHONE,EMP_STATE)VALUES('E'||LPAD(MEM_NO.NEXTVAL,6,'0'),?,?,?,?,?,?)";
	private static final String GET_ALL = 
			"SELECT EMP_NO,EMP_NAME,EMP_PWD,EMP_MAIL,EMP_JOB,EMP_PHONE,EMP_STATE FROM EMP order by EMP_NO";
	private static final String GET_ONE = 
			"SELECT EMP_NO,EMP_NAME,EMP_PWD,EMP_MAIL,EMP_JOB,EMP_PHONE,EMP_STATE FROM EMP where EMP_NO = ?";
	private static final String UPDATE = 
			"UPDATE EMP set EMP_NAME=?, EMP_PWD=?, EMP_MAIL=?, EMP_JOB=?, EMP_PHONE=?, EMP_STATE=? where EMP_NO = ?";
	
	
	@Override
	public void insert(EmpVO empVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT);

			pstmt.setString(1, empVO.getEmp_Name());
			pstmt.setString(2, empVO.getEmp_Pwd());
			pstmt.setString(3, empVO.getEmp_Mail());
			pstmt.setString(4, empVO.getEmp_Job());
			pstmt.setString(5, empVO.getEmp_Phone());
			pstmt.setString(6, empVO.getEmp_State());

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
	public void update(EmpVO empVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, empVO.getEmp_Name());
			pstmt.setString(2, empVO.getEmp_Pwd());
			pstmt.setString(3, empVO.getEmp_Mail());
			pstmt.setString(4, empVO.getEmp_Job());
			pstmt.setString(5, empVO.getEmp_Phone());
			pstmt.setString(6, empVO.getEmp_State());

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
	public EmpVO findByPrimaryKey(String emp_No) {
		EmpVO empVO = null;
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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

		EmpJDBCDAO dao = new EmpJDBCDAO();

		// 新增
		EmpVO empVO1 = new EmpVO();
		empVO1.setEmp_Name("xxx");
		empVO1.setEmp_Pwd("JJJ");
		empVO1.setEmp_Mail("JDBC123");
		empVO1.setEmp_Job("小BK");
		empVO1.setEmp_Phone("3345612");
		empVO1.setEmp_State("在職");
		dao.insert(empVO1);

		// 修改
		EmpVO empVO2 = new EmpVO();
		empVO2.setEmp_No("E000001");
		empVO1.setEmp_Name("manager");
		empVO1.setEmp_Pwd("MANA");
		empVO1.setEmp_Mail("bbb123");
		empVO1.setEmp_Job("mane");
		empVO1.setEmp_Phone("334565");
		empVO1.setEmp_State("在職");

		// 刪除
//		dao.delete(7014);

		// 查詢
		EmpVO empVO3 = dao.findByPrimaryKey("E000001");
		System.out.print(empVO3.getEmp_No() + ",");
		System.out.print(empVO3.getEmp_Name() + ",");
		System.out.print(empVO3.getEmp_Pwd() + ",");
		System.out.print(empVO3.getEmp_Mail() + ",");
		System.out.print(empVO3.getEmp_Job() + ",");
		System.out.print(empVO3.getEmp_Phone() + ",");
		System.out.println(empVO3.getEmp_State());
		System.out.println("---------------------");

		// 查詢
		List<EmpVO> list = dao.getAll();
		for (EmpVO aEmp : list) {
			System.out.print(aEmp.getEmp_No() + ",");
			System.out.print(aEmp.getEmp_Name() + ",");
			System.out.print(aEmp.getEmp_Pwd() + ",");
			System.out.print(aEmp.getEmp_Mail() + ",");
			System.out.print(aEmp.getEmp_Job() + ",");
			System.out.print(aEmp.getEmp_Phone() + ",");
			System.out.print(aEmp.getEmp_State());
			System.out.println();
		}
	}

	@Override
	public void delete(String emp_No) {
		
		
	}
}
