package com.protrack.model;

import java.sql.*;
import java.util.*;

public class ProTrackJDBCDAO implements ProTrackDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String use = "BA104G3";
	String pwd = "123456";
	private static final String INSERT = "INSERT INTO PRO_TRACK (MEM_NO,PRO_NO) VALUES (?,?)";
	private static final String GET_ALL = "SELECT * FROM PRO_TRACK ORDER BY MEM_NO";
//	private static final String UPDATE = "UPDATE PRO SET PRO_NAME= ?,PRO_PRICE= ?,PRO_INFO= ?,PRO_CLASS_NO= ?,PRO_STATUS= ? WHERE PRO_NO=?";
	private static final String DELETE = "DELETE FROM PRO_TRACK WHERE MEM_NO = ? AND PRO_NO=?";
	private static final String GET_ONE_BY_NO = "SELECT * FROM PRO_TRACK WHERE MEM_NO=?";
	
	@Override
	public void insert(ProTrackVO proTrackVO) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(INSERT);
			
			con.setAutoCommit(false);
			
			pst.setString(1, proTrackVO.getMem_No());
			pst.setString(2, proTrackVO.getPro_No());
			
			pst.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			System.out.println("新增成功");			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			if (con != null) {
				try {
					System.out.println("Transaction begin, start rollback");
					con.rollback();
				} catch (Exception se) {
					System.out.println(se.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}finally {
			if (pst != null) {
				try {
					pst.close();
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
	public void delete(String mem_No,String pro_No) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(DELETE);
			con.setAutoCommit(false);
			
			pst.setString(1,mem_No);
			pst.setString(2,pro_No);
			
			pst.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			System.out.println("刪除成功");
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			if (con != null) {
				try {
					System.out.println("Transaction begin, start rollback");
					con.rollback();
				} catch (Exception se) {
					System.out.println(se.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + e.getMessage());
			
		}finally {
			if (pst != null) {
				try {
					pst.close();
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
	public List<ProTrackVO> getAll() {
		List<ProTrackVO> list = new ArrayList<ProTrackVO>();
		ProTrackVO proTrackVO = null;
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ALL);
			res = pst.executeQuery();
			
			while(res.next()){
				proTrackVO = new ProTrackVO();
				proTrackVO.setMem_No(res.getString("mem_No"));
				proTrackVO.setPro_No(res.getString("pro_No"));
				
				list.add(proTrackVO);
				
				
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}finally{
			if(res!=null){
				try {
					res.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pst!=null){
				try {
					pst.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	@Override
	public List<ProTrackVO> findByPrimaryKey(String mem_No) {
		List<ProTrackVO> list = new ArrayList<ProTrackVO>();
		ProTrackVO proTrackVO = null;
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ONE_BY_NO);
			pst.setString(1,mem_No);
			res = pst.executeQuery();
			
			while(res.next()){
				proTrackVO = new ProTrackVO();
				proTrackVO.setMem_No(res.getString("mem_No"));
				proTrackVO.setPro_No(res.getString("pro_No"));
				
				list.add(proTrackVO);
				
				
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}finally{
			if(res!=null){
				try {
					res.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pst!=null){
				try {
					pst.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	public static void main(String[] args) {
		
		//新增
//		ProTrackJDBCDAO p1 = new ProTrackJDBCDAO();
//		ProTrackVO p1VO = new ProTrackVO();
//		p1VO.setMem_No("M0002");
//		p1VO.setPro_No("P000003");
//		p1.insert(p1VO);
		
		//刪除
		ProTrackJDBCDAO p2 = new ProTrackJDBCDAO();
		
		p2.delete("M000001","P000001");
		
		//查全部
//		ProTrackJDBCDAO p3 = new ProTrackJDBCDAO();
//		for(ProTrackVO p:p3.getAll()){
//			System.out.println(p.getMem_No()+" "+p.getPro_No());
//		}
		
		//查單
		ProTrackJDBCDAO p4 = new ProTrackJDBCDAO();
		for(ProTrackVO p:p4.findByPrimaryKey("M000001")){
			System.out.println(p.getMem_No()+" "+p.getPro_No());
		}
		
		
	}
}
