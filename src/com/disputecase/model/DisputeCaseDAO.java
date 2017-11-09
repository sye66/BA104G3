package com.disputecase.model;

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

public class DisputeCaseDAO implements DisputeCaseDAO_interface{
	private static final String INSERT_STMT = "INSERT INTO DISPUTE_CASE("
			+ "DISPUTE_CASE_NO,"
			+ "MISSION_NO,"
			+ "DISPUTE_MEM_NO,"
			+ "EMP_NO,"
			+ "ISSUE_DATE,"
			+ "CLOSE_TIME,"
			+ "DISPUTE_CASE_STATUS)"
			+ " VALUES(?,?,?,?,?,?,?)";
	private static final String GET_ONE_STMT = "SELECT * FROM DISPUTE_CASE WHERE DISPUTE_CASE_NO =?";
	private static final String GET_ALL_STMT = "SELECT * FROM DISPUTE_CASE";
	private static final String DELETE_STMT = "DELETE FROM DISPUTE_CASE WHERE DISPUTE_CASE_NO=?";
	private static final String UPDATE_STMT = "UPDATE DISPUTE_CASE SET "
			+ "MISSION_NO=?, "
			+ "DISPUTE_MEM_NO=?, "
			+ "EMP_NO=?, "
			+ "ISSUE_DATE=?, "
			+ "CLOSE_TIME=?, "
			+ "DISPUTE_CASE_STATUS=? "
			+ "WHERE DISPUTE_CASE_NO=?";
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3_TEST");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void insert(DisputeCaseVO disputeCaseVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(INSERT_STMT,1);
			
			pstmt.setString(1, disputeCaseVO.getDispute_Case_No());
			pstmt.setString(2, disputeCaseVO.getMission_No());
			pstmt.setString(3, disputeCaseVO.getDispute_Mem_No());
			pstmt.setString(4, disputeCaseVO.getEmp_No());
			pstmt.setTimestamp(5, disputeCaseVO.getIssue_Datetime());
			pstmt.setTimestamp(6, disputeCaseVO.getClose_Datetime());
			pstmt.setInt(7, disputeCaseVO.getDispute_Case_Status());
			
			pstmt.executeUpdate();
			System.out.println("新增成功");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void delete(String dispute_Case_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(DELETE_STMT);
			
			pstmt.setString(1, dispute_Case_No);
			pstmt.executeUpdate();
			
			System.out.println("刪除成功");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void update(DisputeCaseVO disputeCaseVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, disputeCaseVO.getMission_No());
			pstmt.setString(2, disputeCaseVO.getDispute_Mem_No());
			pstmt.setString(3, disputeCaseVO.getEmp_No());
			pstmt.setTimestamp(4, disputeCaseVO.getIssue_Datetime());
			pstmt.setTimestamp(5, disputeCaseVO.getClose_Datetime());
			pstmt.setInt(6, disputeCaseVO.getDispute_Case_Status());
			pstmt.setString(7, disputeCaseVO.getDispute_Case_No());
			pstmt.executeUpdate();
			
			System.out.println("更新成功");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
	}


	@Override
	public DisputeCaseVO findByprimaryKey(String dispute_Case_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		DisputeCaseVO disputeCaseVO = null;
		ResultSet rs = null;
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, dispute_Case_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				disputeCaseVO = new DisputeCaseVO();
				disputeCaseVO.setDispute_Case_No(rs.getString(1));
				disputeCaseVO.setMission_No(rs.getString(2));
				disputeCaseVO.setDispute_Mem_No(rs.getString(3));
				disputeCaseVO.setEmp_No(rs.getString(4));
				disputeCaseVO.setIssue_Datetime(rs.getTimestamp(5));
				disputeCaseVO.setClose_Datetime(rs.getTimestamp(6));
				disputeCaseVO.setDispute_Case_Status(rs.getInt(7));
			}
			
			System.out.println("主鍵查詢完畢");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
		return disputeCaseVO;
	}

	@Override
	public List<DisputeCaseVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		DisputeCaseVO disputeCaseVO = null;
		ResultSet rs = null;
		List<DisputeCaseVO> listAllDisputeCase = new ArrayList<>();
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				disputeCaseVO = new DisputeCaseVO();
				disputeCaseVO.setDispute_Case_No(rs.getString(1));
				disputeCaseVO.setMission_No(rs.getString(2));
				disputeCaseVO.setDispute_Mem_No(rs.getString(3));
				disputeCaseVO.setEmp_No(rs.getString(4));
				disputeCaseVO.setIssue_Datetime(rs.getTimestamp(5));
				disputeCaseVO.setClose_Datetime(rs.getTimestamp(6));
				disputeCaseVO.setDispute_Case_Status(rs.getInt(7));
				listAllDisputeCase.add(disputeCaseVO);
			}
			
			System.out.println("全部查詢完畢");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
		return listAllDisputeCase;
	}
}
