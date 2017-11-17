package com.ad.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.artiReply.model.ArtiReplyVO;

public class AdDAO implements AdDAO_interface {
	
	private static DataSource ds = null;
	static{
		try{
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException ne){
			ne.printStackTrace(System.err);
		}
	}
	
    private static final String INSERT_AD= 
		"INSERT INTO AD (AD_NO,AD_PIC,AD_DESC,AD_START,AD_END,AD_FTY_NO,AD_FTY_NAME) VALUES ('AD'||LPAD(to_char(AD_SEQUENCE.NEXTVAL),8,'0'),?,?,?,?,?,?)";
	private static final String GET_ALL_AD = 
		"SELECT AD_NO,AD_PIC,AD_DESC,to_char(AD_START,'yyyy-mm-dd hh:mm:ss') AD_START,to_char(AD_END,'yyyy-mm-dd hh:mm:ss') AD_END,AD_FTY_NO,AD_FTY_NAME FROM AD order by AD_NO";
	private static final String GET_ONE_AD = 
		"SELECT AD_NO,AD_PIC,AD_DESC,to_char(AD_START,'yyyy-mm-dd hh:mm:ss') AD_START,to_char(AD_END,'yyyy-mm-dd hh:mm:ss') AD_END,AD_FTY_NO,AD_FTY_NAME FROM AD where AD_NO = ?";
	private static final String DELETE_AD = 
		"DELETE FROM AD where AD_NO = ?";
	private static final String UPDATE_AD = 
		"UPDATE AD set AD_PIC=?, AD_DESC=?, AD_START=?, AD_END=?, AD_FTY_NO=?, AD_FTY_NAME=? where AD_NO =?";
	private static final String GET_AD_BY_FTY_NO= 
			"SELECT AD_PIC,AD_DESC,to_char(AD_START,'yyyy-mm-dd hh:mm:ss')AD_START,to_char(AD_END,'yyyy-mm-dd hh:mm:ss')AD_END, AD_FTY_NAME FROM AD WHERE AD_FTY_NO = ? order by AD_NO";

	@Override
	public void insertAd(AdVO adVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_AD);
			
			pstmt.setBytes(1, adVO.getAd_Pic());
			pstmt.setString(2, adVO.getAd_Desc());
			pstmt.setTimestamp(3, adVO.getAd_Start());
			pstmt.setTimestamp(4, adVO.getAd_End());
			pstmt.setString(5, adVO.getAd_Fty_No());
			pstmt.setString(6, adVO.getAd_Fty_Name());
			
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured."+ se.getMessage());	
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally {
			if (pstmt!=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				} 
			}
			if (con!=null){
				try{
					con.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void updateAd(AdVO adVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_AD);
			
			pstmt.setBytes(1, adVO.getAd_Pic());
			pstmt.setString(2, adVO.getAd_Desc());
			pstmt.setTimestamp(3, adVO.getAd_Start());
			pstmt.setTimestamp(4, adVO.getAd_End());
			pstmt.setString(5, adVO.getAd_Fty_No());
			pstmt.setString(6, adVO.getAd_Fty_Name());
			pstmt.setString(7, adVO.getAd_No());
			
			pstmt.executeUpdate();
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally{
			if (pstmt!=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con!=null){
				try{
					con.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void deleteAd(String ad_No) {
		Connection con = null;
		PreparedStatement pstmt =  null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_AD);
			
			pstmt.setString(1, ad_No);
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally {
			if (pstmt!=null){
				try{
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null){
				try{
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public AdVO findByPrimaryKey(String ad_No) {
		AdVO adVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_AD);
			
			pstmt.setString(1, ad_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				adVO = new AdVO();
				adVO.setAd_No(rs.getString("ad_No"));
				adVO.setAd_Pic(rs.getBytes("ad_Pic"));
				adVO.setAd_Desc(rs.getString("ad_Desc"));
				adVO.setAd_Start(rs.getTimestamp("ad_Start"));
				adVO.setAd_End(rs.getTimestamp("ad_End"));
				adVO.setAd_Fty_No(rs.getString("ad_Fty_No"));
				adVO.setAd_Fty_Name(rs.getString("ad_Fty_Name"));
			}
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." +se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally {
			if (rs!=null){
				try{
					rs.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if (pstmt!=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if (con!=null){
				try{
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return adVO;
	}
	
	
	@Override
	public Set<AdVO> findAdByFtyNo (String ad_Fty_No){
		Set<AdVO> set = new LinkedHashSet<AdVO>();
		AdVO adVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{			
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_AD_BY_FTY_NO);
			
			pstmt.setString(1, ad_Fty_No);
			rs = pstmt.executeQuery();
		    
		    while(rs.next()){
		    	adVO = new AdVO();
		    	adVO.setAd_No(rs.getString("ad_No"));
		    	adVO.setAd_Pic(rs.getBytes("ad_Pic"));
		    	adVO.setAd_Desc(rs.getString("ad_Desc"));
		    	adVO.setAd_Start(rs.getTimestamp("ad_Start"));
		    	adVO.setAd_End(rs.getTimestamp("ad_End"));
		    	adVO.setAd_Fty_No(rs.getString("ad_Fty_No"));
		    	adVO.setAd_Fty_Name(rs.getString("ad_Fty_Name"));
		    	
		    }
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally {
			if(rs!=null){
				try{
					rs.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if (pstmt!=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if (con!=null){
				try{
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return set;
	}

	@Override
	public Set<AdVO> getAllAd() {
		Set<AdVO> set = new LinkedHashSet<AdVO>();
		AdVO adVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_AD);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				adVO = new AdVO();
				adVO.setAd_No(rs.getString("ad_No"));
				adVO.setAd_Pic(rs.getBytes("ad_Pic"));
				adVO.setAd_Desc(rs.getString("ad_Desc"));
				adVO.setAd_Start(rs.getTimestamp("ad_Start"));
				adVO.setAd_End(rs.getTimestamp("ad_End"));
				adVO.setAd_Fty_No(rs.getString("ad_Fty_No"));
				adVO.setAd_Fty_Name(rs.getString("ad_Fty_Name"));
				set.add(adVO);
			}
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally{
			if(rs!=null){
				try{
					rs.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(pstmt!=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con!=null){
				try{
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return set;
	}
	
	@Override
	public List<AdVO> getAllAD(Map<String, String[]> map) {
		List<AdVO> list = new ArrayList<AdVO>();
		AdVO adVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			con = ds.getConnection();
			String finalSQL = "select * from AD "
		          + jdbcUtil_CompositeQuery_AD.get_WhereCondition(map)
		          + "order by empno";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while(rs.next()){
				adVO = new AdVO();
				adVO.setAd_No(rs.getString("ad_No"));
				adVO.setAd_Pic(rs.getBytes("ad_Pic"));
				adVO.setAd_Desc(rs.getString("ad_Desc"));
				adVO.setAd_Start(rs.getTimestamp("ad_Start"));
				adVO.setAd_End(rs.getTimestamp("ad_End"));
				adVO.setAd_Fty_No(rs.getString("ad_Fty_No"));
				adVO.setAd_Fty_Name(rs.getString("ad_Fty_Name"));
				list.add(adVO);
			}
	
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
