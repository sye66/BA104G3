package com.artiReply.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.naming.*;
import javax.sql.*;

import com.artiForm.model.ArtiFormVO;

public class ArtiReplyDAO implements ArtiReplyDAO_interface {
	
	private static DataSource ds = null;
	static{
		try{
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException ne){
			ne.printStackTrace();
		}
	}
	
	private static final String INSERT_REPLY = 
			"INSERT INTO ARTI_REPLY (REPLY_NO,MEM_NO,ARTI_NO,REPLY_DESC,REPLY_TIME,ARTI_CLS_NO) VALUES ('RE'||LPAD(to_char(ARTI_REPLY_SEQUENCE.NEXTVAL),8,'0'),?,?,?,?,?)";
	
	private static final String GET_ALL_REPLY=
			"SELECT REPLY_NO,MEM_NO,ARTI_NO,REPLY_DESC,to_char(REPLY_TIME,'yyyy-mm-dd hh:mm:ss') REPLY_TIME, ARTI_CLS_NO FROM ARTI_REPLY order by REPLY_NO DESC";
	
	private static final String GET_ONE_REPLY= 
			"SELECT REPLY_NO,MEM_NO,ARTI_NO,REPLY_DESC,to_char(REPLY_TIME,'yyyy-mm-dd hh:mm:ss')REPLY_TIME, ARTI_CLS_NO FROM ARTI_REPLY WHERE REPLY_NO = ?";
	
	private static final String GET_REPLY_BY_ARTI_NO= 
			"SELECT REPLY_NO,MEM_NO,ARTI_NO,REPLY_DESC,to_char(REPLY_TIME,'yyyy-mm-dd hh:mm:ss')REPLY_TIME, ARTI_CLS_NO FROM ARTI_REPLY WHERE ARTI_NO = ? order by REPLY_NO";

	private static final String GET_REPLY_BY_ARTI_CLS_NO= 
			"SELECT REPLY_NO,MEM_NO,ARTI_NO,REPLY_DESC,to_char(REPLY_TIME,'yyyy-mm-dd hh:mm:ss')REPLY_TIME, ARTI_CLS_NO FROM ARTI_REPLY WHERE ARTI_CLS_NO = ? order by REPLY_NO";

	
	private static final String DELETE_REPLY = 
			"DELETE FROM ARTI_REPLY where REPLY_NO = ?";
	
	private static final String UPDATE_REPLY = 
			"UPDATE ARTI_REPLY set MEM_NO=?, ARTI_NO=?, REPLY_DESC=?, REPLY_TIME=?, ARTI_CLS_NO=? where REPLY_NO =?";
	
	private static final String UPDATE_ARTI_STATUS = 
			"UPDATE ARTI_FORM set ARTI_STATUS='有留言' where ARTI_NO =?";

	@Override
	public void insertReply(ArtiReplyVO artiReplyVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try{
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_REPLY);

			pstmt.setString(1, artiReplyVO.getMem_No());
			pstmt.setString(2, artiReplyVO.getArti_No());
			pstmt.setString(3, artiReplyVO.getReply_Desc());
			pstmt.setTimestamp(4, artiReplyVO.getReply_Time());
			pstmt.setInt(5, artiReplyVO.getArti_Cls_No());
			pstmt.executeUpdate();
			
			pstmt = con.prepareStatement(UPDATE_ARTI_STATUS);
			pstmt.setString(1, artiReplyVO.getArti_No());
			pstmt.executeUpdate();
			con.commit();
		
		} catch (SQLException se){
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new RuntimeException ("A database error occured." + se.getMessage());
			
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally {
			if(pstmt !=null){
				try{
					con.setAutoCommit(true);
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
		} if (con!=null){
			try{
				con.close();
			} catch (Exception e){
				e.printStackTrace(System.err);
			}
		}
	}

	@Override
	public void updateReply(ArtiReplyVO artiReplyVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_REPLY);

			pstmt.setString(1, artiReplyVO.getMem_No());
			pstmt.setString(2, artiReplyVO.getArti_No());
			pstmt.setString(3, artiReplyVO.getReply_Desc());
			pstmt.setTimestamp(4, artiReplyVO.getReply_Time());
			pstmt.setInt(5, artiReplyVO.getArti_Cls_No());
			pstmt.setString(6, artiReplyVO.getReply_No());

			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);

		} catch (SQLException se) {
			throw new RuntimeException("A datdbase error occured." + se.getMessage());
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
			if(con!=null){
				try{
					con.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
		
	}


	public void updateArtiReplyFMSet(ArtiReplyVO artiReplyVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_REPLY);

			pstmt.setString(1, artiReplyVO.getMem_No());
			pstmt.setString(2, artiReplyVO.getArti_No());
			pstmt.setString(3, artiReplyVO.getReply_Desc());
			pstmt.setTimestamp(4, artiReplyVO.getReply_Time());
			pstmt.setInt(5, artiReplyVO.getArti_Cls_No());
			pstmt.setString(6, artiReplyVO.getReply_No());

			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);

		} catch (SQLException se){
			throw new RuntimeException ("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			if(pstmt !=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
		} if (con!=null){
			try{
				con.close();
			} catch (Exception e){
				e.printStackTrace();
			}
		}
	}

	@Override
	public void deleteReply(String reply_No, String mem_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
System.out.println("Delete-DAO-111");
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_REPLY);
System.out.println("Delete-DAO-222");
			pstmt.setString(1, reply_No);
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
System.out.println("Delete-DAO-333");
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
			}if (con!=null){
				try{
					con.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public ArtiReplyVO findByPrimaryKey(String reply_No) {
		ArtiReplyVO artiReplyVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_REPLY);

			pstmt.setString(1, reply_No);
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
			throw new RuntimeException("A database error occured." +se.getMessage());
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
		return artiReplyVO;
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
                set.add(artiReplyVO);

			}
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." +se.getMessage());
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
		return set;
	}
	
	@Override
	public Set<ArtiReplyVO> findReplyByArtiClsNo (Integer arti_Cls_No){
		
		Set<ArtiReplyVO> set = new LinkedHashSet<ArtiReplyVO>();
		ArtiReplyVO artiReplyVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_REPLY_BY_ARTI_CLS_NO);

			pstmt.setInt(1, arti_Cls_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				artiReplyVO = new ArtiReplyVO();
				artiReplyVO.setReply_No(rs.getString("reply_No"));
				artiReplyVO.setMem_No(rs.getString("mem_No"));
				artiReplyVO.setArti_No(rs.getString("arti_No"));
				artiReplyVO.setReply_Desc(rs.getString("reply_Desc"));
				artiReplyVO.setReply_Time(rs.getTimestamp("reply_Time"));
				artiReplyVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
                set.add(artiReplyVO);
			}
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." +se.getMessage());
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
		return set;
	}

	@Override
	public Set<ArtiReplyVO> getAllReply() {
		Set<ArtiReplyVO> set = new LinkedHashSet<ArtiReplyVO>();
		ArtiReplyVO artiReplyVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_REPLY);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				artiReplyVO = new ArtiReplyVO();
				artiReplyVO.setReply_No(rs.getString("reply_No"));
				artiReplyVO.setMem_No(rs.getString("mem_No"));
				artiReplyVO.setArti_No(rs.getString("arti_No"));
				artiReplyVO.setReply_Desc(rs.getString("reply_Desc"));
				artiReplyVO.setReply_Time(rs.getTimestamp("reply_Time"));
				artiReplyVO.setArti_Cls_No(rs.getInt("arti_Cls_No"));
				set.add(artiReplyVO);
			}
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." +se.getMessage());
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
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
		return set;
	}

}
