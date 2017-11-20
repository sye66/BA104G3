package com.artiForm.model;

import java.io.*;
import java.sql.*;
import java.util.*;

import com.artiReply.model.ArtiReplyVO;

public class ArtiFormJDBCDAO implements ArtiFormDAO_interface {
	String driver= "oracle.jdbc.driver.OracleDriver";
	String url ="jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO ARTI_FORM (ARTI_NO,MEM_NO,ARTI_TITLE,ARTI_LIKE,DESCRIBE,ARTI_TIME,ARTI_PIC,ARTI_CLS_NO,ARTI_STATUS) VALUES ('AR'||LPAD(to_char(ARTI_FORM_SEQUENCE.NEXTVAL),8,'0'),?,?,?,?,?,?,?,?)";
	
	private static final String GET_ALL_STMT = 
			"SELECT ARTI_NO,MEM_NO,ARTI_TITLE,ARTI_LIKE,DESCRIBE,to_char(ARTI_TIME,'yyyy-mm-dd hh:mm:ss') ARTI_TIME,ARTI_PIC,ARTI_CLS_NO,ARTI_STATUS FROM ARTI_FORM order by ARTI_NO DESC";
	
	private static final String GET_ALL_STMT_4_SEARCH = 
			"SELECT * FROM ARTI_FORM WHERE upper(DESCRIBE)LIKE '%?%' ORDER BY ARTI_NO DESC";
	
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


	
	public void insertArti (ArtiFormVO artiFormVO){
		
		Connection con  =null;
		PreparedStatement pstmt = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			
		} catch (ClassNotFoundException ce) {
			throw new RuntimeException ("Couldn't load data driver."+ ce.getMessage());
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
	
	public void updateArti (ArtiFormVO artiFormVO){
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			con.commit();
			con.setAutoCommit(true);
			
		} catch (ClassNotFoundException ce) {
			throw new RuntimeException ("Couldn't load data driver."+ ce.getMessage());
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
	
	public void deleteArti (String arti_No){
		Connection con =  null;
		PreparedStatement pstmt = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(DELETE);
			con.setAutoCommit(false);
			
			pstmt.setString(1, arti_No);
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			
		} catch (ClassNotFoundException ce) {
			throw new RuntimeException ("Couldn't load data driver."+ ce.getMessage());
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
	
	public ArtiFormVO findByPrimaryKey (String arti_No){
		
		ArtiFormVO artiFormVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid,passwd);
			pstmt =  con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, arti_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				artiFormVO = new ArtiFormVO();
				
				artiFormVO.setArti_No(rs.getString("ARTI_NO"));
				artiFormVO.setMem_No(rs.getString("MEM_NO"));
				artiFormVO.setArti_Title(rs.getString("ARTI_TITLE"));
				artiFormVO.setArti_Like(rs.getInt("ARTI_LIKE"));
				artiFormVO.setDescribe(rs.getString("DESCRIBE"));
				artiFormVO.setArti_Time(rs.getTimestamp("ARTI_TIME"));
				artiFormVO.setArti_Pic(rs.getBytes("ARTI_PIC"));
				artiFormVO.setArti_Cls_No(rs.getInt("ARTI_CLS_NO"));
				artiFormVO.setArti_Status(rs.getString("ARTI_STATUS"));
			}

		} catch (ClassNotFoundException ce) {
			throw new RuntimeException ("Couldn't load data driver."+ ce.getMessage());
		} catch (SQLException se){
			throw new RuntimeException ("A database error occured." + se.getMessage());
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

		    }
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't find database driver." + ce.getMessage());
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
	
	public ArtiFormVO findArtiSearchByTitle(String arti_Title){
		
		ArtiFormVO artiFormVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid,passwd);
			pstmt =  con.prepareStatement(GET_ONE_ARTI_SEARCH_BY_TITLE);
			
			pstmt.setString(1, arti_Title);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				artiFormVO = new ArtiFormVO();
				
				artiFormVO.setArti_No(rs.getString("ARTI_NO"));
				artiFormVO.setMem_No(rs.getString("MEM_NO"));
				artiFormVO.setArti_Title(rs.getString("ARTI_TITLE"));
				artiFormVO.setArti_Like(rs.getInt("ARTI_LIKE"));
				artiFormVO.setDescribe(rs.getString("DESCRIBE"));
				artiFormVO.setArti_Time(rs.getTimestamp("ARTI_TIME"));
				artiFormVO.setArti_Pic(rs.getBytes("ARTI_PIC"));
				artiFormVO.setArti_Cls_No(rs.getInt("ARTI_CLS_NO"));
				artiFormVO.setArti_Status(rs.getString("ARTI_STATUS"));
			}

		} catch (ClassNotFoundException ce) {
			throw new RuntimeException ("Couldn't load data driver."+ ce.getMessage());
		} catch (SQLException se){
			throw new RuntimeException ("A database error occured." + se.getMessage());
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
		return artiFormVO;
	}
	
	@Override
	public Set<ArtiFormVO> getAllArti4Serach(String describe){
		Set<ArtiFormVO> set = new LinkedHashSet<ArtiFormVO>();
		ArtiFormVO artiFormVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try{			
			Class.forName(driver);
		    con = DriverManager.getConnection(url, userid, passwd);
		    pstmt = con.prepareStatement(GET_ALL_STMT_4_SEARCH);

		    pstmt.setString(1, describe);
		    rs = pstmt.executeQuery();

		    while(rs.next()){
				artiFormVO.setArti_No(rs.getString("ARTI_NO"));
				artiFormVO.setMem_No(rs.getString("MEM_NO"));
				artiFormVO.setArti_Title(rs.getString("ARTI_TITLE"));
				artiFormVO.setArti_Like(rs.getInt("ARTI_LIKE"));
				artiFormVO.setDescribe(rs.getString("DESCRIBE"));
				artiFormVO.setArti_Time(rs.getTimestamp("ARTI_TIME"));
				artiFormVO.setArti_Pic(rs.getBytes("ARTI_PIC"));
				artiFormVO.setArti_Cls_No(rs.getInt("ARTI_CLS_NO"));
				artiFormVO.setArti_Status(rs.getString("ARTI_STATUS"));
		    }
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't find database driver." + ce.getMessage());
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
	
	
	public Set<ArtiFormVO> getAllArti(){
		Set<ArtiFormVO> set = new LinkedHashSet<ArtiFormVO>();
		ArtiFormVO artiFormVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				artiFormVO = new ArtiFormVO();
				
				artiFormVO.setArti_No(rs.getString("ARTI_NO"));
				artiFormVO.setMem_No(rs.getString("MEM_NO"));
				artiFormVO.setArti_Title(rs.getString("ARTI_TITLE"));
				artiFormVO.setArti_Like(rs.getInt("ARTI_LIKE"));
				artiFormVO.setDescribe(rs.getString("DESCRIBE"));
				artiFormVO.setArti_Time(rs.getTimestamp("ARTI_TIME"));
				artiFormVO.setArti_Pic(rs.getBytes("ARTI_PIC"));
				artiFormVO.setArti_Cls_No(rs.getInt("ARTI_CLS_NO"));
				artiFormVO.setArti_Status(rs.getString("ARTI_STATUS"));
				set.add(artiFormVO);
			}
			
		} catch (ClassNotFoundException ce) {
			throw new RuntimeException ("Couldn't load data driver."+ ce.getMessage());
		} catch (SQLException se){
			throw new RuntimeException ("A database error occured." + se.getMessage());
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
		return set;
	}
	
	
	public static void main(String [] args) throws IOException{
		
		FileInputStream in = null;
		try{
			in = new FileInputStream("C:/BA104_WebApp/xxx.jpg");
		} catch (FileNotFoundException fe){
			fe.printStackTrace(System.err);
		}
		byte[] arti_Pic = new byte[in.available()];
		in.read(arti_Pic);
		in.close();
		
		ArtiFormJDBCDAO dao = new ArtiFormJDBCDAO();
		
		// 新增
//		ArtiFormVO artiFormVO1 = new ArtiFormVO();
//		artiFormVO1.setArti_No("AR000201");
//		artiFormVO1.setMem_No("M000011");
//		artiFormVO1.setArti_Title("GGYY");
//		artiFormVO1.setArti_Like(123);
//		artiFormVO1.setDescribe("GGYY");
//		artiFormVO1.setArti_Time(java.sql.Date.valueOf("2005-01-01"));
//		artiFormVO1.setArti_Pic(arti_Pic);
//		artiFormVO1.setArti_Cls_No(2);
//		artiFormVO1.setArti_Status("GGYY");
//		System.out.println(artiFormVO1.getArti_Like());
//		dao.insert(artiFormVO1);

		// 修改
//		ArtiFormVO artiFormVO2 = new ArtiFormVO();
//		artiFormVO2.setArti_No("AR00000082");
//		artiFormVO2.setMem_No("M000014");
//		artiFormVO2.setArti_Title("7788");
//		artiFormVO2.setArti_Like(3);
//		artiFormVO2.setDescribe("7788");
//		artiFormVO2.setArti_Time(java.sql.Timestamp.valueOf("2009-01-01 19:45:23"));
//		artiFormVO2.setArti_Pic(arti_Pic);
//		artiFormVO2.setArti_Cls_No(3);
//		artiFormVO2.setArti_Status("7788");
//		System.out.println(artiFormVO2.getArti_Like());
//		dao.update(artiFormVO2);

		// 刪除
//		dao.delete("AR000191");

		// 查詢
//		ArtiFormVO artiFormVO3 = dao.findByPrimaryKey("AR00000007");
//		artiFormVO3.setArti_No("AR000181");
//		artiFormVO3.setMem_No("M0015");
//		artiFormVO3.setArti_Title("2266");
//		artiFormVO3.setArti_Like(2);
//		artiFormVO3.setDescribe("2266");
//		artiFormVO3.setArti_Time(java.sql.Timestamp.valueOf("2008-10-11"));
//		artiFormVO3.setArti_Pic(arti_Pic);
//		artiFormVO3.setArti_Cls_No(4);
//		artiFormVO3.setArti_Status("2266");
//		System.out.println("---------------------");
//		System.out.println(artiFormVO3.getArti_No());
		
		// 查詢
		
//		Set<ArtiReplyVO> set = dao.findReplyByArtiNo("");
//		for(ArtiReplyVO artiReply : set){
//			artiReply.setReply_No("AR000181");
//		    artiReply.setMem_No("M0015");
//		    artiReply.setArti_No("2266");
//		    artiReply.setReply_Desc("");
//		    artiReply.setReply_Time(java.sql.Timestamp.valueOf("2008-10-11"));
//		    artiReply.setArti_Cls_No(4);
//			
//			System.out.println(artiReply.getArti_No());
//		}
//		System.out.println("--------OK-------");
		

		// 查詢
//		List<ArtiFormVO> list = dao.getAll();
//		for (ArtiFormVO aArtiForm : list) {
//			System.out.print(aArtiForm.getArti_No() + ",");
//			System.out.print(aArtiForm.getMem_No() + ",");
//			System.out.print(aArtiForm.getArti_Title() + ",");
//			System.out.print(aArtiForm.getArti_Like() + ",");
//			System.out.print(aArtiForm.getDescribe() + ",");
//			System.out.print(aArtiForm.getArti_Time() + ",");
//			System.out.print(aArtiForm.getArti_Pic() + ",");
//			System.out.print(aArtiForm.getArti_Cls_No());
//			System.out.print(aArtiForm.getArti_Status());
//			System.out.println("=999999999=");
//		}
//	}
//	public static byte[] getPictureByteArray(Part part) throws IOException{
//		InputStream is = part.getInputStream();
//		ByteArrayOutputStream bos = new ByteArrayOutputStream();
//		byte[] buffer = new byte[8*1024];
//		int i;
//		while((i=is.read(buffer))!=-1){
//			bos.write(buffer, 0, i);
//		}
//		is.close();
//		return bos.toByteArray();
//			
	}
}
