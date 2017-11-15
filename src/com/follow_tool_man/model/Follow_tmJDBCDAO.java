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
	String userid = "BA104G3";
	String passwd = "123456"; 
	
	private static final String INSERT_STMT=
			"INSERT INTO follow_tool_man (follower_Mem_No,followed_Mem_No,follow_Status)"
			+ "VALUES (?,?,?)";
	
	private static final String GET_ALL_STMT=
			"SELECT followed_Mem_No,follow_Status"
			+ " FROM follow_tool_man WHERE follower_Mem_No=? order by follower_Mem_No";
	
	private static final String SELECT=
			"SELECT follower_Mem_No,followed_Mem_No,follow_Status"
			+ " FROM follow_tool_man WHERE follower_Mem_No=?";
	
	private static final String UPDATE=
			"UPDATE follow_tool_man SET follow_Status=?"
			+ "WHERE follower_Mem_No=? and followed_Mem_No=?";
			
	private static final String DELETE=
			"DELETE FROM follow_tool_man WHERE follower_Mem_No=? and followed_Mem_No=? ";
			
			
			
	
	@Override
	public void insert(Follow_tmVO follow_tmVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, follow_tmVO.getFollower_Mem_No());
			pstmt.setString(2, follow_tmVO.getFollowed_Mem_No());
			pstmt.setInt(3, follow_tmVO.getFollow_Status());
			
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
			
//			pstmt.setString(1, follow_tmVO.getFollower_Mem_No());
			pstmt.setInt(1, follow_tmVO.getFollow_Status());
			pstmt.setString(2, follow_tmVO.getFollower_Mem_No());
			pstmt.setString(3, follow_tmVO.getFollowed_Mem_No());
		
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
	public void delete(String follower_Mem_No, String followed_Mem_No) {
		
		Follow_tmVO follow_tmVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, follower_Mem_No);
			pstmt.setString(2, followed_Mem_No);
			
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
	public Follow_tmVO findByPrimaryKey(String follower_Mem_No, String followed_Mem_No) {
		Follow_tmVO follow_tmVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SELECT);
			
			pstmt.setString(1, follower_Mem_No);
			
			rs =pstmt.executeQuery();
			
			while(rs.next()){
				follow_tmVO = new Follow_tmVO();
				follow_tmVO.setFollower_Mem_No(rs.getString("follower_Mem_No"));
				follow_tmVO.setFollowed_Mem_No(rs.getString("followed_Mem_No"));
				follow_tmVO.setFollow_Status(rs.getInt("follow_Status"));
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
	public List<Follow_tmVO> getAllDependOnFollower_Mem_No(String follower_Mem_No) {
		List<Follow_tmVO> list = new ArrayList<Follow_tmVO>();
		Follow_tmVO follow_tmVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			pstmt.setString(1, follower_Mem_No);
			
			rs = pstmt.executeQuery();
			
			
			
			while(rs.next()){
				follow_tmVO = new Follow_tmVO();
				follow_tmVO.setFollowed_Mem_No(rs.getString("followed_Mem_No"));
				follow_tmVO.setFollow_Status(rs.getInt("follow_Status"));
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
		
		//�s�W
		Follow_tmVO follow_tmVO1 = new Follow_tmVO();
		
		follow_tmVO1.setFollower_Mem_No("M000001");
		follow_tmVO1.setFollowed_Mem_No("M000011");
		follow_tmVO1.setFollow_Status(0);
		
		dao.insert(follow_tmVO1);
		
		//�ק�
		
		Follow_tmVO follow_tmVO2 = new Follow_tmVO();
		
//		follow_tmVO2.setFollower_Mem_No("M000001");
		follow_tmVO2.setFollow_Status(1);
		follow_tmVO2.setFollower_Mem_No("M000001");
		follow_tmVO2.setFollowed_Mem_No("M000002");		
		
		
		dao.update(follow_tmVO2);
		
		//�R��
//		dao.delete("M000001", "M000020");
		
		//�d�߳�@
		Follow_tmVO follow_tmVO3 = dao.findByPrimaryKey("M000001", "M000020");
		System.out.println("Follow_Status :" + follow_tmVO3.getFollow_Status());
		System.out.println("================================================");
		
		
		//�d�ߩҦ�XXX�|���������l�ܪ��H
		
		List<Follow_tmVO> list = dao.getAllDependOnFollower_Mem_No("M000001");
		for(Follow_tmVO aFollow : list){
			System.out.println(aFollow.getFollowed_Mem_No() + ",");
			System.out.println(aFollow.getFollow_Status() + ",");
			System.out.println("================================================");
		}
	}
	
}
