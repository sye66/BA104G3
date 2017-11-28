package com.artiReport.model;

import java.io.IOException;
import java.sql.*;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.naming.*;
import javax.sql.*;

public class ArtiReportDAO implements ArtiReportDAO_interface {
	
	private static DataSource ds = null;
	static{
		try{
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException ne){
			ne.printStackTrace(System.err);
		}
	}
	
	private static final String INSERT_REPORT = 
			"INSERT INTO ARTI_REPORT (REPORT_NO,MEM_NO,ARTI_NO,REPORT_DESC,REPORT_TIME,REP_RE_DESC,REPORT_STATUS) VALUES ('REP'||LPAD(to_char(ARTI_REPORT_SEQUENCE.NEXTVAL),7,'0'),?,?,?,?,?,?)";
	
	private static final String GET_ALL_REPORT= 
			"SELECT REPORT_NO,MEM_NO,ARTI_NO,REPORT_DESC,to_char(REPORT_TIME,'yyyy-mm-dd hh:mm:ss') REPORT_TIME,REP_RE_DESC,REPORT_STATUS FROM ARTI_REPORT order by REPORT_NO";
	
	private static final String GET_ONE_REPORT = 
			"SELECT REPORT_NO,MEM_NO,ARTI_NO,REPORT_DESC,to_char(REPORT_TIME,'yyyy-mm-dd hh:mm:ss') REPORT_TIME,REP_RE_DESC,REPORT_STATUS FROM ARTI_REPORT where REPORT_NO = ?";
	
	private static final String GET_REPORT_BY_ARTI_NO = 
			"SELECT REPORT_NO,MEM_NO,ARTI_NO,REPORT_DESC,to_char(REPORT_TIME,'yyyy-mm-dd hh:mm:ss') REPORT_TIME,REP_RE_DESC,REPORT_STATUS FROM ARTI_REPORT WHERE ARTI_NO = ? order by REPORT_NO";

	private static final String GET_REPORT_BY_MEM_NO = 
			"SELECT REPORT_NO,MEM_NO,ARTI_NO,REPORT_DESC,to_char(REPORT_TIME,'yyyy-mm-dd hh:mm:ss') REPORT_TIME,REP_RE_DESC,REPORT_STATUS FROM ARTI_REPORT WHERE MEM_NO = ? order by REPORT_NO";
	
	private static final String DELETE_REPORT = 
			"DELETE FROM ARTI_REPORT where REPORT_NO = ?";
	
	private static final String UPDATE_REPORT = 
			"UPDATE ARTI_REPORT set MEM_NO=?, ARTI_NO=?, REPORT_DESC=?, REPORT_TIME=?,  REP_RE_DESC=?, REPORT_STATUS=? where REPORT_NO =?";

	private static final String UPDATE_ARTI_STATUS = 
			"UPDATE ARTI_FORM set ARTI_STATUS='有檢舉未處理' where ARTI_NO =?";

	@Override
	public void insertReport(ArtiReportVO artiReportVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_REPORT);
			
			pstmt.setString(1, artiReportVO.getMem_No());
			pstmt.setString(2, artiReportVO.getArti_No());
			pstmt.setString(3, artiReportVO.getReport_Desc());
			pstmt.setTimestamp(4, artiReportVO.getReport_Time());
			pstmt.setString(5, artiReportVO.getRep_Re_Desc());
			pstmt.setString(6, artiReportVO.getReport_Status());
			pstmt.executeUpdate();
			
			pstmt = con.prepareStatement(UPDATE_ARTI_STATUS);
			pstmt.setString(1, artiReportVO.getArti_No());
			pstmt.executeUpdate();
			con.commit();
			
		} catch (SQLException se){
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new RuntimeException ("A database error occured."+se.getMessage() );
		} catch (Exception e ){
			e.printStackTrace(System.err);
		} finally {
			if(pstmt!=null){
				try{
					con.setAutoCommit(true);
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con!= null){
				try{
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
	}

	
	@Override
	public void updateReport(ArtiReportVO artiReportVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
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
			
		} catch(SQLException se){
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
	


	@Override
	public void deleteReport(String report_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_REPORT);
			
			pstmt.setString(1, report_No);
			
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

	@Override
	public ArtiReportVO findByPrimaryKey(String report_No) {
		ArtiReportVO artiReportVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
System.out.println("REPORT-DAO-G1-111");
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_REPORT);
System.out.println("REPORT-DAO-G1-222");	
			pstmt.setString(1, report_No);
System.out.println("REPORT-DAO-G1-333");
			rs = pstmt.executeQuery();
System.out.println("REPORT-DAO-G1-444");	
			while (rs.next()){
				artiReportVO = new ArtiReportVO();
				artiReportVO.setReport_No(rs.getString("report_No"));
				artiReportVO.setMem_No(rs.getString("mem_No"));
				artiReportVO.setArti_No(rs.getString("arti_No"));
				artiReportVO.setReport_Desc(rs.getString("report_Desc"));
				artiReportVO.setReport_Time(rs.getTimestamp("report_Time"));
				artiReportVO.setRep_Re_Desc(rs.getString("Rep_Re_Desc"));
				artiReportVO.setReport_Status(rs.getString("report_Status"));
			}
System.out.println(report_No);
System.out.println("REPORT-DAO-G1-555");
		} catch (SQLException se){
			throw new RuntimeException("A database error occured." + se.getMessage());
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
				} catch (Exception e){
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

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try{
			con = ds.getConnection();
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

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try{
			con = ds.getConnection();
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
	

	@Override
	public Set<ArtiReportVO> getAllReport() {
		Set<ArtiReportVO> set = new LinkedHashSet<ArtiReportVO>();
		ArtiReportVO artiReportVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			con = ds.getConnection();
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

}
