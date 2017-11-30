package com.relation.model;

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

public class RelationDAO implements RelationDAO_interface{

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT=
			"INSERT INTO relation (mem_No,related_Mem_No,relation_Status)"
			+ "VALUES (?,?,?)";
	
	private static final String GET_ALL_STMT=
			"SELECT related_Mem_No,relation_Status"
			+ " FROM relation WHERE mem_No=? order by mem_No";
	
	private static final String GET_WHO_ADDME=
			"select * from relation where RELATED_MEM_NO=? order by RELATED_MEM_NO";
	
	private static final String SELECT=
			"SELECT mem_No,related_Mem_No,relation_Status"
			+ " FROM relation WHERE mem_No=? and related_Mem_No =?";
	
	private static final String UPDATE=
			"UPDATE relation SET relation_Status=?"
			+ "WHERE mem_No=? and related_Mem_No=?";
	
	private static final String DELETE=
			"DELETE FROM relation WHERE mem_No=? and related_Mem_No=? ";
	
	private static final String GET_ALL=
			"SELECT mem_No,related_Mem_No,relation_Status FROM relation";
	
	
	
	@Override
	public List<RelationVO> getAllFriends(String related_Mem_No) {
		List<RelationVO> list = new ArrayList<RelationVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_WHO_ADDME);
//			System.out.println("連線成功");
			pstmt.setString(1, related_Mem_No);
			rs =pstmt.executeQuery();
//			System.out.println("查詢結束");
			while(rs.next()){
				RelationVO relationVO = new RelationVO();
				relationVO.setMem_No(rs.getString("MEM_NO"));
				relationVO.setRelation_Status(rs.getInt("RELATION_STATUS"));
				relationVO.setRelated_Mem_No(rs.getString("RELATED_MEM_NO"));
				System.out.println("rs.getInt(RELATION_STATUS)" + rs.getInt("RELATION_STATUS"));
				if(rs.getInt("RELATION_STATUS")==1){
					list.add(relationVO);
				}
				
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@Override
	public List<RelationVO> getWhoAddme(String related_Mem_No) {
		List<RelationVO> list = new ArrayList<RelationVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_WHO_ADDME);
//			System.out.println("連線成功");
			pstmt.setString(1, related_Mem_No);
			rs =pstmt.executeQuery();
//			System.out.println("查詢結束");
			while(rs.next()){
				RelationVO relationVO = new RelationVO();
				relationVO.setMem_No(rs.getString("MEM_NO"));
				relationVO.setRelation_Status(rs.getInt("RELATION_STATUS"));
				relationVO.setRelated_Mem_No(rs.getString("RELATED_MEM_NO"));
				System.out.println("rs.getInt(RELATION_STATUS)" + rs.getInt("RELATION_STATUS"));
				if(rs.getInt("RELATION_STATUS")==0){
					list.add(relationVO);
				}
				
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
	
	
	
	@Override
	public void insert(RelationVO relationVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, relationVO.getMem_No());
			pstmt.setString(2, relationVO.getRelated_Mem_No());
			pstmt.setInt(3, relationVO.getRelation_Status());
			
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
	public void update(RelationVO relationVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1, relationVO.getRelation_Status());
			pstmt.setString(2, relationVO.getMem_No());
			pstmt.setString(3, relationVO.getRelated_Mem_No());
			
			
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
	public void delete(String mem_No, String related_Mem_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, mem_No);
			pstmt.setString(2, related_Mem_No);
			
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
	public RelationVO findByPrimaryKey(String mem_No, String related_Mem_No) {
		RelationVO relationVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SELECT);
			pstmt.setString(1, mem_No);
			pstmt.setString(2, related_Mem_No);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				relationVO = new RelationVO();
				relationVO.setMem_No(rs.getString("mem_No"));
				relationVO.setRelated_Mem_No(rs.getString("related_Mem_No"));
				relationVO.setRelation_Status(rs.getInt("relation_Status"));
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
		return relationVO;
	}
	@Override
	public List<RelationVO> getAllRelationWithMem_No(String mem_No) {
		List<RelationVO> list = new ArrayList<RelationVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			
			pstmt.setString(1, mem_No);
			rs =pstmt.executeQuery();
			
			while(rs.next()){
				RelationVO relationVO = new RelationVO();
				relationVO.setRelated_Mem_No(rs.getString("related_Mem_No"));
				relationVO.setRelation_Status(rs.getInt("relation_Status"));
				list.add(relationVO);
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


	@Override
	public List<RelationVO> getAll() {
		List<RelationVO> list = new ArrayList<RelationVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs =pstmt.executeQuery();
			while(rs.next()){
				RelationVO relationVO = new RelationVO();
				relationVO.setMem_No(rs.getString("MEM_NO"));
				relationVO.setRelation_Status(rs.getInt("RELATION_STATUS"));
				relationVO.setRelated_Mem_No(rs.getString("RELATED_MEM_NO"));
				list.add(relationVO);
			}
		} catch (SQLException e) {
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