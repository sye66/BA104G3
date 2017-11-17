package com.rank.model;

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

import com.emp.model.EmpVO;

public class RankDAO implements RankDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT = 
			"INSERT INTO RANK(mem_No,day_Number_Rank,day_Score_Rank,week_Number_Rank,month_Number_Rank,season_Number_Rank,week_Score_Rank,month_Score_Rank,season_Score_Rank)VALUES(?,?,?,?,?,?,?,?,?)";
	private static final String GET_ALL = 
			"SELECT mem_No,day_Number_Rank,day_Score_Rank,week_Number_Rank,month_Number_Rank,season_Number_Rank,week_Score_Rank,month_Score_Rank,season_Score_Rank FROM rank order by mem_NO";
	private static final String GET_ONE = 
			"SELECT mem_No,day_Number_Rank,day_Score_Rank,week_Number_Rank,month_Number_Rank,season_Number_Rank,week_Score_Rank,month_Score_Rank,season_Score_Rank FROM rank where mem_NO = ?";
	private static final String DELETE = 
			"DELETE FROM rank where mem_no = ?";

	@Override
	public void insert(RankVO rankVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);

			pstmt.setString(1, rankVO.getDay_Number_Rank());
			pstmt.setString(2, rankVO.getDay_Score_Rank());
			pstmt.setString(3, rankVO.getWeek_Number_Rank());
			pstmt.setString(4, rankVO.getMonth_Number_Rank());
			pstmt.setString(5, rankVO.getSeason_Number_Rank());
			pstmt.setString(6, rankVO.getWeek_Score_Rank());
			pstmt.setString(7, rankVO.getMonth_Score_Rank());
			pstmt.setString(8, rankVO.getMonth_Score_Rank());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
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

	}

	@Override
	public RankVO findByPrimaryKey(String mem_No) {
		RankVO rankVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setString(1, mem_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				rankVO = new RankVO();
				rankVO.setMem_No(rs.getString("mem_No"));
				rankVO.setDay_Number_Rank(rs.getString("day_Number_Rank"));
				rankVO.setDay_Score_Rank(rs.getString("day_Score_Rank"));
				rankVO.setWeek_Number_Rank(rs.getString("week_Number_Rank"));
				rankVO.setMonth_Number_Rank(rs.getString("month_Number_Rank"));
				rankVO.setSeason_Number_Rank(rs.getString("season_Number_Rank"));
				rankVO.setWeek_Score_Rank(rs.getString("week_Score_Rank"));
				rankVO.setMonth_Score_Rank(rs.getString("month_Score_Rank"));
				rankVO.setSeason_Score_Rank(rs.getString("season_Score_Rank"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return rankVO;
	}

	@Override
	public List<RankVO> getAll() {
		List<RankVO> list = new ArrayList<RankVO>();
		RankVO rankVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO �]�٬� Domain objects
				rankVO = new RankVO();
				rankVO.setMem_No(rs.getString("mem_No"));
				rankVO.setDay_Number_Rank(rs.getString("day_Number_Rank"));
				rankVO.setDay_Score_Rank(rs.getString("day_Score_Rank"));
				rankVO.setWeek_Number_Rank(rs.getString("week_Number_Rank"));
				rankVO.setMonth_Number_Rank(rs.getString("month_Number_Rank"));
				rankVO.setSeason_Number_Rank(rs.getString("season_Number_Rank"));
				rankVO.setWeek_Score_Rank(rs.getString("week_Score_Rank"));
				rankVO.setMonth_Score_Rank(rs.getString("month_Score_Rank"));
				rankVO.setSeason_Score_Rank(rs.getString("season_Score_Rank"));
				list.add(rankVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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

	@Override
	public void delete(String mem_No) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, mem_No);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
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

	}
}
