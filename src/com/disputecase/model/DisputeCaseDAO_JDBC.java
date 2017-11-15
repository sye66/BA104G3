package com.disputecase.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class DisputeCaseDAO_JDBC implements DisputeCaseDAO_interface{
	private static final String DRIVER = "oracle.jdbc.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USR = "BA104G3";
	private static final String PSW = "123456";
	
	private static final String INSERT_STMT = "INSERT INTO DISPUTE_CASE("
			+ "DISPUTE_CASE_NO,"
			+ "MISSION_NO,"
			+ "DISPUTE_MEM_NO,"
			+ "EMP_NO,"
			+ "ISSUE_DATETIME,"
			+ "CLOSE_DATETIME,"
			+ "DISPUTE_CASE_STATUS)"
			+ " VALUES('DIS'||LPAD(to_char(SEQ_DIS_CASE_NO.NEXTVAL),6,'0'),?,?,?,?,?,?)";
	private static final String GET_ONE_STMT = "SELECT * FROM DISPUTE_CASE WHERE DISPUTE_CASE_NO =?";
	private static final String GET_ALL_STMT = "SELECT * FROM DISPUTE_CASE";
	private static final String DELETE_STMT = "DELETE FROM DISPUTE_CASE WHERE DISPUTE_CASE_NO=?";
	private static final String UPDATE_STMT = "UPDATE DISPUTE_CASE SET "
			+ "MISSION_NO=?, "
			+ "DISPUTE_MEM_NO=?, "
			+ "EMP_NO=?, "
			+ "ISSUE_DATETIME=?, "
			+ "CLOSE_DATETIME=?, "
			+ "DISPUTE_CASE_STATUS=? "
			+ "WHERE DISPUTE_CASE_NO=?";

	@Override
	public void insert(DisputeCaseVO disputeCaseVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, disputeCaseVO.getMission_No());
			pstmt.setString(2, disputeCaseVO.getDispute_Mem_No());
			pstmt.setString(3, disputeCaseVO.getEmp_No());
			pstmt.setTimestamp(4, disputeCaseVO.getIssue_Datetime());
			pstmt.setTimestamp(5, disputeCaseVO.getClose_Datetime());
			pstmt.setInt(6, disputeCaseVO.getDispute_Case_Status());
			
			pstmt.executeUpdate();
			System.out.println("新增成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
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
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(DELETE_STMT);
			
			pstmt.setString(1, dispute_Case_No);
			pstmt.executeUpdate();
			
			System.out.println("刪除成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
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
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
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
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
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
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
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
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
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
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
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
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
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
	
	
	
	public static void main(String[] args) {
		DisputeCaseDAO_interface dao = new DisputeCaseDAO_JDBC();
		DisputeCaseVO insertDisputeCase = new DisputeCaseVO();
		DisputeCaseVO updateDisputeCase = new DisputeCaseVO();
		DisputeCaseVO getOneDisputeCase = new DisputeCaseVO();
		List<DisputeCaseVO> getAllDisputeCase = new ArrayList<>();
		
		java.util.Date date = new java.util.Date();
		Timestamp timestamp = new Timestamp(date.getTime());
		
		insertDisputeCase.setMission_No("MISSION000000022");
		insertDisputeCase.setDispute_Mem_No("M000011");
		insertDisputeCase.setEmp_No("E000009");
		insertDisputeCase.setIssue_Datetime(timestamp);
		insertDisputeCase.setClose_Datetime(Timestamp.valueOf("2017-11-30 11:11:11.000000001"));
		insertDisputeCase.setDispute_Case_Status(1);
		dao.insert(insertDisputeCase);
		
//		updateDisputeCase.setDispute_Case_No("DIS000005");
//		updateDisputeCase.setMission_No("MISSION000000028");
//		updateDisputeCase.setDispute_Mem_No("M000008");
//		updateDisputeCase.setIssue_Datetime(timestamp);
//		updateDisputeCase.setClose_Datetime(Timestamp.valueOf("2017-11-30 11:11:30.000000001"));
//		updateDisputeCase.setDispute_Case_Status(2);
//		dao.update(updateDisputeCase);
//		
//		dao.delete("DIS000003");
//		
//		getOneDisputeCase = dao.findByprimaryKey("DIS000002");
//		System.out.println(getOneDisputeCase.getDispute_Case_Status());
//		
//		getAllDisputeCase = dao.getAll();
//		for (DisputeCaseVO disputeCaseVO : getAllDisputeCase) {
//			System.out.println(disputeCaseVO.getDispute_Case_No());
//		}
		
	}

}
