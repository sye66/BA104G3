package com.proclass.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import com.pro.model.ProVO;


public class ProClassJDBCDAO implements ProClassDAO_interface{
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String use = "BA104G3";
	String pwd = "123456";
	
	private static final String INSERT = "INSERT INTO PRO_CLASS VALUES('C'||LPAD(PRO_CLASS_SEQ.NEXTVAL,4,0),?)";
	private static final String UPDATE = "UPDATE PRO_CLASS SET PRO_CLASS_NAME=? WHERE PRO_CLASS_NO=?";
	private static final String DELETE = "DELETE FROM PRO_CLASS WHERE PRO_CLASS_NO=?";
	private static final String GET_ALL = "SELECT * FROM PRO_CLASS ORDER BY PRO_CLASS_NO";
	private static final String GET_ONE_BY_CLASS_NO = "SELECT PRO_CLASS_NAME FROM PRO_CLASS WHERE PRO_CLASS_NO=?";
	//找單一類型商品
	private static final String GET_ONE_CLASS_PRO="SELECT * FROM PRO WHERE PRO_CLASS_NO=?";
	
	@Override
	public void insert(ProClassVO proClassVO) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(INSERT);
			
			con.setAutoCommit(false);
			pst.setString(1, proClassVO.getPro_Class_Name());
			
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
	public void update(ProClassVO proClassVO) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(UPDATE);
		    con.setAutoCommit(false);
		    
		    pst.setString(1, proClassVO.getPro_Class_Name());
		    pst.setString(2, proClassVO.getPro_Class_No());
		    
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
					System.out.println("Transaction begin, start ro_llback");
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
	public void delete(String pro_Class_No) {
		Connection con = null;
		PreparedStatement pst = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(DELETE);
			con.setAutoCommit(false);

			pst.setString(1, pro_Class_No);
			
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
	public List<ProClassVO> getAll() {
		List<ProClassVO> list = new ArrayList<ProClassVO>();
		ProClassVO proClassVO= null;
		
		Connection con = null;
		PreparedStatement pst= null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ALL);
			res = pst.executeQuery();
			
			while(res.next()){
				proClassVO = new ProClassVO();
				proClassVO.setPro_Class_No(res.getString("pro_Class_No"));
				proClassVO.setPro_Class_Name(res.getString("pro_Class_Name"));
				list.add(proClassVO);
				
			}
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " 
					+ e.getMessage());
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
	public ProClassVO findByPrimaryKey(String pro_Class_No) {
		ProClassVO proClassVO = null;
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ONE_BY_CLASS_NO);
			
			pst.setString(1,pro_Class_No);
			
			res = pst.executeQuery();
			res.next();
			
			proClassVO = new ProClassVO();
			
			proClassVO.setPro_Class_No(pro_Class_No);
			proClassVO.setPro_Class_Name(res.getString("pro_Class_Name"));
			
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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
		
		return proClassVO;
	}
	
	@Override
	public Set<ProVO>getOneClassPro(String pro_Class_No) {
		Set<ProVO> set = new LinkedHashSet<ProVO>();
		ProVO proVO= null;
		
		Connection con = null;
		PreparedStatement pst= null;
		ResultSet res = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,use,pwd);
			pst = con.prepareStatement(GET_ONE_CLASS_PRO);
			pst.setString(1,pro_Class_No);
			res = pst.executeQuery();
			
			while(res.next()){
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
				set.add(proVO);
				
			}
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " 
					+ e.getMessage());
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
		
		return set;
	}

	public static void main(String[] args) {
		//新增
//		ProClassJDBCDAO p1 = new ProClassJDBCDAO();
//		ProClassVO proClassVO = new ProClassVO();
//		proClassVO.setPro_Class_Name("PPP");
//		p1.insert(proClassVO);
		
		//查詢全部
//		ProClassJDBCDAO p2 = new ProClassJDBCDAO();
//		for(ProClassVO p:p2.getAll()){
//			System.out.println(p.getPro_Class_No()+"  "+p.getPro_Class_Name());
//		}
		
//		//修改
//		ProClassJDBCDAO p3 = new ProClassJDBCDAO();
//		ProClassVO proClassVO3 = new ProClassVO();
//		proClassVO3.setPro_Class_Name("99999");
//		proClassVO3.setPro_Class_No("p111");
//		p3.insert(proClassVO3);
//		
//		//刪除
//		ProClassJDBCDAO p4 = new ProClassJDBCDAO();
//		p4.delete("C0009");
		
		//查單個
//		ProClassJDBCDAO p5 = new ProClassJDBCDAO();
//		ProClassVO pVO5 = p5.findByPrimaryKey("C0001");
//		System.out.println(pVO5.getPro_Class_No()+"  "+pVO5.getPro_Class_Name());
//	}

	   //查一類商品
		ProClassJDBCDAO p6 = new ProClassJDBCDAO();
		for(ProVO p:p6.getOneClassPro("C0001")){
			System.out.println(p.getPro_No()+" "+p.getPro_Name()
			+" "+p.getPro_Price()+" "+p.getPro_Discount()
			+" "+p.getPro_Dis_StartDate()+" "+p.getPro_Dis_EndDate()
			+" "+p.getPro_Class_No()+" "+p.getPro_Status()
			+" "+p.getPro_Info());
		}
		
		
		
		}
	
}
