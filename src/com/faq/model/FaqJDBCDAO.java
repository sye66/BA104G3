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
	String userid = "BA104_G3";
	String passwd = "BA104"; 
	
	private static final String INSERT_STMT=
			"INSERT INTO faq (faq_no,faq_content,faq_date) VALUES"
			+ " ('F'||LPAD(FAQ_NO.NEXTVAL,4,'0'),?,?)";
	
	private static final String GET_ALL_STMT=
			"SELECT faq_no,faq_content,faq_date FROM faq order by faq_no";
	
	private static final String SELECT=
			"SELECT faq_no,faq_content,faq_date FROM faq WHERE faq_no=?";
	
	private static final String UPDATE=
			"UPDATE faq SET faq_content=? ,faq_date=? WHERE faq_no=?";
	
	private static final String DELETE=
			"DELETE FROM faq WHERE faq_no = ?";
	
	@Override
	public void insert(FaqVO faqVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
//			pstmt.setString(1, faqVO.getFaq_no());
			pstmt.setString(1, faqVO.getFaq_content());
			pstmt.setDate(2, faqVO.getFaq_date());
			
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
			
			pstmt.setString(1, faqVO.getFaq_content());
			pstmt.setDate(2, faqVO.getFaq_date());
			pstmt.setString(3, faqVO.getFaq_no());
			
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
	public void delete(String faq_no) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, faq_no);
			
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
	public FaqVO findByPrimaryKey(String faq_no) {
		
		FaqVO faqVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SELECT);
			
			pstmt.setString(1, faq_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				faqVO = new FaqVO();
				faqVO.setFaq_no(rs.getString("faq_no"));
				faqVO.setFaq_content(rs.getString("faq_content"));
				faqVO.setFaq_date(rs.getDate("faq_date"));
				
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
				faqVO.setFaq_no(rs.getString("faq_no"));
				faqVO.setFaq_content(rs.getString("faq_content"));
				faqVO.setFaq_date(rs.getDate("faq_date"));
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
		
		faqVO1.setFaq_content("Ｑ5、我想藉由幫助別人增加自己的社交圈，如何知道自己還有哪些能力需要加強？ Ａ5、可以考慮到本站的排行榜，搜尋看看目前哪一類的能力的需求性比較高");
		faqVO1.setFaq_date(Date.valueOf("2017-11-01"));
		
		dao.insert(faqVO1);
		
		//修改
		FaqVO faqVO2 = new FaqVO();
		
		faqVO2.setFaq_content("Ｑ5、排行榜上的資料與數據多久更新一次？ Ａ6、我們有週排行、月排行、季排行，以方便增加曝光度以及有額外活動獎勵積分，積分可以到商程兌換商品");
		faqVO2.setFaq_date(Date.valueOf("2017-11-02"));
		faqVO2.setFaq_no("F0005");
		dao.update(faqVO2);
		
		//刪除
//		dao.delete("F0005");
		
		//查詢單一
		
		FaqVO faqVO3 = dao.findByPrimaryKey("F0001");
		System.out.println(faqVO3.getFaq_no() + ",");
		System.out.println(faqVO3.getFaq_content() + ",");
		System.out.println(faqVO3.getFaq_date());
		System.out.println("===============================================");
		
		//查詢全部
		List<FaqVO> list = dao.getAll();
		for(FaqVO aFaq : list){
			System.out.println(aFaq.getFaq_no() + ",");
			System.out.println(aFaq.getFaq_content() + ",");
			System.out.println(aFaq.getFaq_date());
			System.out.println("===============================================");
		}
		
		
	}

}
