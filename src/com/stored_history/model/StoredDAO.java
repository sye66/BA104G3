package com.stored_history.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Timestamp;

public class StoredDAO implements StoredDAO_interface{

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
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
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
//			pstmt.setString(1, storedVO.getStored_No());
			pstmt.setString(1, storedVO.getMem_No());
			pstmt.setTimestamp(2, storedVO.getStored_Date());
			pstmt.setInt(3, storedVO.getStored_Type());
			pstmt.setDouble(4, storedVO.getStored_Cost());
			
			pstmt.executeUpdate();
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
			con = ds.getConnection();
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
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, stored_No);
			
			pstmt.executeUpdate();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
}
