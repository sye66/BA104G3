package com.faq.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class FaqDAO implements FaqDAO_interface{

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
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
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, faqVO.getFaq_content());
			pstmt.setDate(2, faqVO.getFaq_date());
			
			pstmt.executeUpdate();
		}  catch (SQLException e) {
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, faqVO.getFaq_content());
			pstmt.setDate(2, faqVO.getFaq_date());
			pstmt.setString(3, faqVO.getFaq_no());
			
			pstmt.executeUpdate();
		}  catch (SQLException e) {
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
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, faq_no);
			
			pstmt.executeUpdate();
			
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
		
		FaqVO faqVO = new FaqVO();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SELECT);
pstmt.setString(1, faq_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				faqVO = new FaqVO();
				faqVO.setFaq_no(rs.getString("faq_no"));
				faqVO.setFaq_content(rs.getString("faq_content"));
				faqVO.setFaq_date(rs.getDate("faq_date"));
				
			}
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
		FaqVO faqVO = null;Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		
		
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			while(rs.next()){
				
				faqVO = new FaqVO();
				faqVO.setFaq_no(rs.getString("faq_no"));
				faqVO.setFaq_content(rs.getString("faq_content"));
				faqVO.setFaq_date(rs.getDate("faq_date"));
				list.add(faqVO);
			}
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

}
