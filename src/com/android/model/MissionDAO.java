package com.android.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
 

public class MissionDAO implements MissionDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO MISSION(MISSION_NO, MISSION_NAME , MISSION_CATEGORY ,  MISSION_DES , ISSUER_MEM_NO ,  MISSION_RELEASE_TIME , MISSION_DUE_TIME , MISSION_STATE , MISSION_PATTERN ,MISSION_PAY ,MISSION_GPS_LAT ,MISSION_GPS_LNG) VALUES('MISSION'||LPAD(to_char(MISSION_SEQ.NEXTVAL),9,'0'),?,?,?,?,sysdate,sysdate+5,?,?,?,?,?)";
			//"INERT INTO mission (mission_No,  mission_Category, mission_Name, mission_Des, issuer_Mem_No, takecase_Mem_No, mission_Release_Time, mission_Due_Time, mission_Start_Time, mission_End_Time, mission_State, ,mission_Pattern, mission_Pay, mission_Gps_Lat, mission_Gps_Lng) VALUES (to_char(sysdate,'yyyymmdd')||'MIS'||LPAD(to_char(MISSION_SEQ.NEXTVAL),9,'0'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT mission_No, mission_Name, mission_Category, mission_Des, issuer_Mem_No, takecase_Mem_No, mission_Release_Time, mission_Due_Time, mission_Start_Time, mission_End_Time, mission_State, mission_Pattern, mission_Pay, mission_Gps_Lat, mission_Gps_Lng FROM mission ORDER BY mission_No";
	private static final String GET_ONE_STMT = "SELECT mission_No, mission_Name, mission_Category, mission_Des, issuer_Mem_No, takecase_Mem_No, mission_Release_Time, mission_Due_Time, mission_Start_Time, mission_End_Time, mission_State, mission_Pattern, mission_Pay, mission_Gps_Lat, mission_Gps_Lng FROM mission WHERE mission_No = ?";		
	private static final String GET_STMT_BY_TAKECASE_MEM = "SELECT mission_No, mission_Name, mission_Category, mission_Des, issuer_Mem_No, takecase_Mem_No, mission_Release_Time, mission_Due_Time, mission_Start_Time, mission_End_Time, mission_State, mission_Pattern, mission_Pay, mission_Gps_Lat, mission_Gps_Lng FROM mission where takecase_Mem_No = ?"; 
	private static final String GET_STMT_BY_ISSUER_MEM = "SELECT mission_No, mission_Name, mission_Category, mission_Des, issuer_Mem_No, takecase_Mem_No, mission_Release_Time, mission_Due_Time, mission_Start_Time, mission_End_Time, mission_State, mission_Pattern, mission_Pay, mission_Gps_Lat, mission_Gps_Lng FROM mission where issuer_Mem_No = ? ";
	private static final String DELETE = "DELETE FROM mission WHERE mission_No = ?";
	private static final String DELETE_ACCUSE_CASE = "DELETE FROM ACCUSE_CASE WHERE MISSION_NO = ?";
	private static final String UPDATE = "UPDATE mission SET mission_Name = ?, mission_Category = ?, mission_Des = ?, issuer_Mem_No = ?, takecase_Mem_No = ?, mission_Release_Time = ?, mission_Due_Time = ?, mission_Start_Time = ?, mission_End_Time = ?, mission_State = ?, mission_Pattern = ?, mission_Pay=?, mission_Gps_Lat=?, mission_Gps_Lng=?  where mission_No=?";
	private static final String INSERT_STMT_CASE_CANDIDATE = "INSERT INTO CASE_CANDIDATE(CANDIDATE_MEM_NO ,MISSION_NO) VALUES( ?, ? )";
	private static final String GET_ALL_MISSION_NO_BY_CASE_CANDIDATE_NO = "SELECT MISSION_NO FROM CASE_CANDIDATE WHERE CANDIDATE_MEM_NO=?";
	private static final String GET_MISSION_BY_KEYWORD = "SELECT mission_No, mission_Name, mission_Category, mission_Des, issuer_Mem_No, takecase_Mem_No, mission_Release_Time, mission_Due_Time, mission_Start_Time, mission_End_Time, mission_State, mission_Pattern, mission_Pay, mission_Gps_Lat, mission_Gps_Lng FROM mission WHERE ";
	private static final String GET_STMT_BY_TAKECASE_MEM_CLOSED = "SELECT mission_No, mission_Name, mission_Category, mission_Des, issuer_Mem_No, takecase_Mem_No, mission_Release_Time, mission_Due_Time, mission_Start_Time, mission_End_Time, mission_State, mission_Pattern, mission_Pay, mission_Gps_Lat, mission_Gps_Lng FROM mission where takecase_Mem_No = ? AND mission_State >=5 AND mission_State != 7 AND mission_State!=72 AND mission_State !=8 ";
	private static final String UPDATE_STMT_TAKECASE_MEM = "UPDATE MISSION SET TAKECASE_MEM_NO = ?, MISSION_START_TIME = ?, MISSION_END_TIME = ? , MISSION_STATE = 3 WHERE MISSION_NO = ?";
	private static final String UPDATE_MISSION_STATE_BY_MISSION_NO = "UPDATE MISSION SET MISSION_STATE = ? WHERE MISSION_NO = ?";
	private static final String GET_SEARCH_MISSION = "SELECT mission_No, mission_Name, mission_Category, mission_Des, issuer_Mem_No, takecase_Mem_No, mission_Release_Time, mission_Due_Time, mission_Start_Time, mission_End_Time, mission_State, mission_Pattern, mission_Pay, mission_Gps_Lat, mission_Gps_Lng FROM mission where mission_state != 5 and mission_state != 6 and mission_state != 9 ORDER BY mission_Pay desc";
	private static final String GET_STMT_BY_TAKECASE_MEM_UNFINISHED = "SELECT mission_No, mission_Name, mission_Category, mission_Des, issuer_Mem_No, takecase_Mem_No, mission_Release_Time, mission_Due_Time, mission_Start_Time, mission_End_Time, mission_State, mission_Pattern, mission_Pay, mission_Gps_Lat, mission_Gps_Lng FROM mission where takecase_Mem_No = ? AND (mission_state < 5 OR mission_state = 8)";
	private static final String UPDATE_MISSION = "UPDATE mission SET mission_Des = ?, mission_Pattern = ?, mission_Pay=?, mission_Gps_Lat=?, mission_Gps_Lng=?  where mission_No=?";
	
	@Override
	public void insert(MissionVO missionVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

//			pstmt.setString(1, missionVO.getMission_Category());
//			pstmt.setString(2, missionVO.getMission_Name());
//			pstmt.setString(3, missionVO.getMission_Des());
//			pstmt.setString(4, missionVO.getIssuer_Mem_No());
//			pstmt.setString(5, missionVO.getTakecase_Mem_No());
//			pstmt.setDate(6, missionVO.getMission_Release_Time());
//			pstmt.setDate(7, missionVO.getMission_Due_Time());
//			pstmt.setDate(8, missionVO.getMission_Start_Time());
//			pstmt.setDate(9, missionVO.getMission_End_Time());
//			pstmt.setInt(10, missionVO.getMission_State());
//			pstmt.setInt(11, missionVO.getMission_Pattern());
//			pstmt.setDouble(12, missionVO.getMission_Pay());
//			pstmt.setString(13, missionVO.getMission_Gps_Lat());
//			pstmt.setString(14, missionVO.getMission_Gps_Lng());
			
			pstmt.setString(1, missionVO.getMission_Name());
			pstmt.setString(2, missionVO.getMission_Category());
			pstmt.setString(3, missionVO.getMission_Des());
			pstmt.setString(4, missionVO.getIssuer_Mem_No());
//			pstmt.setTimestamp(5, missionVO.getMission_Release_Time());
//			pstmt.setTimestamp(6, missionVO.getMission_Due_Time());
			pstmt.setInt(5, missionVO.getMission_State());
			pstmt.setInt(6, missionVO.getMission_Pattern());
			pstmt.setDouble(7, missionVO.getMission_Pay());
			pstmt.setDouble(8, missionVO.getMission_Gps_Lat());
			pstmt.setDouble(9, missionVO.getMission_Gps_Lng());

//pstmt.setTimestamp(5, missionVO.getMission_Release_Time());
//pstmt.setTimestamp(6, missionVO.getMission_Due_Time());
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
	public void update(MissionVO missionVO){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, missionVO.getMission_Name());
			pstmt.setString(2, missionVO.getMission_Category());
			pstmt.setString(3, missionVO.getMission_Des());
			pstmt.setString(4, missionVO.getIssuer_Mem_No());
			pstmt.setString(5, missionVO.getTakecase_Mem_No());
			pstmt.setTimestamp(6, missionVO.getMission_Release_Time());
			pstmt.setTimestamp(7, missionVO.getMission_Due_Time());
			pstmt.setTimestamp(8, missionVO.getMission_Start_Time());
			pstmt.setTimestamp(9, missionVO.getMission_End_Time());
			pstmt.setInt(10, missionVO.getMission_State());
			pstmt.setInt(11, missionVO.getMission_Pattern());
			pstmt.setDouble(12, missionVO.getMission_Pay());
			pstmt.setDouble(13, missionVO.getMission_Gps_Lat());
			pstmt.setDouble(14, missionVO.getMission_Gps_Lng());
			pstmt.setString(15, missionVO.getMission_No());
			
//			missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//			missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//			missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//			missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
			
			pstmt.executeUpdate();
			
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
	}

	
	@Override
	public void delete(String mission_No) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, mission_No);

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
	public List<MissionVO> getAll() {
		
		List<MissionVO> list = new ArrayList<MissionVO>();
		MissionVO missionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				missionVO = new MissionVO();
				missionVO.setMission_No(rs.getString("mission_No"));
				missionVO.setMission_Name(rs.getString("mission_Name"));
				missionVO.setMission_Category(rs.getString("mission_Category"));
				missionVO.setMission_Des(rs.getString("mission_Des"));
				missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
				missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				missionVO.setMission_State(rs.getInt("mission_State"));
				missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
				missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
				missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
				missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
				list.add(missionVO);
				
				
//				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				
				
			}
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		
		return list;
	}
	
	public List<MissionVO> getSearchMission() {
		
		List<MissionVO> list = new ArrayList<MissionVO>();
		MissionVO missionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_SEARCH_MISSION);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				missionVO = new MissionVO();
				missionVO.setMission_No(rs.getString("mission_No"));
				missionVO.setMission_Name(rs.getString("mission_Name"));
				missionVO.setMission_Category(rs.getString("mission_Category"));
				missionVO.setMission_Des(rs.getString("mission_Des"));
				missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
				missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				missionVO.setMission_State(rs.getInt("mission_State"));
				missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
				missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
				missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
				missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
				list.add(missionVO);
				
//				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				
			}
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		
		return list;
	}
	
	@Override
	public List<MissionVO> getByIssuerMem(String issuer_Mem_No) {
		
		List<MissionVO> list = new ArrayList<MissionVO>();
		MissionVO missionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_STMT_BY_ISSUER_MEM);
			pstmt.setString(1, issuer_Mem_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				missionVO = new MissionVO();
				missionVO.setMission_No(rs.getString("mission_No"));
				missionVO.setMission_Name(rs.getString("mission_Name"));
				missionVO.setMission_Category(rs.getString("mission_Category"));
				missionVO.setMission_Des(rs.getString("mission_Des"));
				missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
				missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
//				missionVO.setMission_Release_Time(rs.getDate("mission_Release_Time"));
//				missionVO.setMission_Due_Time(rs.getDate("mission_Due_Time"));
//				missionVO.setMission_Start_Time(rs.getDate("mission_Start_Time"));
//				missionVO.setMission_End_Time(rs.getDate("mission_End_Time"));
				missionVO.setMission_State(rs.getInt("mission_State"));
				missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
				missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
				missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
				missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
				list.add(missionVO);
				
				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				
			}
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		
		return list;
	}
	
	@Override
	public List<MissionVO> getByTakecaseMem(String takecase_Mem_No) {
		
		List<MissionVO> list = new ArrayList<MissionVO>();
		MissionVO missionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_STMT_BY_TAKECASE_MEM);
			pstmt.setString(1, takecase_Mem_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				missionVO = new MissionVO();
				missionVO.setMission_No(rs.getString("mission_No"));
				missionVO.setMission_Name(rs.getString("mission_Name"));
				missionVO.setMission_Category(rs.getString("mission_Category"));
				missionVO.setMission_Des(rs.getString("mission_Des"));
				missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
				missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				missionVO.setMission_State(rs.getInt("mission_State"));
				missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
				missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
				missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
				missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
				list.add(missionVO);
				
//				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				
			}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		
		return list;
	}

public List<MissionVO> getByTakecaseMemUnfinished(String takecase_Mem_No) {
		
		List<MissionVO> list = new ArrayList<MissionVO>();
		MissionVO missionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_STMT_BY_TAKECASE_MEM_UNFINISHED);
			pstmt.setString(1, takecase_Mem_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				missionVO = new MissionVO();
				missionVO.setMission_No(rs.getString("mission_No"));
				missionVO.setMission_Name(rs.getString("mission_Name"));
				missionVO.setMission_Category(rs.getString("mission_Category"));
				missionVO.setMission_Des(rs.getString("mission_Des"));
				missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
				missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				missionVO.setMission_State(rs.getInt("mission_State"));
				missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
				missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
				missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
				missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
				list.add(missionVO);
				
//				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				
			}
			
	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		
		return list;
	}
	
public List<MissionVO> getByIssuerMemClosed(String issuer_Mem_No) {
		
		List<MissionVO> list = new ArrayList<MissionVO>();
		MissionVO missionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_STMT_BY_ISSUER_MEM+" AND (mission_State =5 OR mission_State = 6 OR Mission_State =9)");
			pstmt.setString(1, issuer_Mem_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				missionVO = new MissionVO();
				missionVO.setMission_No(rs.getString("mission_No"));
				missionVO.setMission_Name(rs.getString("mission_Name"));
				missionVO.setMission_Category(rs.getString("mission_Category"));
				missionVO.setMission_Des(rs.getString("mission_Des"));
				missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
				missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				missionVO.setMission_State(rs.getInt("mission_State"));
				missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
				missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
				missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
				missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
				list.add(missionVO);
				
//				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				
			}
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		
		return list;
	}

public List<MissionVO> getByIssuerMemProcess(String issuer_Mem_No) {
	
	List<MissionVO> list = new ArrayList<MissionVO>();
	MissionVO missionVO = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		con = ds.getConnection();
		pstmt = con.prepareStatement(GET_STMT_BY_ISSUER_MEM+" AND (mission_State =3 OR mission_State =4 OR mission_State =8)");
		pstmt.setString(1, issuer_Mem_No);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			missionVO = new MissionVO();
			missionVO.setMission_No(rs.getString("mission_No"));
			missionVO.setMission_Name(rs.getString("mission_Name"));
			missionVO.setMission_Category(rs.getString("mission_Category"));
			missionVO.setMission_Des(rs.getString("mission_Des"));
			missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
			missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
			missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
			missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
			missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
			missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
			missionVO.setMission_State(rs.getInt("mission_State"));
			missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
			missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
			missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
			missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
			list.add(missionVO);
			
//			missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//			missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//			missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//			missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
			
		}
		
	
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
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
	
	return list;
}

public List<MissionVO> getByIssuerMemResponse(String issuer_Mem_No, String candidate_Mem_No) {
	
	List<MissionVO> list = new ArrayList<MissionVO>();
	MissionVO missionVO = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		con = ds.getConnection();
		
		pstmt = con.prepareStatement(GET_ALL_MISSION_NO_BY_CASE_CANDIDATE_NO);
		pstmt.setString(1, candidate_Mem_No);
		rs = pstmt.executeQuery();
		System.out.println("candidate"+ candidate_Mem_No);
		System.out.println("issuer_Mem_No"+ issuer_Mem_No);
		StringBuffer sb = new StringBuffer();
		while(rs.next()){
			sb.append(" AND mission_No != "+"'"+rs.getString("mission_No")+"'");
		}
		System.out.println("sb"+sb);
		
		pstmt = con.prepareStatement(GET_STMT_BY_ISSUER_MEM+" AND mission_State <= 2"+sb);
		pstmt.setString(1, issuer_Mem_No);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			missionVO = new MissionVO();
			missionVO.setMission_No(rs.getString("mission_No"));
			missionVO.setMission_Name(rs.getString("mission_Name"));
			missionVO.setMission_Category(rs.getString("mission_Category"));
			missionVO.setMission_Des(rs.getString("mission_Des"));
			missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
			missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
			missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
			missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
			missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
			missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
			missionVO.setMission_State(rs.getInt("mission_State"));
			missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
			missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
			missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
			missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
			list.add(missionVO);
			
//			missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//			missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//			missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//			missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
			
		}
		
		
		
	
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
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
	
	return list;
}

public List<MissionVO> getByIssuerMemResponse2(String issuer_Mem_No) {
	
	List<MissionVO> list = new ArrayList<MissionVO>();
	MissionVO missionVO = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		con = ds.getConnection();
		
		
		System.out.println("issuer_Mem_NoDAO"+issuer_Mem_No);
		pstmt = con.prepareStatement(GET_STMT_BY_ISSUER_MEM+" AND (mission_State <= 2 OR mission_State = 7 OR mission_State = 72)");
		pstmt.setString(1, issuer_Mem_No);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			missionVO = new MissionVO();
			missionVO.setMission_No(rs.getString("mission_No"));
			missionVO.setMission_Name(rs.getString("mission_Name"));
			missionVO.setMission_Category(rs.getString("mission_Category"));
			missionVO.setMission_Des(rs.getString("mission_Des"));
			missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
			missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
			missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
			missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
			missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
			missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
			missionVO.setMission_State(rs.getInt("mission_State"));
			missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
			missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
			missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
			missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
			list.add(missionVO);
			
//			missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//			missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//			missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//			missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
			
		}
		
		
		

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
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
	
	return list;
}

public List<MissionVO> getByTakecaseMemClosed(String takecase_Mem_No) {
		
		List<MissionVO> list = new ArrayList<MissionVO>();
		MissionVO missionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_STMT_BY_TAKECASE_MEM_CLOSED);
			pstmt.setString(1, takecase_Mem_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				missionVO = new MissionVO();
				missionVO.setMission_No(rs.getString("mission_No"));
				missionVO.setMission_Name(rs.getString("mission_Name"));
				missionVO.setMission_Category(rs.getString("mission_Category"));
				missionVO.setMission_Des(rs.getString("mission_Des"));
				missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
				missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				missionVO.setMission_State(rs.getInt("mission_State"));
				missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
				missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
				missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
				missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
				
//				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				
				list.add(missionVO);
				
				
			}
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		
		return list;
	}

	@Override
	public MissionVO findByPrimaryKey(String mission_No) {
		
		MissionVO missionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);
				pstmt.setString(1, mission_No);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					missionVO = new MissionVO();
					missionVO.setMission_No(rs.getString("mission_No"));
					missionVO.setMission_Name(rs.getString("mission_Name"));
					missionVO.setMission_Category(rs.getString("mission_Category"));
					missionVO.setMission_Des(rs.getString("mission_Des"));
					missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
					missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
					missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
					missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
					missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
					missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
					missionVO.setMission_State(rs.getInt("mission_State"));
					missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
					missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
					missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
					missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
					
//					missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//					missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//					missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//					missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
					
				}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return missionVO;
	}


	
	public void insert_case_candidate(String case_Candidate_No, String mission_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT_CASE_CANDIDATE);


			pstmt.setString(1, case_Candidate_No);
			pstmt.setString(2, mission_No);
			

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
	public List<MissionVO> getMissionByKeyword(String keyword , String keyvalue) {
		
		List<MissionVO> list = new ArrayList<MissionVO>();
		MissionVO missionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = GET_MISSION_BY_KEYWORD + keyword + " = " + keyvalue + " ORDER BY mission_No" ;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				missionVO = new MissionVO();
				missionVO.setMission_No(rs.getString("mission_No"));
				missionVO.setMission_Name(rs.getString("mission_Name"));
				missionVO.setMission_Category(rs.getString("mission_Category"));
				missionVO.setMission_Des(rs.getString("mission_Des"));
				missionVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
				missionVO.setTakecase_Mem_No(rs.getString("takecase_Mem_No"));
				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				missionVO.setMission_State(rs.getInt("mission_State"));
				missionVO.setMission_Pattern(rs.getInt("mission_Pattern"));
				missionVO.setMission_Pay(rs.getDouble("mission_Pay"));
				missionVO.setMission_Gps_Lat(rs.getDouble("mission_Gps_Lat"));
				missionVO.setMission_Gps_Lng(rs.getDouble("mission_Gps_Lng"));
				
//				missionVO.setMission_Release_Time(rs.getTimestamp("mission_Release_Time"));
//				missionVO.setMission_Due_Time(rs.getTimestamp("mission_Due_Time"));
//				missionVO.setMission_Start_Time(rs.getTimestamp("mission_Start_Time"));
//				missionVO.setMission_End_Time(rs.getTimestamp("mission_End_Time"));
				
				list.add(missionVO);		
			}		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		return list;
	}
	
	public void addTakeCaseMem(String takecase_NO, String mission_No, Timestamp mission_Start_Time, Timestamp mission_End_Time){
		
		Connection con = null;
		PreparedStatement pstmt = null;
	
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT_TAKECASE_MEM);
			
			pstmt.setString(1, takecase_NO);
			pstmt.setTimestamp(2, mission_Start_Time);
			pstmt.setTimestamp(3, mission_End_Time);
			pstmt.setString(4, mission_No);
			pstmt.executeUpdate();
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
public void deleteAccuse_Case(String mission_No) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_ACCUSE_CASE);

			pstmt.setString(1, mission_No);

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



	public void updateMissionState(Integer mission_State, String mission_No){
		
		Connection con = null;
		PreparedStatement pstmt = null;
	
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_MISSION_STATE_BY_MISSION_NO);
			
			pstmt.setInt(1, mission_State);
			pstmt.setString(2, mission_No);
			
			pstmt.executeUpdate();
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
public void updateMission(MissionVO missionVO){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_MISSION);
			
		
			pstmt.setString(1, missionVO.getMission_Des());
			pstmt.setInt(2, missionVO.getMission_Pattern());
			pstmt.setDouble(3, missionVO.getMission_Pay());
			pstmt.setDouble(4, missionVO.getMission_Gps_Lat());
			pstmt.setDouble(5, missionVO.getMission_Gps_Lng());
			pstmt.setString(6, missionVO.getMission_No());
			

			
			pstmt.executeUpdate();
			
			
	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
	}

}