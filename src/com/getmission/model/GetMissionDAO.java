package com.getmission.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class GetMissionDAO implements GetMissionDAO_interface {

	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = 
		"INSERT INTO mission (mission_no,mission_category,mission_name,mission_des,issuer_mem_no,takecase_mem_no,mission_release_time,mission_due_time,mission_start_time,mission_end_time,mission_state,mission_pattern,mission_pay,mission_Gps_Lat,mission_Gps_Lng) VALUES (to_char(sysdate,'yyyymmdd')||'MIS'||LPAD(to_char(MISSION_SEQ.NEXTVAL), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)";
	private static final String GET_ALL_STMT = 
		"SELECT mission_no ,mission_category , mission_name,mission_des,issuer_mem_no,takecase_mem_no,to_char(mission_release_time,'yyyy-mm-dd') mission_release_time,to_char(mission_due_time,'yyyy-mm-dd') mission_due_time,to_char(mission_start_time,'yyyy-mm-dd') mission_start_time,to_char(mission_end_time,'yyyy-mm-dd') mission_end_time,mission_state,mission_pattern,mission_pay,mission_Gps_Lat,mission_Gps_Lng FROM mission order by mission_no";
	private static final String GET_ONE_STMT = 
		"SELECT mission_no ,mission_category , mission_name,mission_des,issuer_mem_no,takecase_mem_no,to_char(mission_release_time,'yyyy-mm-dd') mission_release_time,to_char(mission_due_time,'yyyy-mm-dd') mission_due_time,to_char(mission_start_time,'yyyy-mm-dd') mission_start_time,to_char(mission_end_time,'yyyy-mm-dd') mission_end_time,mission_state,mission_pattern,mission_pay,mission_Gps_Lat,mission_Gps_Lng FROM mission where mission_no = ?";
	private static final String DELETE = 
		"DELETE FROM mission where mission_no = ?";
	private static final String UPDATE = 
		"UPDATE mission set mission_category=?, mission_name=?, mission_des=?, issuer_mem_no=?, takecase_mem_no=?, mission_release_time=?, mission_due_time=?, mission_start_time=?, mission_end_time=?, mission_state=?, mission_pattern=?, mission_pay=?,mission_Gps_Lat=?,mission_Gps_Lat=? where mission_no = ?";
	private static final String TAKE_MISSION=
		"UPDATE mission set mission_State=? where mission_no = ?";
	private static final String GET_MEM_MISSION_WITH_STATUS_STMT = 
			"SELECT * FROM MISSION WHERE (issuer_mem_no=? and mission_state=?)";
	private static final String GET_MEM_MISSION_ALL_STATUS_STMT = 
			"SELECT * FROM MISSION WHERE issuer_mem_no=?";
	
	@Override
	public void insert(GetMissionVO getMissionVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, getMissionVO.getMission_Category());
			pstmt.setString(2, getMissionVO.getMission_Name());
			pstmt.setString(3, getMissionVO.getMission_Des());
			pstmt.setString(4, getMissionVO.getIssuer_Mem_No());
			pstmt.setString(5, getMissionVO.getTakecase_Mem_No());
			pstmt.setDate(6, getMissionVO.getMission_Release_Time());
			pstmt.setDate(7, getMissionVO.getMission_Due_Time());
			pstmt.setDate(8, getMissionVO.getMission_Start_Time());
			pstmt.setDate(9, getMissionVO.getMission_End_Time());
			pstmt.setInt(10, getMissionVO.getMission_State());
			pstmt.setInt(11, getMissionVO.getMission_Pattern());
			pstmt.setDouble(12, getMissionVO.getMission_Pay());
			pstmt.setDouble(13, getMissionVO.getMission_Gps_Lat());
			pstmt.setDouble(14, getMissionVO.getMission_Gps_Lng());

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
	public void update(GetMissionVO getMissionVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, getMissionVO.getMission_Category());
			pstmt.setString(2, getMissionVO.getMission_Name());
			pstmt.setString(3, getMissionVO.getMission_Des());
			pstmt.setString(4, getMissionVO.getIssuer_Mem_No());
			pstmt.setString(5, getMissionVO.getTakecase_Mem_No());
			pstmt.setDate(6, getMissionVO.getMission_Release_Time());
			pstmt.setDate(7, getMissionVO.getMission_Due_Time());
			pstmt.setDate(8, getMissionVO.getMission_Start_Time());
			pstmt.setDate(9, getMissionVO.getMission_End_Time());
			pstmt.setInt(10, getMissionVO.getMission_State());
			pstmt.setInt(11, getMissionVO.getMission_Pattern());
			pstmt.setDouble(12, getMissionVO.getMission_Pay());
			pstmt.setDouble(13, getMissionVO.getMission_Gps_Lat());
			pstmt.setDouble(14, getMissionVO.getMission_Gps_Lng());
			pstmt.setString(15, getMissionVO.getMission_No());

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

	@Override
	public void delete(String mission_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, mission_no);

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

	@Override
	public GetMissionVO findByPrimaryKey(String mission_no) {

		GetMissionVO getMissionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, mission_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				getMissionVO = new GetMissionVO();
				getMissionVO.setMission_No(rs.getString("mission_no"));
				getMissionVO.setMission_Category(rs.getString("mission_category"));
				getMissionVO.setMission_Name(rs.getString("mission_name"));
				getMissionVO.setMission_Des(rs.getString("mission_des"));
				getMissionVO.setIssuer_Mem_No(rs.getString("issuer_mem_no"));
				getMissionVO.setTakecase_Mem_No(rs.getString("takecase_mem_no"));
				getMissionVO.setMission_Release_Time(rs.getDate("mission_release_time"));
				getMissionVO.setMission_Due_Time(rs.getDate("mission_due_time"));
				getMissionVO.setMission_Start_Time(rs.getDate("mission_start_time"));
				getMissionVO.setMission_End_Time(rs.getDate("mission_end_time"));
				getMissionVO.setMission_State(rs.getInt("mission_state"));
				getMissionVO.setMission_Pattern(rs.getInt("mission_pattern"));
				getMissionVO.setMission_Pay(rs.getDouble("mission_pay"));
				getMissionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
				getMissionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
				
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
		return getMissionVO;
	}

	@Override
	public List<GetMissionVO> getAll() {
		List<GetMissionVO> list = new ArrayList<GetMissionVO>();
		GetMissionVO getMissionVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// empVO 也稱為Domain objects
				getMissionVO = new GetMissionVO();
			System.out.println(rs.getString("mission_no"));
				getMissionVO.setMission_No(rs.getString("mission_no"));
				getMissionVO.setMission_Category(rs.getString("mission_category"));
				getMissionVO.setMission_Name(rs.getString("mission_name"));
				getMissionVO.setMission_Des(rs.getString("mission_des"));
				getMissionVO.setIssuer_Mem_No(rs.getString("issuer_mem_no"));
				getMissionVO.setTakecase_Mem_No(rs.getString("takecase_mem_no"));
				getMissionVO.setMission_Release_Time(rs.getDate("mission_release_time"));
				getMissionVO.setMission_Due_Time(rs.getDate("mission_due_time"));
				getMissionVO.setMission_Start_Time(rs.getDate("mission_start_time"));
				getMissionVO.setMission_End_Time(rs.getDate("mission_end_time"));
				getMissionVO.setMission_State(rs.getInt("mission_state"));
				getMissionVO.setMission_Pattern(rs.getInt("mission_pattern"));
				getMissionVO.setMission_Pay(rs.getDouble("mission_pay"));
				getMissionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
				getMissionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
				list.add(getMissionVO); // Store the row in the list
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
	
    /**
     * @author Sander
     * 用會員去搜尋他的所有的Mission，以狀態做區隔
     * @param 發案人會員編號
     * @param 任務狀態，可以查詢待接案或是已結案
     * @return List<getMissionVO>
     */
	
	@Override
	public List<GetMissionVO> findByMem(String issuer_Mem_No, Integer mission_Status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GetMissionVO getMissionVO = null;
		List<GetMissionVO> listMemMission = new ArrayList<>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MEM_MISSION_WITH_STATUS_STMT);
			pstmt.setString(1, issuer_Mem_No);
			pstmt.setInt(2, mission_Status);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				getMissionVO = new GetMissionVO();
				getMissionVO.setMission_No(rs.getString("mission_no"));
				getMissionVO.setMission_Category(rs.getString("mission_category"));
				getMissionVO.setMission_Name(rs.getString("mission_name"));
				getMissionVO.setMission_Des(rs.getString("mission_des"));
				getMissionVO.setIssuer_Mem_No(rs.getString("issuer_mem_no"));
				getMissionVO.setTakecase_Mem_No(rs.getString("takecase_mem_no"));
				getMissionVO.setMission_Release_Time(rs.getDate("mission_release_time"));
				getMissionVO.setMission_Due_Time(rs.getDate("mission_due_time"));
				getMissionVO.setMission_Start_Time(rs.getDate("mission_start_time"));
				getMissionVO.setMission_End_Time(rs.getDate("mission_end_time"));
				getMissionVO.setMission_State(rs.getInt("mission_state"));
				getMissionVO.setMission_Pattern(rs.getInt("mission_pattern"));
				getMissionVO.setMission_Pay(rs.getDouble("mission_pay"));
				listMemMission.add(getMissionVO); // Store the row in the list
			}
		} catch (SQLException e) {
			System.out.println("SQL issue");
			e.printStackTrace();
		} finally {
			try {
				if (pstmt!=null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
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
		
		return listMemMission;
	}
	
	/**
     * @author Sander
     * Overload findByMem，直接抓出這個會員所有的任務，不分狀態
     * @param 發案人會員編號
     * @return List<getMissionVO>
     */
	public List<GetMissionVO> findByMem(String issuer_Mem_No){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GetMissionVO getMissionVO = null;
		List<GetMissionVO> listMemMission = new ArrayList<>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MEM_MISSION_ALL_STATUS_STMT);
			pstmt.setString(1, issuer_Mem_No);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				getMissionVO = new GetMissionVO();
				getMissionVO.setMission_No(rs.getString("mission_no"));
				getMissionVO.setMission_Category(rs.getString("mission_category"));
				getMissionVO.setMission_Name(rs.getString("mission_name"));
				getMissionVO.setMission_Des(rs.getString("mission_des"));
				getMissionVO.setIssuer_Mem_No(rs.getString("issuer_mem_no"));
				getMissionVO.setTakecase_Mem_No(rs.getString("takecase_mem_no"));
				getMissionVO.setMission_Release_Time(rs.getDate("mission_release_time"));
				getMissionVO.setMission_Due_Time(rs.getDate("mission_due_time"));
				getMissionVO.setMission_Start_Time(rs.getDate("mission_start_time"));
				getMissionVO.setMission_End_Time(rs.getDate("mission_end_time"));
				getMissionVO.setMission_State(rs.getInt("mission_state"));
				getMissionVO.setMission_Pattern(rs.getInt("mission_pattern"));
				getMissionVO.setMission_Pay(rs.getDouble("mission_pay"));
				listMemMission.add(getMissionVO); // Store the row in the list
			}
		} catch (SQLException e) {
			System.out.println("SQL issue");
			e.printStackTrace();
		} finally {
			try {
				if (pstmt!=null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
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
		
		return listMemMission;
	}
	
	
	@Override
	public void takeMission(GetMissionVO getMissionVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(TAKE_MISSION);

			
			pstmt.setInt(1, getMissionVO.getMission_State());
			
			
			pstmt.setString(2, getMissionVO.getMission_No());

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