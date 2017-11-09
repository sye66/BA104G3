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
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT=
			"INSERT INTO relation (mem_no,related_mem_no,relation_status)"
			+ "VALUES (?,?,?)";
	
	private static final String GET_ALL_STMT=
			"SELECT related_mem_no,relation_status"
			+ " FROM relation WHERE mem_no=? order by mem_no";
	
	private static final String SELECT=
			"SELECT mem_no,related_mem_no,relation_status"
			+ " FROM relation WHERE mem_no=?";
	
	private static final String UPDATE=
			"UPDATE relation SET relation_status=?"
			+ "WHERE mem_no=? and related_mem_no=?";
	
	private static final String DELETE=
			"DELETE FROM relation WHERE mem_no=? and related_mem_no=? ";
	
	
	
	
	@Override
	public void insert(RelationVO relationVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, relationVO.getMem_no());
			pstmt.setString(2, relationVO.getRelated_mem_no());
			pstmt.setInt(3, relationVO.getRelation_status());
			
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
			pstmt.setInt(1, relationVO.getRelation_status());
			pstmt.setString(2, relationVO.getMem_no());
			pstmt.setString(3, relationVO.getRelated_mem_no());
			
			
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
	public void delete(String mem_no, String related_mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, mem_no);
			pstmt.setString(2, related_mem_no);
			
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
	public RelationVO findByPrimaryKey(String mem_no, String related_mem_no) {
		RelationVO relationVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SELECT);
			pstmt.setString(1, mem_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				relationVO = new RelationVO();
				relationVO.setMem_no(rs.getString("mem_no"));
				relationVO.setRelated_mem_no(rs.getString("related_mem_no"));
				relationVO.setRelation_status(rs.getInt("relation_status"));
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
	public List<RelationVO> getAllRelationWithMem_no(String mem_no) {
		List<RelationVO> list = new ArrayList<RelationVO>();
		RelationVO relationVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			
			pstmt.setString(1, mem_no);
			rs =pstmt.executeQuery();
			
			while(rs.next()){
				relationVO = new RelationVO();
				relationVO.setRelated_mem_no(rs.getString("related_mem_no"));
				relationVO.setRelation_status(rs.getInt("relation_status"));
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
}