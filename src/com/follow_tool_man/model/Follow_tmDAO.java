package com.follow_tool_man.model;

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

public class Follow_tmDAO implements Follow_tmDAO_interface{
	

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
			"INSERT INTO follow_tool_man (follower_mem_no,followed_mem_no,follow_status)"
			+ "VALUES (?,?,?)";
	
	private static final String GET_ALL_STMT=
			"SELECT followed_mem_no,follow_status"
			+ " FROM follow_tool_man WHERE follower_mem_no=? order by follower_mem_no";
	
	private static final String SELECT=
			"SELECT follower_mem_no,followed_mem_no,follow_status"
			+ " FROM follow_tool_man WHERE follower_mem_no=?";
	
	private static final String UPDATE=
			"UPDATE follow_tool_man SET follow_status=?"
			+ "WHERE follower_mem_no=? and followed_mem_no=?";
			
	private static final String DELETE=
			"DELETE FROM follow_tool_man WHERE follower_mem_no=? and followed_mem_no=? ";

	@Override
	public void insert(Follow_tmVO follow_tmVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, follow_tmVO.getFollower_mem_no());
			pstmt.setString(2, follow_tmVO.getFollowed_mem_no());
			pstmt.setInt(3, follow_tmVO.getFollow_status());
			
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
	public void update(Follow_tmVO follow_tmVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
//			pstmt.setString(1, follow_tmVO.getFollower_mem_no());
			pstmt.setInt(1, follow_tmVO.getFollow_status());
			pstmt.setString(2, follow_tmVO.getFollower_mem_no());
			pstmt.setString(3, follow_tmVO.getFollowed_mem_no());
		
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
	public void delete(String follower_mem_no, String followed_mem_no) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, follower_mem_no);
			pstmt.setString(2, followed_mem_no);
			
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
	public Follow_tmVO findByPrimaryKey(String follower_mem_no, String followed_mem_no) {
		Follow_tmVO follow_tmVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SELECT);
			
			pstmt.setString(1, follower_mem_no);
			
			rs =pstmt.executeQuery();
			
			while(rs.next()){
				follow_tmVO = new Follow_tmVO();
				follow_tmVO.setFollower_mem_no(rs.getString("follower_mem_no"));
				follow_tmVO.setFollowed_mem_no(rs.getString("followed_mem_no"));
				follow_tmVO.setFollow_status(rs.getInt("follow_status"));
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
				
		return follow_tmVO;
	}

	@Override
	public List<Follow_tmVO> getAllDependOnFollower_mem_no(String follower_mem_no) {
		List<Follow_tmVO> list = new ArrayList<Follow_tmVO>();
		Follow_tmVO follow_tmVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			while(rs.next()){
				follow_tmVO = new Follow_tmVO();
				follow_tmVO.setFollowed_mem_no(rs.getString("followed_mem_no"));
				follow_tmVO.setFollow_status(rs.getInt("follow_status"));
				list.add(follow_tmVO);
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
