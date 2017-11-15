package com.artiReply.model;

import java.sql.*;
import java.util.*;

import com.artiForm.model.ArtiFormVO;

public class ArtiReplyJDBCDAO implements ArtiReplyDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "123456";
	
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

	
	public void insertReply (ArtiReplyVO artiReplyVO){
		Connection con = null;
		PreparedStatement pstmt = null;

		try{
			Class.forName(driver);
			con =  DriverManager.getConnection(url, userid, passwd);
			pstmt =  con.prepareStatement(INSERT_REPLY);

			pstmt.setString(1, artiReplyVO.getMem_No());
			pstmt.setString(2, artiReplyVO.getArti_No());
			pstmt.setString(3, artiReplyVO.getReply_Desc());
			pstmt.setTimestamp(4, artiReplyVO.getReply_Time());
			pstmt.setInt(5, artiReplyVO.getArti_Cls_No());

			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);

		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
		} catch (SQLException se){
			throw new RuntimeException ("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
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
				e.printStackTrace(System.err);
			}
		}
	}
	
	public void updateReply (ArtiReplyVO artiReplyVO){
		Connection con = null;
		PreparedStatement pstmt = null;

		try{
			Class.forName(driver);
			con =  DriverManager.getConnection(url, userid, passwd);
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

		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
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
	
	public void updateArtiReplyFMSet(ArtiReplyVO artiReplyVO){
		Connection con = null;
		PreparedStatement pstmt = null;

		try{
			Class.forName(driver);
			con =  DriverManager.getConnection(url, userid, passwd);
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

		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
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
	
	public void deleteReply (String reply_No, String mem_No){
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE_REPLY);
			con.setAutoCommit(false);
			
			pstmt.setString(1, reply_No);
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
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
	
	public ArtiReplyVO findByPrimaryKey (String reply_No){
		ArtiReplyVO artiReplyVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
		} catch (SQLException se){
			throw new RuntimeException ("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			if(rs!=null){
				try{
					rs.close();
				} catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(pstmt !=null){
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
					e.printStackTrace();
				}
			}
		} 
		return artiReplyVO;
	}

	
	public Set<ArtiReplyVO> findReplyByArtiNo (String arti_No){
		Set<ArtiReplyVO> set = new LinkedHashSet<ArtiReplyVO>();
		ArtiReplyVO artiReplyVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
		} catch (SQLException se){
			throw new RuntimeException ("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			if(rs!=null){
				try{
					rs.close();
				} catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(pstmt !=null){
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
					e.printStackTrace();
				}
			}
		} 
		return set;
	}
	
	public Set<ArtiReplyVO> findReplyByArtiClsNo (Integer arti_Cls_No){
		Set<ArtiReplyVO> set = new LinkedHashSet<ArtiReplyVO>();
		ArtiReplyVO artiReplyVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
		} catch (SQLException se){
			throw new RuntimeException ("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			if(rs!=null){
				try{
					rs.close();
				} catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(pstmt !=null){
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
					e.printStackTrace();
				}
			}
		} 
		return set;
	}
	
	public Set<ArtiReplyVO> getAllReply(){
		Set<ArtiReplyVO> set = new LinkedHashSet<ArtiReplyVO>();
		ArtiReplyVO artiReplyVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con =  DriverManager.getConnection(url, userid, passwd);
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
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
		} catch (SQLException se){
			throw new RuntimeException ("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			if(rs!=null){
				try{
					rs.close();
				} catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(pstmt !=null){
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
					e.printStackTrace();
				}
			}
		}
		return set;
	}
	

	public static void main(String args[]){
		ArtiReplyJDBCDAO dao = new ArtiReplyJDBCDAO();
		
		// 新增
		ArtiReplyVO artiReplyVO1 = new ArtiReplyVO();
//		artiReplyVO1.setReply_No("");
//		artiReplyVO1.setMem_No("M000069");
//		artiReplyVO1.setArti_No("AR00000040");
//		artiReplyVO1.setReply_Desc("FQ");
//		artiReplyVO1.setReply_Time(java.sql.Timestamp.valueOf("2016-01-15 10:15:28"));
//		artiReplyVO1.setArti_Cls_No(4);
//		dao.insertReply(artiReplyVO1);
		
		// 修改
//	    ArtiReplyVO artiReplyVO2 = new ArtiReplyVO();
//		artiReplyVO2.setReply_No("RE00000002");
//		artiReplyVO2.setMem_No("M000069");
//		artiReplyVO2.setArti_No("AR00000040");
//		artiReplyVO2.setReply_Desc("Asshole!!!!! FQ!!!!!!!");
//		artiReplyVO2.setReply_Time(java.sql.Timestamp.valueOf("2016-03-15 10:15:28"));
//		artiReplyVO2.setArti_Cls_No(1);
//		dao.updateReply(artiReplyVO2);
		
		// 刪除
//		dao.deleteReply("RE00000005");
		
		// 查詢
//		ArtiReplyVO artiReplyVO3 = dao.findByPrimaryKey("");
//		artiReplyVO3.setReply_No("");
//		artiReplyVO3.setMem_No("");
//		artiReplyVO3.setArti_No("");
//		artiReplyVO3.setReply_Desc("");
//		artiReplyVO3.setReply_Time(java.sql.Timestamp.valueOf(""));
//		artiReplyVO3.setArti_Cls_No(1);
//		dao.insertReply(artiReplyVO3);
		
//		ArtiReplyVO artiReplyVO4 = dao.findReplyByArtiNo("AR00000040");
//		artiReplyVO4.setReply_No("RE00000002");
//		artiReplyVO4.setMem_No("M000069");
//		artiReplyVO4.setArti_No("AR00000040");
//		artiReplyVO4.setReply_Desc("Asshole!!!!! FQ!!!!!!!");
//		artiReplyVO4.setReply_Time(java.sql.Timestamp.valueOf("2016-03-15 10:15:28"));
//		artiReplyVO4.setArti_Cls_No(1);
//		dao.insertReply(artiReplyVO4);
//		System.out.println("FQ!!!!!!");
		
		// 查詢
//		 Set<ArtiReplyVO> set = dao.getAllReply();
//		 for(ArtiReplyVO aReply : set){
//			 System.out.println(aReply.getReply_No());
//			 System.out.println(aReply.getMem_No());
//			 System.out.println(aReply.getArti_No());
//			 System.out.println(aReply.getReply_Desc());
//			 System.out.println(aReply.getReply_Time());
//			 System.out.println(aReply.getArti_Cls_No());
//			 System.out.println("=_____=|||");
//			 
//		 }
	}
}
