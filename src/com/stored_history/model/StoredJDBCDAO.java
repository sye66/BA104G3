package com.stored_history.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class StoredJDBCDAO implements StoredDAO_interface{

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104_G3";
	String passwd = "BA104"; 
	
	private static final String INSERT_STMT=
			"INSERT INTO stored_history (stored_No, mem_No, stored_Date, stored_Type,"
			+ "stored_Cost) VALUES ('S'||LPAD(STORED_NO.NEXTVAL,6,'0'),?, ?, ?,"
			+ "?)";
	private static final String GET_ALL_BYMEM=
			"SELECT * from stored_history where MEM_NO=? order by MEM_NO";
	
//	private static final String GET_ALL_STMT=
//			"SELECT stored_No, mem_No, stored_Date, stored_Type,"
//			+ "stored_Cost FROM stored_history order by stored_No";
	
	private static final String SELECT=
			"SELECT stored_No, mem_No, stored_Date, stored_Type,"
			+ "stored_Cost FROM stored_history WHERE stored_No=?";
	
	private static final String UPDATE=
			"UPDATE stored_history SET mem_No=?, stored_Date=?, stored_Type=?, stored_Cost=?"
			+ "WHERE stored_No=?";
	
	private static final String DELETE=
			"DELETE FROM stored_history WHERE stored_No = ?";

	
	
	
	
	
	@Override
	public void insert(StoredVO storedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
//			pstmt.setString(1, storedVO.getStored_No());
			pstmt.setString(1, storedVO.getMem_No());
			pstmt.setTimestamp(2, storedVO.getStored_Date());
			pstmt.setInt(3, storedVO.getStored_Type());
			pstmt.setDouble(4, storedVO.getStored_Cost());
			
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
			
			
			pstmt.setString(1, storedVO.getMem_No());
			pstmt.setTimestamp(2, storedVO.getStored_Date());
			pstmt.setInt(3, storedVO.getStored_Type());
			pstmt.setDouble(4, storedVO.getStored_Cost());
			pstmt.setString(5, storedVO.getStored_No());
			
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
	public void delete(String stored_No) {
		StoredVO storedVO =null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, stored_No);
			
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
	public StoredVO findByPrimaryKey(String stored_No) {
		StoredVO storedVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SELECT);
			
			pstmt.setString(1, stored_No);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				storedVO = new StoredVO();
				storedVO.setStored_No(rs.getString("stored_No"));
				storedVO.setMem_No(rs.getString("mem_No"));
				storedVO.setStored_Date(rs.getTimestamp("stored_Date"));
				storedVO.setStored_Type(rs.getInt("stored_Type"));
				storedVO.setStored_Cost(rs.getDouble("stored_Cost"));
				
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
	public List<StoredVO> getAll(String mem_No) {
		List<StoredVO> list = new ArrayList<StoredVO>();
		StoredVO storedVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_BYMEM);
			
			pstmt.setString(1, mem_No);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				storedVO = new StoredVO();
				storedVO.setStored_No(rs.getString("stored_No"));
				storedVO.setMem_No(rs.getString("mem_No"));
				storedVO.setStored_Date(rs.getTimestamp("stored_Date"));
				storedVO.setStored_Type(rs.getInt("stored_Type"));
				storedVO.setStored_Cost(rs.getDouble("stored_Cost"));
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
		
//		storedVO1.setStored_No("S000003");
		storedVO1.setMem_No("M000001");
		storedVO1.setStored_Date(new Timestamp(System.currentTimeMillis()));
		storedVO1.setStored_Type(1);
		storedVO1.setStored_Cost(9487943.0);
		
		dao.insert(storedVO1);
		
		//修改
		
		StoredVO storedVO2 = new StoredVO();
		
		storedVO2.setStored_No("S000003");
		storedVO2.setMem_No("M000001");
		storedVO2.setStored_Date(new Timestamp(System.currentTimeMillis()));
		storedVO2.setStored_Type(1);
		storedVO2.setStored_Cost(9487.0);
		
		dao.update(storedVO2);
		
		//刪除
//		dao.delete("S000003");
		
		//查詢單一
		StoredVO storedVO3 = dao.findByPrimaryKey("S000001");
		System.out.println(storedVO3.getStored_No() + ",");
		System.out.println(storedVO3.getMem_No() + ",");
		System.out.println(storedVO3.getStored_Date() + ",");
		System.out.println(storedVO3.getStored_Type() + ",");
		System.out.println(storedVO3.getStored_Cost() +",");
		System.out.println("================================================");
		
		//查詢全部
		List<StoredVO> list = dao.getAll("M000001");
		for(StoredVO aStored : list){
			System.out.println(aStored.getStored_No() + ",");
			System.out.println(aStored.getMem_No() + ",");
			System.out.println(aStored.getStored_Date() + ",");
			System.out.println(aStored.getStored_Type() + ",");
			System.out.println(aStored.getStored_Cost() +",");
			System.out.println("================================================");
		}
		
		
		
		
	}

	
}
