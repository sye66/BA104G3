package com.proordlist.model;

import java.sql.*;
import java.util.*;

import com.pro.model.ProVO;

public class ProOrdListJDBCDAO implements ProOrdListDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String use = "BA104G3";
	String pwd = "123456";
	
	private static final String INSERT = "INSERT INTO PRO_ORD_LIST (ORD_NO,PRO_NO,ORDPRO_COUNT,ORDPRO_PRICE) VALUES (?,?,?,?)";
	private static final String GET_ALL = "SELECT ORD_NO,PRO_NO,ORDPRO_COUNT,ORDPRO_PRICE FROM PRO_ORD_LIST ORDER BY ORD_NO";
	private static final String UPDATE = "UPDATE PRO_ORD_LIST SET ORDPRO_COUNT= ?,ORDPRO_PRICE= ? WHERE ORD_NO= ? AND PRO_NO= ?";
	private static final String DELETE = "DELETE FROM PRO_ORD_LIST WHERE ORD_NO = ?";
	private static final String GET_ONE_BY_NO = "SELECT * FROM PRO_ORD_LIST WHERE ORD_NO=?";
	
	 
	@Override
	public void insert(ProOrdListVO proOrdListVO,Connection con) {
		
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			pst = con.prepareStatement(INSERT);
			con.setAutoCommit(false);
System.out.println("開始新增清單");			
			pst.setString(1,proOrdListVO.getOrd_No());
System.out.println();			
			pst.setString(2,proOrdListVO.getPro_No());
			pst.setInt(3,proOrdListVO.getOrdPro_Count());
			pst.setInt(4,proOrdListVO.getOrdPro_Price());
			
System.out.println("清單 訂單編號"+proOrdListVO.getOrd_No());				
		
			pst.executeUpdate();
			
			

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			if (con != null) {
				try {
					System.out.println("Transaction begin, start ro_llback");
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
			
		}
		
		
		
	}

	@Override
	public void update(ProOrdListVO proOrdListVO) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(UPDATE);
			con.setAutoCommit(false);
			
			pst.setInt(1,proOrdListVO.getOrdPro_Count());
			pst.setDouble(2,proOrdListVO.getOrdPro_Price());
			pst.setString(3,proOrdListVO.getOrd_No());
			pst.setString(4,proOrdListVO.getPro_No());
			
			pst.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			System.out.println("修改成功");
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
	public void delete(String ord_No) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(DELETE);
			con.setAutoCommit(false);
			
			pst.setString(1,ord_No);
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
	public List<ProOrdListVO> getAll() {
		List<ProOrdListVO> list = new ArrayList<ProOrdListVO>(); 
		ProOrdListVO proOrdListVO = null;
		
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ALL);
			res = pst.executeQuery();
			
			while(res.next()){
				proOrdListVO = new ProOrdListVO();
				proOrdListVO.setOrd_No(res.getString("ord_No"));
				proOrdListVO.setPro_No(res.getString("pro_No"));
				proOrdListVO.setOrdPro_Count(res.getInt("ordPro_Count"));
				proOrdListVO.setOrdPro_Price(res.getInt("ordPro_Price"));
				list.add(proOrdListVO);
				
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
	public List<ProOrdListVO> findByPrimaryKey(String ord_No) {
		List<ProOrdListVO> list = new ArrayList<ProOrdListVO>(); 
		ProOrdListVO proOrdListVO = null;
		
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ONE_BY_NO);
			pst.setString(1,ord_No);
			res = pst.executeQuery();
			while(res.next()){
				proOrdListVO = new ProOrdListVO();
				proOrdListVO.setOrd_No(ord_No);
				proOrdListVO.setPro_No(res.getString("pro_No"));
				proOrdListVO.setOrdPro_Count(res.getInt("ordPro_Count"));
				proOrdListVO.setOrdPro_Price(res.getInt("ordPro_Price"));
				list.add(proOrdListVO);
			}
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}finally {
			if (res != null) {
				try {
					res.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		
		return list;
	}
	public static void main(String[] args) {
		//新增
//		ProOrdListJDBCDAO p1 = new ProOrdListJDBCDAO();
//		ProOrdListVO p1VO = new ProOrdListVO();
//		p1VO.setOrd_No("20171112-000004");
//		p1VO.setPro_No("P000004");
//		p1VO.setOrdPro_Count(10);
//		p1VO.setOrdPro_Price(400.0);
//		p1.insert(p1VO);
//		
		//修改
//		ProOrdListJDBCDAO p2 = new ProOrdListJDBCDAO();
//		ProOrdListVO p2VO = new ProOrdListVO();
//		p2VO.setOrd_No("20171023-000001");
//		p2VO.setPro_No("P000006");
//		p2VO.setOrdPro_Count(200);
//		p2VO.setOrdPro_Price(8000);
//		p2.update(p2VO);
		
		//刪除
//		ProOrdListJDBCDAO pro3 = new ProOrdListJDBCDAO();
//		pro3.delete("20171115-000002");
		
		//查詢全部
//		ProOrdListJDBCDAO pro4 = new ProOrdListJDBCDAO();
//		for(ProOrdListVO p:pro4.getAll()){
//			System.out.println(p.getOrd_No()+" "+p.getPro_No()
//			+" "+p.getOrdPro_Count()+" "+p.getOrdPro_Price());
//		}
		
		//查單個
//		ProOrdListJDBCDAO pro5 = new ProOrdListJDBCDAO();
//		for(ProOrdListVO p:pro5.getAll()){
//			System.out.println(p.getOrd_No()+" "+p.getPro_No()
//			+" "+p.getOrdPro_Count()+" "+p.getOrdPro_Price());
//		}
		
		
	}
}
