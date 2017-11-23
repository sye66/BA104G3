package com.disputecase.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.infinispan.loaders.modifications.Prepare;

import com.sun.crypto.provider.RSACipher;

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
			+ "DISPUTE_CASE_STATUS,"
			+ "DISPUTE_CONTENT,"
			+ "DISPUTE_ATTACHMENT,"
			+ "DISPUTE_REPLY)"
			+ " VALUES('DIS'||LPAD(to_char(SEQ_DIS_CASE_NO.NEXTVAL),6,'0'),?,?,?,?,?,?,?,?,?)";
	private static final String DELETE_STMT = "DELETE FROM DISPUTE_CASE WHERE DISPUTE_CASE_NO=?";
	private static final String UPDATE_STMT = "UPDATE DISPUTE_CASE SET "
			+ "MISSION_NO=?, "
			+ "DISPUTE_MEM_NO=?, "
			+ "EMP_NO=?, "
			+ "ISSUE_DATETIME=?, "
			+ "CLOSE_DATETIME=?, "
			+ "DISPUTE_CASE_STATUS=?,"
			+ "DISPUTE_CONTENT=?,"
			+ "DISPUTE_ATTACHMENT=?, "
			+ "DISPUTE_REPLY=? "
			+ "WHERE DISPUTE_CASE_NO=?";
	private static final String GET_ONE_STMT = "SELECT * FROM DISPUTE_CASE WHERE DISPUTE_CASE_NO =?";
	private static final String GET_ALL_STMT = "SELECT * FROM DISPUTE_CASE";
	private static final String GET_CASE_BY_MEM = "SELECT * FROM DISPUTE_CASE WHERE DISPUTE_MEM_NO =?";
	private static final String GET_CASE_BY_STATUS = "SELECT * FROM DISPUTE_CASE WHERE DISPUTE_CASE_STATUS =?";
	private static final String GET_CASE_BY_STATUS_EMP = "SELECT * FROM DISPUTE_CASE WHERE (DISPUTE_CASE_STATUS =? AND EMP_NO=?)";
	private static final String GET_COUNT_BY_STATUS = "SELECT * FROM DISPUTE_CASE WHERE DISPUTE_CASE_STATUS = ?";

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
			pstmt.setString(7, disputeCaseVO.getDispute_Content());
			pstmt.setBytes(8, disputeCaseVO.getDispute_Attachment());
			pstmt.setString(9, disputeCaseVO.getDispute_Reply());
			
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
			pstmt.setString(7, disputeCaseVO.getDispute_Content());
			pstmt.setBytes(8, disputeCaseVO.getDispute_Attachment());
			pstmt.setString(9, disputeCaseVO.getDispute_Reply());
			pstmt.setString(10, disputeCaseVO.getMission_No());
			
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
	
	@Override
	public List<DisputeCaseVO> findByStatus(Integer dispute_Case_Status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		DisputeCaseVO disputeCaseVO = null;
		ResultSet rs = null;
		List<DisputeCaseVO> listDisputeCaseStatus = new ArrayList<>();
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_CASE_BY_STATUS);
			
			pstmt.setInt(1, dispute_Case_Status);
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
				listDisputeCaseStatus.add(disputeCaseVO);
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
		return listDisputeCaseStatus;
	}

	@Override
	public List<DisputeCaseVO> findByStatus(Integer dispute_Case_Status, String emp_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		DisputeCaseVO disputeCaseVO = null;
		ResultSet rs = null;
		List<DisputeCaseVO> listDisputeCaseStatus = new ArrayList<>();
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_CASE_BY_STATUS_EMP);
			
			pstmt.setInt(1, dispute_Case_Status);
			pstmt.setString(2, emp_No);
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
				listDisputeCaseStatus.add(disputeCaseVO);
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
		return listDisputeCaseStatus;
	}
	
	@Override
	public List<DisputeCaseVO> findByMem(String mem_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		DisputeCaseVO disputeCaseVO = null;
		ResultSet rs = null;
		List<DisputeCaseVO> listDisputeCaseMem = new ArrayList<>();
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_CASE_BY_MEM);
			
			pstmt.setString(1, mem_No);
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
				listDisputeCaseMem.add(disputeCaseVO);
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
		return listDisputeCaseMem;
	}

	@Override
	public Integer getCountByStatus(Integer dispute_Case_Status) {
		Integer totalCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USR, PSW);
			pstmt = con.prepareStatement(GET_COUNT_BY_STATUS);
			pstmt.setInt(1, dispute_Case_Status);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				totalCount += 1;
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (con != null) {					
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return totalCount;
	}
	
	public static void main(String[] args) {
		DisputeCaseDAO_interface dao = new DisputeCaseDAO_JDBC();
//		DisputeCaseVO insertDisputeCase = new DisputeCaseVO();
//		DisputeCaseVO updateDisputeCase = new DisputeCaseVO();
//		DisputeCaseVO getOneDisputeCase = new DisputeCaseVO();
//		List<DisputeCaseVO> getAllDisputeCase = new ArrayList<>();
//		java.util.Date date = new java.util.Date();
//		Timestamp timestamp = new Timestamp(date.getTime());
//		
//		insertDisputeCase.setMission_No("MISSION000000022");
//		insertDisputeCase.setDispute_Mem_No("M000011");
//		insertDisputeCase.setEmp_No("E000009");
//		insertDisputeCase.setIssue_Datetime(timestamp);
//		insertDisputeCase.setClose_Datetime(Timestamp.valueOf("2017-11-30 11:11:11.000000001"));
//		insertDisputeCase.setDispute_Case_Status(1);
//		dao.insert(insertDisputeCase);
//		
//		updateDisputeCase.setDispute_Case_No("DIS000005");
//		updateDisputeCase.setMission_No("MISSION000000028");
//		updateDisputeCase.setDispute_Mem_No("M000008");
//		updateDisputeCase.setIssue_Datetime(timestamp);
//		updateDisputeCase.setClose_Datetime(Timestamp.valueOf("2017-11-30 11:11:30.000000001"));
//		updateDisputeCase.setDispute_Case_Status(2);
//		updateDisputeCase.setDispute_Content("1");
//		updateDisputeCase.setDispute_Attachment(null);
//		updateDisputeCase.setDispute_Reply("3");
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
//		getAllDisputeCase = dao.findByStatus(1,"E000009");
//		getAllDisputeCase = dao.findByMem("M000011");
//		for (DisputeCaseVO disputeCaseVO : getAllDisputeCase) {
//			System.out.println(disputeCaseVO.getDispute_Case_No());
//			System.out.println(disputeCaseVO.getIssue_Datetime());
//			System.out.println(disputeCaseVO.getEmp_No());
//		}
		
		Integer i = dao.getCountByStatus(1);
		System.out.println(i);
	}



}
