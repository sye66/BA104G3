package com.relation.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.follow_tool_man.model.Follow_tmVO;

public class RelationJDBCDAO implements RelationDAO_interface{
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104_G3";
	String passwd = "BA104"; 
	
	
	private static final String INSERT_STMT=
			"INSERT INTO relation (mem_No,related_Mem_No,relation_Status)"
			+ "VALUES (?,?,?)";
	
	private static final String GET_ALL_STMT=
			"SELECT related_Mem_No,relation_Status"
			+ " FROM relation WHERE mem_No=? order by mem_No";
	
	private static final String GET_WHO_ADDME=
			"select mem_no from relation where RELATED_MEM_NO=? order by RELATED_MEM_NO";
	
	private static final String SELECT=
			"SELECT mem_No,related_Mem_No,relation_Status"
			+ " FROM relation WHERE mem_No=?";
	
	private static final String UPDATE=
			"UPDATE relation SET relation_Status=?"
			+ "WHERE mem_No=? and related_Mem_No=?";
	
	private static final String DELETE=
			"DELETE FROM relation WHERE mem_No=? and related_Mem_No=? ";
	
	
	
	@Override
	public List<RelationVO> getWhoAddme(String related_Mem_No) {

		List<RelationVO> list = new ArrayList<RelationVO>();
		RelationVO relationVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_WHO_ADDME);
			
			pstmt.setString(1, related_Mem_No);
			rs =pstmt.executeQuery();
			
			while(rs.next()){
				relationVO = new RelationVO();
				relationVO.setMem_No(rs.getString("mem_No"));
				relationVO.setRelation_Status(rs.getInt("relation_Status"));
				list.add(relationVO);
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
		
	
	

	@Override
	public void insert(RelationVO relationVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, relationVO.getMem_No());
			pstmt.setString(2, relationVO.getRelated_Mem_No());
			pstmt.setInt(3, relationVO.getRelation_Status());
			
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
	public void update(RelationVO relationVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, relationVO.getRelation_Status());
			pstmt.setString(2, relationVO.getMem_No());
			pstmt.setString(3, relationVO.getRelated_Mem_No());
			
			
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
	public void delete(String mem_No, String related_Mem_No) {

		RelationVO relationVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, mem_No);
			pstmt.setString(2, related_Mem_No);
			
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
	public RelationVO findByPrimaryKey(String mem_No, String related_Mem_No) {
		RelationVO relationVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SELECT);
			
			pstmt.setString(1, mem_No);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				relationVO = new RelationVO();
				relationVO.setMem_No(rs.getString("mem_No"));
				relationVO.setRelated_Mem_No(rs.getString("related_Mem_No"));
				relationVO.setRelation_Status(rs.getInt("relation_Status"));
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
		return relationVO;
	}

	@Override
	public List<RelationVO> getAllRelationWithMem_No(String mem_No) {
		List<RelationVO> list = new ArrayList<RelationVO>();
		RelationVO relationVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			
			pstmt.setString(1, mem_No);
			rs =pstmt.executeQuery();
			
			while(rs.next()){
				relationVO = new RelationVO();
				relationVO.setRelated_Mem_No(rs.getString("related_Mem_No"));
				relationVO.setRelation_Status(rs.getInt("relation_Status"));
				list.add(relationVO);
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

	public static void main(String[] args){
		
		RelationJDBCDAO dao = new RelationJDBCDAO();
		
		//新增
//		RelationVO relationVO = new RelationVO();
//		
//		relationVO.setMem_No("M000001");
//		relationVO.setRelated_Mem_No("M000006");
//		relationVO.setRelation_Status(1);
//		
//		dao.insert(relationVO);
////		
//		//修改
//		RelationVO relationVO2 = new RelationVO();
//		
//		relationVO2.setMem_No("M000001");
//		relationVO2.setRelated_Mem_No("M000005");
//		relationVO2.setRelation_Status(4);
//		
//		dao.update(relationVO2);
		
		//刪除
//		dao.delete("M000015", "M000016");
		
		//查詢單一
		RelationVO relationVO3 = dao.findByPrimaryKey("M000001", "M000005");
		System.out.println("relation_Status :" + relationVO3.getRelation_Status());
		System.out.println("================================================");
		
		//查詢所有XXX會員的全部有關係的人
		
		List<RelationVO> list = dao.getAllRelationWithMem_No("M000001");
		for(RelationVO aRelation : list){
			System.out.println("跟該會員有關係的會員為下 :");
			System.out.println("會員號碼 :" + aRelation.getRelated_Mem_No());
			System.out.println("該關係為 :" + aRelation.getRelation_Status());
		}
		
	}
	

	
}
