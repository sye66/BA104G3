package com.pro.model;

import java.io.*;
import java.sql.*;
import java.util.*;



public class ProJDBCDAO implements ProDAO_interface{
	
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String use = "BA104G3";
	String pwd = "123456";
	private static final String INSERT = "INSERT INTO PRO (PRO_NO,PRO_NAME,PRO_PRICE,PRO_INFO,PRO_CLASS_NO,PRO_STATUS,PRO_DISCOUNT,PRO_DIS_STARTDATE,PRO_DIS_ENDDATE,PRO_PIC) VALUES ('P'||LPAD(PRO_SEQ.NEXTVAL,6,'0'),?,?,?,?,?,?,?,?,?)";
	private static final String GET_ALL = "SELECT * FROM PRO ORDER BY PRO_NO";
	private static final String UPDATE = "UPDATE PRO SET PRO_NAME= ?,PRO_PRICE= ?,PRO_INFO= ?,PRO_CLASS_NO= ?,PRO_STATUS= ?,PRO_DISCOUNT=?,PRO_DIS_STARTDATE=?,PRO_DIS_ENDDATE=?, PRO_PIC=? WHERE PRO_NO=?";
	private static final String DELETE = "DELETE FROM PRO WHERE PRO_NO = ?";
	private static final String GET_ONE_BY_NO = "SELECT PRO_NO,PRO_NAME,PRO_PRICE,PRO_INFO,PRO_CLASS_NO,Pro_STATUS,PRO_DISCOUNT,PRO_DIS_STARTDATE,PRO_DIS_ENDDATE,PRO_PIC FROM PRO WHERE PRO_NO=?";
	//促銷商品
	private static final String GET_HOT_PRO = "SELECT PRO_NO,PRO_NAME,PRO_PRICE,PRO_INFO,PRO_CLASS_NO,Pro_STATUS,PRO_DISCOUNT,PRO_DIS_STARTDATE,PRO_DIS_ENDDATE,PRO_PIC FROM PRO WHERE PRO_DISCOUNT != 100";
	//Top10
	private static final String GET_TOP10_PRO = "SELECT PRO_NO FROM PRO_ORD_LIST GROUP BY PRO_NO ORDER BY SUM(ORDPRO_COUNT) DESC";
	
	@Override
	public void insert(ProVO proVO) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(INSERT);
			
			con.setAutoCommit(false);
			
			pst.setString(1, proVO.getPro_Name());
			pst.setDouble(2, proVO.getPro_Price());
			pst.setString(3, proVO.getPro_Info());
			pst.setString(4, proVO.getPro_Class_No());
			pst.setString(5, proVO.getPro_Status());
			pst.setInt(6,proVO.getPro_Discount());
			pst.setDate(7,proVO.getPro_Dis_StartDate());
			pst.setDate(8,proVO.getPro_Dis_EndDate());
			pst.setBytes(9,proVO.getPro_Pic());
			
			pst.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
					
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
	public void update(ProVO proVO) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(UPDATE);
			con.setAutoCommit(false);
			
			pst.setString(1, proVO.getPro_Name());
			pst.setDouble(2, proVO.getPro_Price());
			pst.setString(3, proVO.getPro_Info());
			pst.setString(4, proVO.getPro_Class_No());
			pst.setString(5, proVO.getPro_Status());
			pst.setInt(6,proVO.getPro_Discount());
			pst.setDate(7,proVO.getPro_Dis_StartDate());
			pst.setDate(8,proVO.getPro_Dis_EndDate());
			pst.setBytes(9,proVO.getPro_Pic());
			pst.setString(10, proVO.getPro_No());
			
			pst.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
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
	public void delete(String pro_No) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(DELETE);
			con.setAutoCommit(false);
			
			pst.setString(1,pro_No);
			pst.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			
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
	public List<ProVO> getAll() {
		List<ProVO> list = new ArrayList<ProVO>(); 
		ProVO proVO = null;
		
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ALL);
			res = pst.executeQuery();
			
			while(res.next()){
				proVO = new ProVO();
				proVO.setPro_No(res.getString("pro_No"));
				proVO.setPro_Name(res.getString("pro_Name"));
				proVO.setPro_Price(res.getDouble("pro_Price"));
				proVO.setPro_Info(res.getString("pro_Info"));
				proVO.setPro_Class_No(res.getString("pro_Class_No"));
				proVO.setPro_Status(res.getString("pro_Status"));
				proVO.setPro_Discount(res.getInt("pro_Discount"));
				proVO.setPro_Dis_StartDate(res.getDate("Pro_Dis_StartDate"));
				proVO.setPro_Dis_EndDate(res.getDate("Pro_Dis_EndDate"));
				proVO.setPro_Pic(res.getBytes("Pro_Pic"));
				list.add(proVO);
				
			}
			//打亂商品
//			for (int i = 1; i < 5; i++) {
//		        Collections.shuffle(list);
//		    }
			
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
	public ProVO findByPrimaryKey(String pro_No) {
		ProVO proVO = null;
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ONE_BY_NO);
			pst.setString(1,pro_No);
			res = pst.executeQuery();
			res.next();
			
			proVO = new ProVO();
			proVO.setPro_No(res.getString("pro_No"));
			proVO.setPro_Name(res.getString("pro_Name"));
			proVO.setPro_Price(res.getDouble("pro_Price"));
			proVO.setPro_Info(res.getString("pro_Info"));
			proVO.setPro_Status(res.getString("pro_Status"));
			proVO.setPro_Class_No(res.getString("pro_Class_No"));
			proVO.setPro_Discount(res.getInt("pro_Discount"));
			proVO.setPro_Dis_StartDate(res.getDate("Pro_Dis_StartDate"));
			proVO.setPro_Dis_EndDate(res.getDate("Pro_Dis_EndDate"));
			proVO.setPro_Pic(res.getBytes("Pro_Pic"));
		
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
		return proVO;
	}
	
	@Override
	public List<ProVO> getAll(Map<String, String[]> map) {
		List<ProVO> list = new ArrayList<ProVO>();
		ProVO proVO = null;
		
		Connection con = null;
		PreparedStatement pst= null;
		ResultSet res = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			
			String finalSQL = "select * from pro "
			+jdbcUtil_CompositeQuery_Pro.get_WhereCondition(map)
			+ "order by pro_No";
			pst = con.prepareStatement(finalSQL);
			
			res = pst.executeQuery();
			
			while (res.next()) {
				proVO = new ProVO();
				proVO.setPro_No(res.getString("pro_No"));
				proVO.setPro_Name(res.getString("pro_Name"));
				proVO.setPro_Price(res.getDouble("pro_Price"));
				proVO.setPro_Info(res.getString("pro_Info"));
				proVO.setPro_Status(res.getString("pro_Status"));
				proVO.setPro_Class_No(res.getString("pro_Class_No"));
				proVO.setPro_Discount(res.getInt("pro_Discount"));
				proVO.setPro_Dis_StartDate(res.getDate("Pro_Dis_StartDate"));
				proVO.setPro_Dis_EndDate(res.getDate("Pro_Dis_EndDate"));
				list.add(proVO); // Store the row in the List
			}
System.out.println("指令"+finalSQL);			
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
	public List<ProVO> getHot() {
		List<ProVO> list = new ArrayList<ProVO>();
		ProVO proVO = null;
		
		Connection con = null;
		PreparedStatement pst= null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			
			
			pst = con.prepareStatement(GET_HOT_PRO);
			
			res = pst.executeQuery();
			
			while (res.next()) {
				proVO = new ProVO();
				proVO.setPro_No(res.getString("pro_No"));
				proVO.setPro_Name(res.getString("pro_Name"));
				proVO.setPro_Price(res.getDouble("pro_Price"));
				proVO.setPro_Info(res.getString("pro_Info"));
				proVO.setPro_Status(res.getString("pro_Status"));
				proVO.setPro_Class_No(res.getString("pro_Class_No"));
				proVO.setPro_Discount(res.getInt("pro_Discount"));
				proVO.setPro_Dis_StartDate(res.getDate("Pro_Dis_StartDate"));
				proVO.setPro_Dis_EndDate(res.getDate("Pro_Dis_EndDate"));
				list.add(proVO); // Store the row in the List
			}
			for (int i = 1; i < 5; i++) {
		        Collections.shuffle(list);
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
	public List<ProVO> getTop10() {
		List<ProVO> list = new ArrayList<ProVO>();
		List<String> listProNO = new ArrayList<String>();
		ProVO proVO = null;
		
		Connection con = null;
		PreparedStatement pst= null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			
			pst = con.prepareStatement(GET_TOP10_PRO);
			
			res = pst.executeQuery();
			
			while (res.next()) {
				
				String proNo =res.getString("pro_No");
				listProNO.add(proNo);
				
			}
			
			for (String proNO:listProNO) {
				
				pst = con.prepareStatement(GET_ONE_BY_NO);
				pst.setString(1,proNO);
				res = pst.executeQuery();
				res.next();
				
				proVO = new ProVO();
				proVO.setPro_No(res.getString("pro_No"));
				proVO.setPro_Name(res.getString("pro_Name"));
				proVO.setPro_Price(res.getDouble("pro_Price"));
				proVO.setPro_Info(res.getString("pro_Info"));
				proVO.setPro_Status(res.getString("pro_Status"));
				proVO.setPro_Class_No(res.getString("pro_Class_No"));
				proVO.setPro_Discount(res.getInt("pro_Discount"));
				proVO.setPro_Dis_StartDate(res.getDate("Pro_Dis_StartDate"));
				proVO.setPro_Dis_EndDate(res.getDate("Pro_Dis_EndDate"));
				list.add(proVO); // Store the row in the List
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

	
public static void main(String[] args) throws IOException {
	


	//新增
//	ProJDBCDAO pro1 = new ProJDBCDAO();
//	ProVO proVO = new ProVO();
//	proVO.setPro_Name("XXX");
//	proVO.setPro_Price(100);
//	proVO.setPro_Info("XXXXX");
//	proVO.setPro_Class_No("C0001");
//	proVO.setPro_Status("XX");
//	proVO.setPro_Discount(100);
//	proVO.setPro_Dis_StartDAte(java.sql.Date.valueOf("2017-10-01"));
//	proVO.setPro_Dis_EndDate(java.sql.Date.valueOf("2017-11-01"));
//	proVO.setPro_Pic(pro_pic);
//	pro1.insert(proVO);
	//修改
//	ProJDBCDAO pro3 = new ProJDBCDAO();
//	ProVO proVO3 = new ProVO();
//	proVO3.setPro_Name("SSSS");
//	proVO3.setPro_Price(100);
//	proVO3.setPro_Info("SSSSSS");
//	proVO3.setPro_Class_No("C0001");
//	proVO3.setPro_Status("SS");
//	proVO3.setPro_Discount(100);
//	proVO3.setPro_Dis_StartDAte(java.sql.Date.valueOf("2017-10-01"));
//	proVO3.setPro_Dis_EndDate(java.sql.Date.valueOf("2017-11-01"));
//	proVO3.setPro_Pic(pro_pic);
//	proVO3.setPro_No("P000002");
//	pro3.update(proVO3);
	//查全部
//	ProJDBCDAO pro2 = new ProJDBCDAO();
//	for(ProVO p:pro2.getAll()){
//		System.out.println(p.getPro_No()+" "+p.getPro_Name()
//		+" "+p.getPro_Price()+" "+p.getPro_Discount()
//		+" "+p.getPro_Dis_StartDate()+" "+p.getPro_Dis_EndDate()
//		+" "+p.getPro_Class_No()+" "+p.getPro_Status()
//		+" "+p.getPro_Info());
//	}
//	
    //刪除
//	ProJDBCDAO pro5 = new ProJDBCDAO();
//	pro5.delete("P000012");
	//查單個
//	ProJDBCDAO pro4 = new ProJDBCDAO();
//	ProVO p =pro4.findByPrimaryKey("P000001");
//	System.out.println(p.getPro_No()+" "+p.getPro_Name()
//	+" "+p.getPro_Price()+" "+p.getPro_Discount()
//	+" "+p.getPro_Dis_StartDate()+" "+p.getPro_Dis_EndDate()
//	+" "+p.getPro_Class_No()+" "+p.getPro_Status()
//	+" "+p.getPro_Info());
	

	ProJDBCDAO pro5 = new ProJDBCDAO();
	Map<String, String[]> map=null;
	String[] s={"小"};
	
	List<ProVO> ppp = (List<ProVO>) pro5.getAll(map);
	for(ProVO p: ppp){
	System.out.println(p.getPro_No()+" "+p.getPro_Name()
	+" "+p.getPro_Price()+" "+p.getPro_Discount()
	+" "+p.getPro_Dis_StartDate()+" "+p.getPro_Dis_EndDate()
	+" "+p.getPro_Class_No()+" "+p.getPro_Status()
	+" "+p.getPro_Info());
	}

	
  }
}




