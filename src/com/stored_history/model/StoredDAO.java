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
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
//			pstmt.setString(1, storedVO.getStored_no());
			pstmt.setString(1, storedVO.getMem_no());
			pstmt.setDate(2, storedVO.getStored_date());
			pstmt.setInt(3, storedVO.getStored_type());
			pstmt.setDouble(4, storedVO.getStored_cost());
			
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
			
			
			pstmt.setString(1, storedVO.getMem_no());
			pstmt.setDate(2, storedVO.getStored_date());
			pstmt.setInt(3, storedVO.getStored_type());
			pstmt.setDouble(4, storedVO.getStored_cost());
			pstmt.setString(5, storedVO.getStored_no());
			
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
	public void delete(String stored_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, stored_no);
			
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
	public StoredVO findByPrimaryKey(String stored_no) {
		StoredVO storedVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
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
			con = ds.getConnection();
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
