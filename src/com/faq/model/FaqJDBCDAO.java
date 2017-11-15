package com.faq.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FaqJDBCDAO implements FaqDAO_interface{

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "123456"; 
	
	private static final String INSERT_STMT=
			"INSERT INTO faq (faq_No,faq_Content,faq_Date) VALUES"
			+ " ('F'||LPAD(FAQ_NO.NEXTVAL,4,'0'),?,?)";
	
	private static final String GET_ALL_STMT=
			"SELECT faq_No,faq_Content,faq_Date FROM faq order by faq_No";
	
	private static final String SELECT=
			"SELECT faq_No,faq_Content,faq_Date FROM faq WHERE faq_No=?";
	
	private static final String UPDATE=
			"UPDATE faq SET faq_Content=? ,faq_Date=? WHERE faq_No=?";
	
	private static final String DELETE=
			"DELETE FROM faq WHERE faq_No = ?";
	
	@Override
	public void insert(FaqVO faqVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
//			pstmt.setString(1, faqVO.getFaq_No());
			pstmt.setString(1, faqVO.getFaq_Content());
			pstmt.setDate(2, faqVO.getFaq_Date());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if (pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace(System.err);
				}
			}
			if (con != null){
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void update(FaqVO faqVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, faqVO.getFaq_Content());
			pstmt.setDate(2, faqVO.getFaq_Date());
			pstmt.setString(3, faqVO.getFaq_No());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if (pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace(System.err);
				}
			}
			if (con != null){
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void delete(String faq_No) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, faq_No);
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if (pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace(System.err);
				}
			}
			if (con != null){
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public FaqVO findByPrimaryKey(String faq_No) {
		
		FaqVO faqVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SELECT);
			
			pstmt.setString(1, faq_No);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				faqVO = new FaqVO();
				faqVO.setFaq_No(rs.getString("faq_No"));
				faqVO.setFaq_Content(rs.getString("faq_Content"));
				faqVO.setFaq_Date(rs.getDate("faq_Date"));
				
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{	
			if (pstmt != null) {
				try {
					pstmt.close();
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
		return faqVO;
	}

	@Override
	public List<FaqVO> getAll() {
		List<FaqVO> list = new ArrayList<FaqVO>();
		FaqVO faqVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				faqVO = new FaqVO();
				faqVO.setFaq_No(rs.getString("faq_No"));
				faqVO.setFaq_Content(rs.getString("faq_Content"));
				faqVO.setFaq_Date(rs.getDate("faq_Date"));
				list.add(faqVO);
			}
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{	
			if (pstmt != null) {
				try {
					pstmt.close();
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
	
	public static void main(String[] args){
		FaqJDBCDAO dao = new FaqJDBCDAO();
		
		//新增
		FaqVO faqVO1 = new FaqVO();
		
		faqVO1.setFaq_Content("Ｑ5、我想藉由幫助別人增加自己的社交圈，如何知道自己還有哪些能力需要加強？ Ａ5、可以考慮到本站的排行榜，搜尋看看目前哪一類的能力的需求性比較高");
		faqVO1.setFaq_Date(Date.valueOf("2017-11-01"));
		
		dao.insert(faqVO1);
		
		//修改
		FaqVO faqVO2 = new FaqVO();
		
		faqVO2.setFaq_Content("Ｑ5、排行榜上的資料與數據多久更新一次？ Ａ6、我們有週排行、月排行、季排行，以方便增加曝光度以及有額外活動獎勵積分，積分可以到商程兌換商品");
		faqVO2.setFaq_Date(Date.valueOf("2017-11-02"));
		faqVO2.setFaq_No("F0005");
		dao.update(faqVO2);
		
		//刪除
//		dao.delete("F0005");
		
		//查詢單一
		
		FaqVO faqVO3 = dao.findByPrimaryKey("F0001");
		System.out.println(faqVO3.getFaq_No() + ",");
		System.out.println(faqVO3.getFaq_Content() + ",");
		System.out.println(faqVO3.getFaq_Date());
		System.out.println("===============================================");
		
		//查詢全部
		List<FaqVO> list = dao.getAll();
		for(FaqVO aFaq : list){
			System.out.println(aFaq.getFaq_No() + ",");
			System.out.println(aFaq.getFaq_Content() + ",");
			System.out.println(aFaq.getFaq_Date());
			System.out.println("===============================================");
		}
		
		
	}

}
