package com.proorder.model;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import com.pro.model.ProJDBCDAO;
import com.pro.model.ProVO;

public class ProOrderJDBCDAO implements ProOrderDAO_interface{

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String use = "BA104G3";
	String pwd = "123456";
	
	private static final String INSERT = "INSERT INTO PRO_ORDER (ORD_NO,MEM_NO,ORD_DATE,ORD_PRICE,ORD_CONSIGNEE,ORD_ADDRESS,ORD_PHONE,ORD_SHIPINFO,ORD_SHIP_DATE) VALUES (TO_CHAR(SYSDATE,'YYYYmmdd')||'-'||LPAD(TO_CHAR(PRO_ORDER_SEQ.NEXTVAL),6,'0'),?,?,?,?,?,?,?,?)";
	private static final String GET_ALL = "SELECT ORD_NO,MEM_NO,ORD_DATE,ORD_PRICE,ORD_CONSIGNEE,ORD_ADDRESS,ORD_PHONE,ORD_SHIPINFO,Ord_Ship_Date FROM PRO_ORDER ORDER BY ORD_NO";
	private static final String UPDATE_ORDER = "UPDATE PRO_ORDER SET ORD_CONSIGNEE= ?,ORD_ADDRESS= ?,ORD_PHONE= ?,ORD_SHIPINFO= ?,ORD_SHIP_DATE= ? WHERE ORD_NO=?";
	private static final String DELETE = "DELETE FROM PRO_ORDER WHERE ORD_NO = ?";
	private static final String GET_ONE_BY_NO = "SELECT * FROM PRO_ORDER WHERE ORD_NO=?";
	
	
	@Override
	public void insert(ProOrderVO proOrderVO) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(INSERT);
			
			con.setAutoCommit(false);
			
			
			pst.setString(1,proOrderVO.getMem_No());
			pst.setDate(2,proOrderVO.getOrd_Date());
			pst.setInt(3,proOrderVO.getOrd_Price());
			pst.setString(4,proOrderVO.getOrd_Consignee());
			pst.setString(5,proOrderVO.getOrd_Address());
			pst.setString(6,proOrderVO.getOrd_Phone());
			pst.setString(7,proOrderVO.getOrd_Shipinfo());
			pst.setDate(8,proOrderVO.getOrd_Ship_Date());
			
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
	public void update(ProOrderVO proOrderVO) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, use, pwd);
			pst = con.prepareStatement(UPDATE_ORDER);
			con.setAutoCommit(false);
			
			pst.setString(1,proOrderVO.getOrd_Consignee());
			pst.setString(2,proOrderVO.getOrd_Address());
			pst.setString(3,proOrderVO.getOrd_Phone());
			pst.setString(4,proOrderVO.getOrd_Shipinfo());
			pst.setDate(5,proOrderVO.getOrd_Ship_Date());
			pst.setString(6,proOrderVO.getOrd_No());
			
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
			throw new RuntimeException("A database erro_r occured. " + e.getMessage());
			
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
	public List<ProOrderVO> getAll() {
		List<ProOrderVO> list = new ArrayList<ProOrderVO>();
		ProOrderVO proOrderVO = null;
		
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ALL);
			res = pst.executeQuery();
			
			while(res.next()){
				proOrderVO = new ProOrderVO();
				proOrderVO.setOrd_No(res.getString("ord_No"));
				proOrderVO.setMem_No(res.getString("mem_No"));
				proOrderVO.setOrd_Date(res.getDate("ord_Date"));
				proOrderVO.setOrd_Price(res.getInt("ord_Price"));
				proOrderVO.setOrd_Consignee(res.getString("ord_Consignee"));
				proOrderVO.setOrd_Address(res.getString("ord_Address"));
				proOrderVO.setOrd_Phone(res.getString("ord_Phone"));
				proOrderVO.setOrd_Shipinfo(res.getString("ord_Shipinfo"));
				proOrderVO.setOrd_Ship_Date(res.getDate("ord_Ship_Date"));
				list.add(proOrderVO);
				
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

	@Override
	public ProOrderVO findByPrimaryKey(String ord_No) {
		ProOrderVO proOrderVO = null;
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet res = null;
				
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ONE_BY_NO);
			
			pst.setString(1,ord_No);
			res = pst.executeQuery();
			res.next();
			
			proOrderVO = new ProOrderVO();
			proOrderVO.setOrd_No(res.getString("ord_No"));
			proOrderVO.setMem_No(res.getString("mem_No"));
			proOrderVO.setOrd_Date(res.getDate("ord_Date"));
			proOrderVO.setOrd_Price(res.getInt("ord_Price"));
			proOrderVO.setOrd_Consignee(res.getString("ord_Consignee"));
			proOrderVO.setOrd_Address(res.getString("ord_Address"));
			proOrderVO.setOrd_Phone(res.getString("ord_Phone"));
			proOrderVO.setOrd_Shipinfo(res.getString("ord_Shipinfo"));
			proOrderVO.setOrd_Ship_Date(res.getDate("ord_Ship_Date"));
			
			
			
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
		
				
		return proOrderVO;
	}

	public static void main(String[] args) {
		ProOrderJDBCDAO p1 = new ProOrderJDBCDAO();
		ProOrderVO p1VO = new ProOrderVO();
		
		//新增
//		p1VO.setMem_No("M0001");
//		p1VO.setOrd_Date(java.sql.Date.valueOf("2017-10-30"));
//		p1VO.setOrd_Price(500);
//		p1VO.setOrd_Consignee("ggg");
//		p1VO.setOrd_Address("桃園桃園桃園桃園桃園桃園");
//		p1VO.setOrd_Phone("tttt");
//		p1VO.setOrd_Shipinfo("fffff");
//		p1VO.setOrd_Ship_Date(null);
//		p1.insert(p1VO);
		
		//修改
//		ProOrderJDBCDAO p4 = new ProOrderJDBCDAO();
//		ProOrderVO p4VO = new ProOrderVO();
//		
//		p4VO.setOrd_Consignee("ggg");
//		p4VO.setOrd_Address("桃園fffff桃園桃園桃園桃園桃園");
//		p4VO.setOrd_Phone("ttttffff");
//		p4VO.setOrd_Shipinfo("fgggffff");
//		p4VO.setOrd_Ship_Date(java.sql.Date.valueOf("2017-10-30"));
//		p4VO.setOrd_No("20171026-000003");
//		p4.update(p4VO);
//		
		
		
		//查全部
		ProOrderJDBCDAO p2 = new ProOrderJDBCDAO();
		for(ProOrderVO pvo2:p2.getAll()){
			System.out.println(pvo2.getOrd_No()
			+" "+pvo2.getMem_No()+" "+pvo2.getOrd_Date()
			+" "+pvo2.getOrd_Price()+" "+pvo2.getOrd_Consignee()
			+" "+pvo2.getOrd_Address()+" "+pvo2.getOrd_Phone()
			+" "+pvo2.getOrd_Shipinfo()+" "+pvo2.getOrd_Ship_Date());
		}
		
		//刪除
//		ProOrderJDBCDAO p3 = new ProOrderJDBCDAO();
//		p3.delete("20171026-000014");
	
		//查單個
		ProOrderJDBCDAO p5 = new ProOrderJDBCDAO();
		ProOrderVO p5VO = p5.findByPrimaryKey("20171026-000002");
		System.out.println(p5VO.getOrd_No()
				+" "+p5VO.getMem_No()+" "+p5VO.getOrd_Date()
				+" "+p5VO.getOrd_Price()+" "+p5VO.getOrd_Consignee()
				+" "+p5VO.getOrd_Address()+" "+p5VO.getOrd_Phone()
				+" "+p5VO.getOrd_Shipinfo()+" "+p5VO.getOrd_Ship_Date());
	}
}
