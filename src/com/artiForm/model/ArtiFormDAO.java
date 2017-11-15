package com.artiForm.model;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.naming.*;
import javax.sql.*;

import com.artiReply.model.ArtiReplyVO;

public class ArtiFormDAO implements ArtiFormDAO_interface {
	
	private static DataSource ds = null;
	
	static{
		try{
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch(NamingException ne){
			ne.printStackTrace();
		}
	}
	private static final String INSERT_STMT = 
			"INSERT INTO ARTI_FORM (ARTI_NO,MEM_NO,ARTI_TITLE,ARTI_LIKE,DESCRIBE,ARTI_TIME,ARTI_PIC,ARTI_CLS_NO,ARTI_STATUS) VALUES ('AR'||LPAD(to_char(ARTI_FORM_SEQUENCE.NEXTVAL),8,'0'),?,?,?,?,?,?,?,?)";
	
	private static final String GET_ALL_STMT = 
			"SELECT ARTI_NO,MEM_NO,ARTI_TITLE,ARTI_LIKE,DESCRIBE,to_char(ARTI_TIME,'yyyy-mm-dd hh:mm:ss') ARTI_TIME,ARTI_PIC,ARTI_CLS_NO,ARTI_STATUS FROM ARTI_FORM order by ARTI_NO DESC";
	
	private static final String GET_ONE_STMT =
			"SELECT ARTI_NO,MEM_NO,ARTI_TITLE,ARTI_LIKE,DESCRIBE,to_char(ARTI_TIME,'yyyy-mm-dd hh:mm:ss') ARTI_TIME,ARTI_PIC,ARTI_CLS_NO,ARTI_STATUS FROM ARTI_FORM where ARTI_NO = ?";
	
	private static final String DELETE = 
			"DELETE FROM ARTI_FORM where ARTI_NO = ?";
	
	private static final String UPDATE = 
			"UPDATE ARTI_FORM set MEM_NO=?, ARTI_TITLE=?, ARTI_LIKE=?, DESCRIBE=?, ARTI_TIME=?, ARTI_PIC=?, ARTI_CLS_NO=?, ARTI_STATUS=? where ARTI_NO =?";
	
	private static final String GET_ONE_ARTI_SEARCH_BY_TITLE =
			"SELECT ARTI_NO,MEM_NO,ARTI_TITLE,ARTI_LIKE,DESCRIBE,to_char(ARTI_TIME,'yyyy-mm-dd hh:mm:ss') ARTI_TIME,ARTI_PIC,ARTI_CLS_NO,ARTI_STATUS FROM ARTI_FORM where ARTI_TITLE = ?";
	
	private static final String GET_REPLY_BY_ARTI_NO= 
			"SELECT REPLY_NO,MEM_NO,ARTI_NO,REPLY_DESC,to_char(REPLY_TIME,'yyyy-mm-dd hh:mm:ss')REPLY_TIME, ARTI_CLS_NO FROM ARTI_REPLY WHERE ARTI_NO = ? order by REPLY_NO";



	@Override
	public void insertArti (ArtiFormVO artiFormVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, artiFormVO.getMem_No());
			pstmt.setString(2, artiFormVO.getArti_Title());
			pstmt.setInt(3, artiFormVO.getArti_Like());
			pstmt.setString(4, artiFormVO.getDescribe());
			pstmt.setTimestamp(5, artiFormVO.getArti_Time());
			pstmt.setBytes(6, artiFormVO.getArti_Pic());
			pstmt.setInt(7, artiFormVO.getArti_Cls_No());
			pstmt.setString(8, artiFormVO.getArti_Status());
			
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			
		} catch (SQLException se){
			throw new RuntimeException ("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally {
			if (pstmt != null) {
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if (con != null){
				try{
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void updateArti (ArtiFormVO artiFormVO) {
		Connection con =  null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, artiFormVO.getMem_No());
			pstmt.setString(2, artiFormVO.getArti_Title());
			pstmt.setInt(3, artiFormVO.getArti_Like());
			pstmt.setString(4, artiFormVO.getDescribe());
			pstmt.setTimestamp(5, artiFormVO.getArti_Time());
			pstmt.setBytes(6, artiFormVO.getArti_Pic());
			pstmt.setInt(7, artiFormVO.getArti_Cls_No());
			pstmt.setString(8, artiFormVO.getArti_Status());
			pstmt.setString(9, artiFormVO.getArti_No());
			
			pstmt.executeUpdate();
			
		} catch (SQLException se){
			throw new RuntimeException("A database err occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally {
			if(pstmt!=null){
				try{
					pstmt.close();
				} catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con!=null){
				try{
					
				} catch(Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void deleteArti (String arti_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, arti_No);
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
				} catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con!=null){
				try{
					con.close();
				} catch(Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public ArtiFormVO findByPrimaryKey(String arti_No) {
		ArtiFormVO artiFormVO =  null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, arti_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				artiFormVO = new ArtiFormVO();
				artiFormVO.setArti_No(rs.getString("arti_No"));
				artiFormVO.setMem_No(rs.getString("mem_No"));
				artiFormVO.setArti_Title(rs.getString("arti_Title"));
				artiFormVO.setArti_Like(rs.getInt("arti_Like"));
				artiFormVO.setDescribe(rs.getString("describe"));
				artiFormVO.setArti_Time(rs.getTimestamp("arti_Time"));
				artiFormVO.setArti_Pic(rs.getBytes("arti_Pic"));
				artiFormVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
				artiFormVO.setArti_Status(rs.getString("arti_Status"));
			}
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." +se.getMessage());
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
				} catch(Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return artiFormVO;
	}
	
	@Override
	public Set<ArtiReplyVO> findReplyByArtiNo (String arti_No){
		Set<ArtiReplyVO> set = new LinkedHashSet<ArtiReplyVO>();
		ArtiReplyVO artiReplyVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{			
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_REPLY_BY_ARTI_NO);
			
			pstmt.setString(1, arti_No);
			rs = pstmt.executeQuery();
		    
		    while(rs.next()){
		    	artiReplyVO = new ArtiReplyVO();
		    	artiReplyVO.setReply_No(rs.getString("reply_No"));
		    	artiReplyVO.setMem_No(rs.getString("mem_No"));
		    	artiReplyVO.setArti_No(rs.getString("arti_No"));
		    	artiReplyVO.setReply_Desc(rs.getString("reply_Desc"));
		    	artiReplyVO.setReply_Time(rs.getTimestamp("reply_Time"));
		    	artiReplyVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
		    	
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
	public ArtiFormVO findArtiSearchByTitle(String arti_Title) {
		ArtiFormVO artiFormVO =  null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_ARTI_SEARCH_BY_TITLE);

			pstmt.setString(1, arti_Title);
			rs = pstmt.executeQuery();

			while(rs.next()){
				artiFormVO = new ArtiFormVO();
				artiFormVO.setArti_No(rs.getString("arti_No"));
				artiFormVO.setMem_No(rs.getString("mem_No"));
				artiFormVO.setArti_Title(rs.getString("arti_Title"));
				artiFormVO.setArti_Like(rs.getInt("arti_Like"));
				artiFormVO.setDescribe(rs.getString("describe"));
				artiFormVO.setArti_Time(rs.getTimestamp("arti_Time"));
				artiFormVO.setArti_Pic(rs.getBytes("arti_Pic"));
				artiFormVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
				artiFormVO.setArti_Status(rs.getString("arti_Status"));
			}
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." +se.getMessage());
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
				} catch(Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return artiFormVO;
	}

	@Override
	public Set<ArtiFormVO> getAllArti () {
		Set<ArtiFormVO> set = new LinkedHashSet<ArtiFormVO>();
		ArtiFormVO artiFormVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				artiFormVO = new ArtiFormVO();
				artiFormVO.setArti_No(rs.getString("arti_No"));
				artiFormVO.setMem_No(rs.getString("mem_No"));
				artiFormVO.setArti_Title(rs.getString("arti_Title"));
				artiFormVO.setArti_Like(rs.getInt("arti_Like"));
				artiFormVO.setDescribe(rs.getString("describe"));
				artiFormVO.setArti_Time(rs.getTimestamp("arti_Time"));
				artiFormVO.setArti_Pic(rs.getBytes("arti_Pic"));
				artiFormVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
				artiFormVO.setArti_Status(rs.getString("arti_Status"));
				set.add(artiFormVO);
			}
		
		} catch(SQLException se){
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally {
			if(rs!=null){
				try{
					rs.close();
				} catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(pstmt!=null){
				try{
					pstmt.close();
				} catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con!=null){
				try{
					con.close();
				} catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
		return set;
	}
}