package com.artiReport.model;

import java.sql.*;
import java.util.LinkedHashSet;
import java.util.Set;

import com.sun.org.apache.regexp.internal.RE;

public class ArtiReportJDBCDAO implements ArtiReportDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "123456";
	
	private static final String INSERT_REPORT = 
			"INSERT INTO ARTI_REPORT (REPORT_NO,MEM_NO,ARTI_NO,REPORT_DESC,REPORT_TIME,REP_RE_DESC,REPORT_STATUS) VALUES ('REP'||LPAD(to_char(ARTI_REPORT_SEQUENCE.NEXTVAL),7,'0'),?,?,?,?,?,?)";
	
	private static final String GET_ALL_REPORT= 
			"SELECT REPORT_NO,MEM_NO,ARTI_NO,REPORT_DESC,to_char(REPORT_TIME,'yyyy-mm-dd hh:mm:ss') REPORT_TIME,REP_RE_DESC,REPORT_STATUS FROM ARTI_REPORT order by REPORT_NO";
	
	private static final String GET_ONE_REPORT = 
			"SELECT REPORT_NO,MEM_NO,ARTI_NO,REPORT_DESC,to_char(REPORT_TIME,'yyyy-mm-dd hh:mm:ss') REPORT_TIME,REP_RE_DESC,REPORT_STATUS FROM ARTI_REPORT where REPORT_NO";
	
	private static final String GET_REPORT_BY_ARTI_NO = 
			"SELECT REPORT_NO,MEM_NO,ARTI_NO,REPORT_DESC,to_char(REPORT_TIME,'yyyy-mm-dd hh:mm:ss') REPORT_TIME,REP_RE_DESC,REPORT_STATUS FROM ARTI_REPORT WHERE ARTI_NO = ? order by REPORT_NO";

	private static final String GET_REPORT_BY_MEM_NO= 
			"SELECT REPORT_NO,MEM_NO,ARTI_NO,REPORT_DESC,to_char(REPORT_TIME,'yyyy-mm-dd hh:mm:ss') REPORT_TIME,REP_RE_DESC,REPORT_STATUS FROM ARTI_REPORT WHERE MEM_NO = ? order by REPORT_NO";
	
	private static final String DELETE_REPORT = 
			"DELETE FROM ARTI_REPORT where REPORT_NO = ?";
	
	private static final String UPDATE_REPORT = 
			"UPDATE ARTI_REPORT set MEM_NO=?, ARTI_NO=?, REPORT_DESC=?, REPORT_TIME=?,  REP_RE_DESC=?, REPORT_STATUS=? where REPORT_NO =?";

	
	
	public void insertReport(ArtiReportVO artiReportVO){
		Connection con = null;
		PreparedStatement pstmt = null;

		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_REPORT);

			pstmt.setString(1, artiReportVO.getMem_No());
			pstmt.setString(2, artiReportVO.getArti_No());
			pstmt.setString(3, artiReportVO.getReport_Desc());
			pstmt.setTimestamp(4, artiReportVO.getReport_Time());
			pstmt.setString(5, artiReportVO.getRep_Re_Desc());
			pstmt.setString(6, artiReportVO.getReport_Status());

			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);

		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
		} catch (SQLException se){
			throw new RuntimeException("A database error occured."+se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally {
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
				} catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
	}
	
	public void updateReport (ArtiReportVO artiReportVO){
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_REPORT);
			
			pstmt.setString(1, artiReportVO.getMem_No());
			pstmt.setString(2, artiReportVO.getArti_No());
			pstmt.setString(3, artiReportVO.getReport_Desc());
			pstmt.setTimestamp(4, artiReportVO.getReport_Time());
			pstmt.setString(5, artiReportVO.getRep_Re_Desc());
			pstmt.setString(6, artiReportVO.getReport_Status());
			pstmt.setString(7, artiReportVO.getReport_No());
			
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
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
			if (con!=null){
				try{
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
	}
	

	
	public void deleteReport (String report_No){
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE_REPORT);
			con.setAutoCommit(false);
			
			pstmt.setString(1, report_No);
			
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." +ce.getMessage());
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception e){
			e.printStackTrace(System.err);
		} finally {
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
	}
	
	public ArtiReportVO findByPrimaryKey (String report_No){
		
		ArtiReportVO artiReportVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_REPORT);
			
			pstmt.setString(1, report_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				artiReportVO = new ArtiReportVO();
				artiReportVO.setReport_No(rs.getString("report_No"));
				artiReportVO.setMem_No(rs.getString("mem_No"));
				artiReportVO.setArti_No(rs.getString("arti_No"));
				artiReportVO.setReport_Desc(rs.getString("report_Desc"));
				artiReportVO.setReport_Time(rs.getTimestamp("report_Time"));
				artiReportVO.setRep_Re_Desc(rs.getString("Rep_Re_Desc"));
				artiReportVO.setReport_Status(rs.getString("report_Status"));
			}
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
		} catch(SQLException se){
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
				} catch(Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return artiReportVO;
	}
	
	@Override
	public Set<ArtiReportVO> findReportByArtiNo(String arti_No) {
		Set<ArtiReportVO> set = new LinkedHashSet<ArtiReportVO>();
		ArtiReportVO artiReportVO = null;
		
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_REPORT_BY_ARTI_NO);
			
			pstmt.setString(1, arti_No);
			rs = pstmt.executeQuery();

			while(rs.next()){
				artiReportVO = new ArtiReportVO();
				artiReportVO.setReport_No(rs.getString("report_No"));
				artiReportVO.setMem_No(rs.getString("mem_No"));
				artiReportVO.setArti_No(rs.getString("arti_No"));
				artiReportVO.setReport_Desc(rs.getString("report_Desc"));
				artiReportVO.setReport_Time(rs.getTimestamp("report_Time"));
				artiReportVO.setRep_Re_Desc(rs.getString("Rep_Re_Desc"));
				artiReportVO.setReport_Status(rs.getString("report_Status"));
				set.add(artiReportVO);
			}
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured."+se.getMessage());
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
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return set;
	}
	
	@Override
	public Set<ArtiReportVO> findReportByMemNo(String mem_No) {
		Set<ArtiReportVO> set = new LinkedHashSet<ArtiReportVO>();
		ArtiReportVO artiReportVO = null;
		
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_REPORT_BY_MEM_NO);
			
			pstmt.setString(1, mem_No);
			rs = pstmt.executeQuery();

			while(rs.next()){
				artiReportVO = new ArtiReportVO();
				artiReportVO.setReport_No(rs.getString("report_No"));
				artiReportVO.setMem_No(rs.getString("mem_No"));
				artiReportVO.setArti_No(rs.getString("arti_No"));
				artiReportVO.setReport_Desc(rs.getString("report_Desc"));
				artiReportVO.setReport_Time(rs.getTimestamp("report_Time"));
				artiReportVO.setRep_Re_Desc(rs.getString("Rep_Re_Desc"));
				artiReportVO.setReport_Status(rs.getString("report_Status"));
				set.add(artiReportVO);
			}
			
		} catch (SQLException se){
			throw new RuntimeException("A database error occured."+se.getMessage());
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
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return set;
	}
	
	
	public Set<ArtiReportVO> getAllReport(){
		Set<ArtiReportVO> set = new LinkedHashSet<ArtiReportVO>();
		ArtiReportVO artiReportVO = null;
		
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_REPORT);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				artiReportVO = new ArtiReportVO();
				artiReportVO.setReport_No(rs.getString("report_No"));
				artiReportVO.setMem_No(rs.getString("mem_No"));
				artiReportVO.setArti_No(rs.getString("arti_No"));
				artiReportVO.setReport_Desc(rs.getString("report_Desc"));
				artiReportVO.setReport_Time(rs.getTimestamp("report_Time"));
				artiReportVO.setRep_Re_Desc(rs.getString("Rep_Re_Desc"));
				artiReportVO.setReport_Status(rs.getString("report_Status"));
				set.add(artiReportVO);
			}
			
			
		} catch (ClassNotFoundException ce){
			throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
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
	
	public static void main(String args[]) {
		
		ArtiReportJDBCDAO dao = new ArtiReportJDBCDAO();
		
		// 新增
		ArtiReportVO artiReportVO1 = new ArtiReportVO();
//		artiReportVO1.setReport_No("");
//		artiReportVO1.setMem_No("M000065");
//		artiReportVO1.setArti_No("AR00000081");
//		artiReportVO1.setReport_Desc("XD");
//		artiReportVO1.setReport_Time(java.sql.Timestamp.valueOf("2017-02-13 07:11:14"));
//		artiReportVO1.setRep_Re_Desc(3);
//		artiReportVO1.setReport_Status("待處理");
//		dao.insertReport(artiReportVO1);
		
		// 修改
//		ArtiReportVO artiReportVO2 = new ArtiReportVO();
//		artiReportVO2.setReport_No("REP0000001");
//		artiReportVO2.setMem_No("M000065");
//		artiReportVO2.setArti_No("AR00000081");
//		artiReportVO2.setReport_Desc("XD ^O^/");
//		artiReportVO2.setReport_Time(java.sql.Timestamp.valueOf("2017-02-15 07:11:14"));
//		artiReportVO2.setRep_Re_Desc(1);
//		artiReportVO2.setReport_Status("處理中");
//		dao.updateReport(artiReportVO2);
		
		// 刪除
//		dao.deleteReport("REP0000001");
		
		// 查詢
//		ArtiReportVO artiReportVO3 = new ArtiReportVO();
//		artiReportVO3.setReport_No("REP0000053");
//		artiReportVO3.setMem_No("M000061");
//		artiReportVO3.setArti_No("AR00000033");
//		artiReportVO3.setReport_Desc("妨礙風化");
//		artiReportVO3.setReport_Time(java.sql.Timestamp.valueOf("2016-01-15 10:15:28"));
//		artiReportVO3.setRep_Re_Desc(2);
//		artiReportVO3.setReport_Status("已處理");
//		System.out.println("OK!");
		
		// 查詢
		Set<ArtiReportVO> set = dao.getAllReport();
		for(ArtiReportVO aReport : set){
			System.out.println(aReport.getReport_No() + ",  ");
			System.out.println(aReport.getMem_No() + ",  ");
			System.out.println(aReport.getArti_No() + ",  ");
			System.out.println(aReport.getReport_Desc() + ",  ");
			System.out.println(aReport.getReport_Time() + ",  ");
			System.out.println(aReport.getRep_Re_Desc() + ",  ");
			System.out.println(aReport.getReport_Status() + ",  ");
		}
	}
}
