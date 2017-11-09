package com.stored_history.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StoredJDBCDAO implements StoredDAO_interface{

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104_G3";
	String passwd = "BA104"; 
	
	private static final String INSERT_STMT=
			"INSERT INTO stored_history (stored_no, mem_no, stored_date, stored_type,"
			+ "stored_cost) VALUES ('S'||LPAD(STORED_NO.NEXTVAL,6,'0'),?, ?, ?,"
			+ "?)";
	
	private static final String GET_ALL_STMT=
			"SELECT stored_no, mem_no, stored_date, stored_type,"
			+ "stored_cost FROM stored_history order by stored_no";
	
	private static final String SELECT=
			"SELECT stored_no, mem_no, stored_date, stored_type,"
			+ "stored_cost FROM stored_history WHERE stored_no=?";
	
	private static final String UPDATE=
			"UPDATE stored_history SET mem_no=?, stored_date=?, stored_type=?, stored_cost=?"
			+ "WHERE stored_no=?";
	
	private static final String DELETE=
			"DELETE FROM stored_history WHERE stored_no = ?";

	@Override
	public void insert(StoredVO storedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
//			pstmt.setString(1, storedVO.getStored_no());
			pstmt.setString(1, storedVO.getMem_no());
			pstmt.setDate(2, storedVO.getStored_date());
			pstmt.setInt(3, storedVO.getStored_type());
			pstmt.setDouble(4, storedVO.getStored_cost());
			
			pstmt.executeUpdate();
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} finally{
		if (pstmt != null){
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace(System.err);
			}
		}
		if (con != null){
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace(System.err);
			}
		}
	}
	}

	@Override
	public void update(StoredVO storedVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			
			pstmt.setString(1, storedVO.getMem_no());
			pstmt.setDate(2, storedVO.getStored_date());
			pstmt.setInt(3, storedVO.getStored_type());
			pstmt.setDouble(4, storedVO.getStored_cost());
			pstmt.setString(5, storedVO.getStored_no());
			
			pstmt.executeUpdate();
	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} finally{
		if (pstmt != null){
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace(System.err);
			}
		}
		if (con != null){
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace(System.err);
			}
		}
	}
	
}

	@Override
	public void delete(String stored_no) {
		StoredVO storedVO =null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, stored_no);
			
			pstmt.executeUpdate();
	}catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} finally{	
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
	public StoredVO findByPrimaryKey(String stored_no) {
		StoredVO storedVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SELECT);
			
			pstmt.setString(1, stored_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				storedVO = new StoredVO();
				storedVO.setStored_no(rs.getString("stored_no"));
				storedVO.setMem_no(rs.getString("mem_no"));
				storedVO.setStored_date(rs.getDate("stored_date"));
				storedVO.setStored_type(rs.getInt("stored_type"));
				storedVO.setStored_cost(rs.getDouble("stored_cost"));
				
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{	
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
			
			
			
		return storedVO;
	}

	@Override
	public List<StoredVO> getAll() {
		List<StoredVO> list = new ArrayList<StoredVO>();
		StoredVO storedVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				storedVO = new StoredVO();
				storedVO.setStored_no(rs.getString("stored_no"));
				storedVO.setMem_no(rs.getString("mem_no"));
				storedVO.setStored_date(rs.getDate("stored_date"));
				storedVO.setStored_type(rs.getInt("stored_type"));
				storedVO.setStored_cost(rs.getDouble("stored_cost"));
				list.add(storedVO);
				
			}
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{	
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
		
		StoredJDBCDAO dao = new StoredJDBCDAO();
		
		//新增
		StoredVO storedVO1 = new StoredVO();
		
//		storedVO1.setStored_no("S000003");
		storedVO1.setMem_no("M000001");
		storedVO1.setStored_date(Date.valueOf("2017-10-10"));
		storedVO1.setStored_type(1);
		storedVO1.setStored_cost(9487943.0);
		
		dao.insert(storedVO1);
		
		//修改
		
		StoredVO storedVO2 = new StoredVO();
		
		storedVO2.setStored_no("S000003");
		storedVO2.setMem_no("M000001");
		storedVO2.setStored_date(Date.valueOf("2017-10-31"));
		storedVO2.setStored_type(1);
		storedVO2.setStored_cost(9487.0);
		
		dao.update(storedVO2);
		
		//刪除
//		dao.delete("S000003");
		
		//查詢單一
		StoredVO storedVO3 = dao.findByPrimaryKey("S000001");
		System.out.println(storedVO3.getStored_no() + ",");
		System.out.println(storedVO3.getMem_no() + ",");
		System.out.println(storedVO3.getStored_date() + ",");
		System.out.println(storedVO3.getStored_type() + ",");
		System.out.println(storedVO3.getStored_cost() +",");
		System.out.println("================================================");
		
		//查詢全部
		List<StoredVO> list = dao.getAll();
		for(StoredVO aStored : list){
			System.out.println(aStored.getStored_no() + ",");
			System.out.println(aStored.getMem_no() + ",");
			System.out.println(aStored.getStored_date() + ",");
			System.out.println(aStored.getStored_type() + ",");
			System.out.println(aStored.getStored_cost() +",");
			System.out.println("================================================");
		}
		
		
		
		
	}
	
}
