package com.missioncomment.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MissionCommentDAO implements  MissionCommentDAO_interface{

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
			"INSERT INTO MISSION_COMMENT(REVIEWER,LISTENER,MISSION_NO,COMMENT_DETAIL,COMMENT_POINT,COMMENT_TIME)VALUES(?,?,?,?,?,sysdate)";
	private static final String UPDATE= 
			"UPDATE mission_Comment set reviewer = nvl(?,reviewer), listener = nvl(?,listener), mission_No = nvl(?,mission_No), comment_Detail = nvl(?,comment_Detail), comment_Point= nvl(?, comment_Point), comment_Time(?,comment_Time) where reviewer=? and listener=?, mission_No=?";
	private static final String FIND_BY_REVIEWER = 
			"SELECT* FROM MISSION_COMMENT where reviewer = ?  order by comment_Time desc";
	private static final String FIND_BY_LISTENER = 
			"SELECT* FROM MISSION_COMMENT WHERE LISTENER = ?  order by comment_Time desc";
	private static final String FIND_BY_MISSION = 
			"SELECT* FROM MISSION_COMMENT WHERE MISSION_NO = ?  order by comment_Time desc";
	private static final String GET_ONT_COMMENT = 
			"SELECT* FROM MISSION_COMMENT WHERE REVIEWER=? AND LISTENER =? AND MISSION_NO = ?  order by comment_Time desc";
	private static final String DELETE = 
			"DELETE MISSION_COMMENT WHERE REVIEWER=? AND LISTENER=? AND MISSION_NO";
	
	@Override
	public void insert(MissionCommentVO missionCommentVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1, missionCommentVO.getReviewer());
			pstmt.setString(2, missionCommentVO.getListener());
			pstmt.setString(3, missionCommentVO.getMission_No());
			pstmt.setString(4, missionCommentVO.getComment_Detail());
			pstmt.setInt(5, missionCommentVO.getComment_Point());
			pstmt.executeUpdate();
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void update(MissionCommentVO missionCommentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, missionCommentVO.getReviewer());
			pstmt.setString(2, missionCommentVO.getListener());
			pstmt.setString(3, missionCommentVO.getMission_No());
			pstmt.setString(4, missionCommentVO.getComment_Detail());
			pstmt.setInt(5, missionCommentVO.getComment_Point());
			pstmt.setTimestamp(6, missionCommentVO.getComment_Time());
			pstmt.setString(7, missionCommentVO.getReviewer());
			pstmt.setString(8, missionCommentVO.getListener());
			pstmt.setString(9, missionCommentVO.getMission_No());
			pstmt.executeUpdate();
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void delete(String reviewer, String listener, String mission_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, reviewer);
			pstmt.setString(2, listener);
			pstmt.setString(3, mission_No);
			
			pstmt.executeUpdate();
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public MissionCommentVO findByPrimaryKey(String reviewer, String listener, String mission_No) {

		MissionCommentVO missionCommentVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONT_COMMENT);
			
			pstmt.setString(1, reviewer);
			pstmt.setString(2, listener);
			pstmt.setString(3, mission_No);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()){
				missionCommentVO = new MissionCommentVO();
				missionCommentVO.setReviewer(rs.getString("reviewer"));
				missionCommentVO.setListener(rs.getString("listener"));
				missionCommentVO.setMission_No(rs.getString("mission_No"));
				missionCommentVO.setComment_Detail(rs.getString("comment_Detail"));
				missionCommentVO.setComment_Point(rs.getInt("comment_Point"));
				missionCommentVO.setComment_Time(rs.getTimestamp("comment_Time"));
				
			}
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		
		return missionCommentVO;
	}

	@Override
	public List<MissionCommentVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MissionCommentVO> getByReviewer(String reviewer) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MissionCommentVO> getByListener(String listener) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MissionCommentVO> getByMission(String mission_No) {
		// TODO Auto-generated method stub
		return null;
	}

}
