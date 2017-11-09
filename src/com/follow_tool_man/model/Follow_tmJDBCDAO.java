package com.follow_tool_man.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.stored_history.model.StoredVO;

public class Follow_tmJDBCDAO implements Follow_tmDAO_interface{
	
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104_G3";
	String passwd = "BA104"; 
	
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, follow_tmVO.getFollower_mem_no());
			pstmt.setString(2, follow_tmVO.getFollowed_mem_no());
			pstmt.setInt(3, follow_tmVO.getFollow_status());
			
			pstmt.executeUpdate();
			
	}catch (ClassNotFoundException e) {
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
	public void update(Follow_tmVO follow_tmVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
//			pstmt.setString(1, follow_tmVO.getFollower_mem_no());
			pstmt.setInt(1, follow_tmVO.getFollow_status());
			pstmt.setString(2, follow_tmVO.getFollower_mem_no());
			pstmt.setString(3, follow_tmVO.getFollowed_mem_no());
		
			pstmt.executeUpdate();
			
	}catch (ClassNotFoundException e) {
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
	public void delete(String follower_mem_no, String followed_mem_no) {
		
		Follow_tmVO follow_tmVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, follower_mem_no);
			pstmt.setString(2, followed_mem_no);
			
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
	public Follow_tmVO findByPrimaryKey(String follower_mem_no, String followed_mem_no) {
		Follow_tmVO follow_tmVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SELECT);
			
			pstmt.setString(1, follower_mem_no);
			
			rs =pstmt.executeQuery();
			
			while(rs.next()){
				follow_tmVO = new Follow_tmVO();
				follow_tmVO.setFollower_mem_no(rs.getString("follower_mem_no"));
				follow_tmVO.setFollowed_mem_no(rs.getString("followed_mem_no"));
				follow_tmVO.setFollow_status(rs.getInt("follow_status"));
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			pstmt.setString(1, follower_mem_no);
			
			rs = pstmt.executeQuery();
			
			
			
			while(rs.next()){
				follow_tmVO = new Follow_tmVO();
				follow_tmVO.setFollowed_mem_no(rs.getString("followed_mem_no"));
				follow_tmVO.setFollow_status(rs.getInt("follow_status"));
				list.add(follow_tmVO);

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
				
			
			return list;
	}
	public static void main(String[] args) {
		Follow_tmJDBCDAO dao = new Follow_tmJDBCDAO();
		
		//新增
		Follow_tmVO follow_tmVO1 = new Follow_tmVO();
		
		follow_tmVO1.setFollower_mem_no("M000001");
		follow_tmVO1.setFollowed_mem_no("M000011");
		follow_tmVO1.setFollow_status(0);
		
		dao.insert(follow_tmVO1);
		
		//修改
		
		Follow_tmVO follow_tmVO2 = new Follow_tmVO();
		
//		follow_tmVO2.setFollower_mem_no("M000001");
		follow_tmVO2.setFollow_status(1);
		follow_tmVO2.setFollower_mem_no("M000001");
		follow_tmVO2.setFollowed_mem_no("M000002");		
		
		
		dao.update(follow_tmVO2);
		
		//刪除
//		dao.delete("M000001", "M000020");
		
		//查詢單一
		Follow_tmVO follow_tmVO3 = dao.findByPrimaryKey("M000001", "M000020");
		System.out.println("Follow_status :" + follow_tmVO3.getFollow_status());
		System.out.println("================================================");
		
		
		//查詢所有XXX會員的全部追蹤的人
		
		List<Follow_tmVO> list = dao.getAllDependOnFollower_mem_no("M000001");
		for(Follow_tmVO aFollow : list){
			System.out.println(aFollow.getFollowed_mem_no() + ",");
			System.out.println(aFollow.getFollow_status() + ",");
			System.out.println("================================================");
		}
	}
	
}
