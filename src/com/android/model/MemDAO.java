package com.android.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemDAO implements MemDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	private static final String INSERT_STMT= "INSERT INTO MEM(MEM_NO,MEM_PW,MEM_NAME,MEM_ID,MEM_BDAY,MEM_TEL,MEM_PHO,MEM_GEND,MEM_EMAIL,MEM_PIC,MEM_INTRO,MEM_CODE,MEM_STATE,MEM_GPS_LAT,MEM_GPS_LNG,MEM_IP,MEM_DATE,MISSION_COUNT,MEM_ADDRESS,MEM_SEARCH,MEM_POINT) VALUES('M'||LPAD(MEM_NO.NEXTVAL,6,'0'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	private static final String GET_ALL_STMT = "SELECT MEM_NO,MEM_PW,MEM_NAME,MEM_ID,MEM_BDAY,MEM_TEL,MEM_PHO,MEM_GEND,MEM_EMAIL,MEM_PIC,MEM_INTRO,MEM_CODE,MEM_STATE,MEM_GPS_LAT,MEM_GPS_LNG,MEM_IP,MEM_DATE,MISSION_COUNT,MEM_ADDRESS,MEM_SEARCH,MEM_POINT FROM MEM ORDER BY MEM_NO";
	private static final String GET_ALL_STMT_NO_SELF = "SELECT MEM_NO,MEM_PW,MEM_NAME,MEM_ID,MEM_BDAY,MEM_TEL,MEM_PHO,MEM_GEND,MEM_EMAIL,MEM_PIC,MEM_INTRO,MEM_CODE,MEM_STATE,MEM_GPS_LAT,MEM_GPS_LNG,MEM_IP,MEM_DATE,MISSION_COUNT,MEM_ADDRESS,MEM_SEARCH,MEM_POINT FROM MEM WHERE MEM_NO != ? ORDER BY MEM_NO";
	private static final String GET_ONE_STMT = "SELECT MEM_NO,MEM_PW,MEM_NAME,MEM_ID,MEM_BDAY,MEM_TEL,MEM_PHO,MEM_GEND,MEM_EMAIL,MEM_PIC,MEM_INTRO,MEM_CODE,MEM_STATE,MEM_GPS_LAT,MEM_GPS_LNG,MEM_IP,MEM_DATE,MISSION_COUNT,MEM_ADDRESS,MEM_SEARCH,MEM_POINT FROM MEM WHERE MEM_NO = ?";
	private static final String GET_ONE_STMT_BY_EMAIL = "SELECT MEM_NO,MEM_PW,MEM_NAME,MEM_ID,MEM_BDAY,MEM_TEL,MEM_PHO,MEM_GEND,MEM_EMAIL,MEM_PIC,MEM_INTRO,MEM_CODE,MEM_STATE,MEM_GPS_LAT,MEM_GPS_LNG,MEM_IP,MEM_DATE,MISSION_COUNT,MEM_ADDRESS,MEM_SEARCH,MEM_POINT FROM MEM WHERE MEM_EMAIL = ?";
	private static final String DELETE = "DELETE FROM MEM WHERE MEM_NO = ?";
	private static final String UPDATE = "UPDATE MEM SET MEM_PW = ?, MEM_NAME = ?, MEM_ID = ?,MEM_BDAY = ?, MEM_TEL = ?, MEM_PHO = ?, MEM_GEND = ?, MEM_EMAIL = ?, MEM_PIC = ?, MEM_INTRO = ?, MEM_CODE = ?, MEM_STATE = ?, MEM_GPS_LAT = ?, MEM_GPS_LNG = ?, MEM_IP = ?, MEM_DATE = ?, MISSION_COUNT = ?, MEM_ADDRESS = ?, MEM_SEARCH = ?,MEM_POINT = ? WHERE MEM_NO = ?";
	private static final String GET_MEM_PIC =  "SELECT MEM_PIC FROM MEM WHERE MEM_NO = ?";
	private static final String UPDATE_POINT_AND_MISSION_COUNT = "UPDATE MEM SET MEM_POINT = ?,MISSION_COUNT = ? WHERE MEM_NO = ?";
	private static final String UPDATE_POINT = "UPDATE MEM SET MEM_POINT = ? WHERE MEM_NO = ?";
	private static final String GET_ALL_STMT_NO_SELF_SEARCH = "SELECT MEM_NO,MEM_PW,MEM_NAME,MEM_ID,MEM_BDAY,MEM_TEL,MEM_PHO,MEM_GEND,MEM_EMAIL,MEM_PIC,MEM_INTRO,MEM_CODE,MEM_STATE,MEM_GPS_LAT,MEM_GPS_LNG,MEM_IP,MEM_DATE,MISSION_COUNT,MEM_ADDRESS,MEM_SEARCH,MEM_POINT FROM MEM WHERE MEM_NO != ? AND MEM_SEARCH = 1 ORDER BY MISSION_COUNT desc";
	private static final String UPDATE_MEM = "UPDATE MEM SET MEM_PW = ?, MEM_ID = ?, MEM_TEL = ?, MEM_PHO = ?, MEM_GEND = ?, MEM_PIC = ?, MEM_INTRO = ?, MEM_GPS_LAT = ?, MEM_GPS_LNG = ?, MEM_ADDRESS = ?, MEM_SEARCH = ? WHERE MEM_NO = ?";
	private static final String UPDATE_MEM_NO_PIC = "UPDATE MEM SET MEM_PW = ?, MEM_ID = ?, MEM_TEL = ?, MEM_PHO = ?, MEM_GEND = ?, MEM_INTRO = ?, MEM_GPS_LAT = ?, MEM_GPS_LNG = ?, MEM_ADDRESS = ?, MEM_SEARCH = ? WHERE MEM_NO = ?";
	private static final String UPDATE_MEM_STATE = "UPDATE MEM SET MEM_STATE = ? WHERE MEM_NO = ?";
	
	@Override
	public void insert(MemVO memVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, memVO.getMem_Pw());
			pstmt.setString(2, memVO.getMem_Name());
			pstmt.setString(3, memVO.getMem_Id());
			pstmt.setDate(4, memVO.getMem_Bday());
			pstmt.setString(5, memVO.getMem_Tel());
			pstmt.setString(6, memVO.getMem_Pho());
			pstmt.setInt(7, memVO.getMem_Gend());
			pstmt.setString(8, memVO.getMem_Email());
			pstmt.setBytes(9, memVO.getMem_Pic());
			pstmt.setString(10, memVO.getMem_Intro());
			pstmt.setInt(11, memVO.getMem_Code());
			pstmt.setInt(12, memVO.getMem_State());
			pstmt.setDouble(13, memVO.getMem_Gps_Lat());
			pstmt.setDouble(14, memVO.getMem_Gps_Lng());
			pstmt.setString(15, memVO.getMem_Ip());
			pstmt.setDate(16, memVO.getMem_Date());
			pstmt.setInt(17, memVO.getMission_Count());
			pstmt.setString(18, memVO.getMem_Address());
			pstmt.setInt(19, memVO.getMem_Search());
			pstmt.setInt(20, memVO.getMem_Point());
			
			

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
	public void update(MemVO memVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, memVO.getMem_Pw());
			pstmt.setString(2, memVO.getMem_Name());
			pstmt.setString(3, memVO.getMem_Id());
			pstmt.setDate(4, memVO.getMem_Bday());
			pstmt.setString(5, memVO.getMem_Tel());
			pstmt.setString(6, memVO.getMem_Pho());
			pstmt.setInt(7, memVO.getMem_Gend());
			pstmt.setString(8, memVO.getMem_Email());
			pstmt.setBytes(9, memVO.getMem_Pic());
			pstmt.setString(10, memVO.getMem_Intro());
			pstmt.setInt(11, memVO.getMem_Code());
			pstmt.setInt(12, memVO.getMem_State());
			pstmt.setDouble(13, memVO.getMem_Gps_Lat());
			pstmt.setDouble(14, memVO.getMem_Gps_Lng());
			pstmt.setString(15, memVO.getMem_Ip());
			pstmt.setDate(16, memVO.getMem_Date());
			pstmt.setInt(17, memVO.getMission_Count());
			pstmt.setString(18, memVO.getMem_Address());
			pstmt.setInt(19, memVO.getMem_Search());
			pstmt.setInt(20, memVO.getMem_Point());
			pstmt.setString(21, memVO.getMem_No());
			
			

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
	public void delete(String mem_No) {
		// TODO Auto-generated method stub
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

	@Override
	public MemVO findByPrimaryKey(String mem_No) {
		// TODO Auto-generated method stub
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, mem_No);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				memVO = new MemVO();
				memVO.setMem_No(rs.getString("mem_No"));
				memVO.setMem_Pw(rs.getString("mem_Pw"));
				memVO.setMem_Name(rs.getString("mem_Name"));
				memVO.setMem_Id(rs.getString("mem_Id"));
				memVO.setMem_Bday(rs.getDate("mem_Bday"));
				memVO.setMem_Tel(rs.getString("mem_Tel"));
				memVO.setMem_Pho(rs.getString("mem_Pho"));
				memVO.setMem_Gend(rs.getInt("mem_Gend"));
				memVO.setMem_Email(rs.getString("mem_Email"));
				memVO.setMem_Pic(rs.getBytes("mem_Pic"));
				memVO.setMem_Intro(rs.getString("mem_Intro"));
				memVO.setMem_Code(rs.getInt("mem_Code"));
				memVO.setMem_State(rs.getInt("mem_State"));
				memVO.setMem_Gps_Lat(rs.getDouble("mem_Gps_Lat"));
				memVO.setMem_Gps_Lng(rs.getDouble("mem_Gps_Lng"));
				memVO.setMem_Ip(rs.getString("mem_Ip"));
				memVO.setMem_Date(rs.getDate("mem_Date"));
				memVO.setMission_Count(rs.getInt("mission_Count"));
				memVO.setMem_Address(rs.getString("mem_Address"));
				memVO.setMem_Search(rs.getInt("mem_Search"));
				memVO.setMem_Point(rs.getInt("mem_Point"));
				 
			}

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
		return memVO;
	}

	

	@Override
	public List<MemVO> getAll() {
		// TODO Auto-generated method stub
		List<MemVO> list = new ArrayList<MemVO>();
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			
			rs = pstmt.executeQuery();
			

			while (rs.next()) {
				memVO = new MemVO();

				memVO.setMem_No(rs.getString("mem_No"));
			
				memVO.setMem_Pw(rs.getString("mem_Pw"));
			
				memVO.setMem_Name(rs.getString("mem_Name"));
			
				memVO.setMem_Id(rs.getString("mem_Id"));
			
				memVO.setMem_Bday(rs.getDate("mem_Bday"));
			
				memVO.setMem_Tel(rs.getString("mem_Tel"));
				memVO.setMem_Pho(rs.getString("mem_Pho"));
				memVO.setMem_Gend(rs.getInt("mem_Gend"));
				memVO.setMem_Email(rs.getString("mem_Email"));
//				memVO.setMem_Pic(rs.getBytes("mem_Pic"));
				memVO.setMem_Intro(rs.getString("mem_Intro"));
				memVO.setMem_Code(rs.getInt("mem_Code"));
				memVO.setMem_State(rs.getInt("mem_State"));
				memVO.setMem_Gps_Lat(rs.getDouble("mem_Gps_Lat"));
				memVO.setMem_Gps_Lng(rs.getDouble("mem_Gps_Lng"));
				memVO.setMem_Ip(rs.getString("mem_Ip"));
				memVO.setMem_Date(rs.getDate("mem_Date"));
				memVO.setMission_Count(rs.getInt("mission_Count"));
				memVO.setMem_Address(rs.getString("mem_Address"));
				memVO.setMem_Search(rs.getInt("mem_Search"));
				memVO.setMem_Point(rs.getInt("mem_Point"));
				list.add(memVO);
				 
			}

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
		
		return list;
	}
	
	@Override
	public List<MemVO> getAll(String mem_No) {
		// TODO Auto-generated method stub
		List<MemVO> list = new ArrayList<MemVO>();
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			
			pstmt = con.prepareStatement(GET_ALL_STMT_NO_SELF);
			pstmt.setString(1, mem_No);
			rs = pstmt.executeQuery();


			while (rs.next()) {
				memVO = new MemVO();

				memVO.setMem_No(rs.getString("mem_No"));
			
				memVO.setMem_Pw(rs.getString("mem_Pw"));
			
				memVO.setMem_Name(rs.getString("mem_Name"));
			
				memVO.setMem_Id(rs.getString("mem_Id"));
			
				memVO.setMem_Bday(rs.getDate("mem_Bday"));
			
				memVO.setMem_Tel(rs.getString("mem_Tel"));
				memVO.setMem_Pho(rs.getString("mem_Pho"));
				memVO.setMem_Gend(rs.getInt("mem_Gend"));
				memVO.setMem_Email(rs.getString("mem_Email"));
				memVO.setMem_Pic(rs.getBytes("mem_Pic"));
				memVO.setMem_Intro(rs.getString("mem_Intro"));
				memVO.setMem_Code(rs.getInt("mem_Code"));
				memVO.setMem_State(rs.getInt("mem_State"));
				memVO.setMem_Gps_Lat(rs.getDouble("mem_Gps_Lat"));
				memVO.setMem_Gps_Lng(rs.getDouble("mem_Gps_Lng"));
				memVO.setMem_Ip(rs.getString("mem_Ip"));
				memVO.setMem_Date(rs.getDate("mem_Date"));
				memVO.setMission_Count(rs.getInt("mission_Count"));
				memVO.setMem_Address(rs.getString("mem_Address"));
				memVO.setMem_Search(rs.getInt("mem_Search"));
				memVO.setMem_Point(rs.getInt("mem_Point"));
				list.add(memVO);
				 
			}

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
		
		return list;
	}
	
	public List<MemVO> getSearch(String mem_No) {
		// TODO Auto-generated method stub
		List<MemVO> list = new ArrayList<MemVO>();
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT_NO_SELF_SEARCH);
			pstmt.setString(1, mem_No);
			rs = pstmt.executeQuery();


			while (rs.next()) {
				memVO = new MemVO();

				memVO.setMem_No(rs.getString("mem_No"));
			
				memVO.setMem_Pw(rs.getString("mem_Pw"));
			
				memVO.setMem_Name(rs.getString("mem_Name"));
			
				memVO.setMem_Id(rs.getString("mem_Id"));
			
				memVO.setMem_Bday(rs.getDate("mem_Bday"));
			
				memVO.setMem_Tel(rs.getString("mem_Tel"));
				memVO.setMem_Pho(rs.getString("mem_Pho"));
				memVO.setMem_Gend(rs.getInt("mem_Gend"));
				memVO.setMem_Email(rs.getString("mem_Email"));
				memVO.setMem_Pic(rs.getBytes("mem_Pic"));
				memVO.setMem_Intro(rs.getString("mem_Intro"));
				memVO.setMem_Code(rs.getInt("mem_Code"));
				memVO.setMem_State(rs.getInt("mem_State"));
				memVO.setMem_Gps_Lat(rs.getDouble("mem_Gps_Lat"));
				memVO.setMem_Gps_Lng(rs.getDouble("mem_Gps_Lng"));
				memVO.setMem_Ip(rs.getString("mem_Ip"));
				memVO.setMem_Date(rs.getDate("mem_Date"));
				memVO.setMission_Count(rs.getInt("mission_Count"));
				memVO.setMem_Address(rs.getString("mem_Address"));
				memVO.setMem_Search(rs.getInt("mem_Search"));
				memVO.setMem_Point(rs.getInt("mem_Point"));
				list.add(memVO);
				 
			}

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
		
		return list;
	}

	
	
	public MemVO findByEmail(String mem_Email) {
		// TODO Auto-generated method stub
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_BY_EMAIL);

			pstmt.setString(1, mem_Email);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				memVO = new MemVO();
				memVO.setMem_No(rs.getString("mem_No"));
				memVO.setMem_Pw(rs.getString("mem_Pw"));
				memVO.setMem_Name(rs.getString("mem_Name"));
				memVO.setMem_Id(rs.getString("mem_Id"));
				memVO.setMem_Bday(rs.getDate("mem_Bday"));
				memVO.setMem_Tel(rs.getString("mem_Tel"));
				memVO.setMem_Pho(rs.getString("mem_Pho"));
				memVO.setMem_Gend(rs.getInt("mem_Gend"));
				memVO.setMem_Email(rs.getString("mem_Email"));
				memVO.setMem_Pic(rs.getBytes("mem_Pic"));
				memVO.setMem_Intro(rs.getString("mem_Intro"));
				memVO.setMem_Code(rs.getInt("mem_Code"));
				memVO.setMem_State(rs.getInt("mem_State"));
				memVO.setMem_Gps_Lat(rs.getDouble("mem_Gps_Lat"));
				memVO.setMem_Gps_Lng(rs.getDouble("mem_Gps_Lng"));
				memVO.setMem_Ip(rs.getString("mem_Ip"));
				memVO.setMem_Date(rs.getDate("mem_Date"));
				memVO.setMission_Count(rs.getInt("mission_Count"));
				memVO.setMem_Address(rs.getString("mem_Address"));
				memVO.setMem_Search(rs.getInt("mem_Search"));
				memVO.setMem_Point(rs.getInt("mem_Point"));
				 
			}

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
		return memVO;
	}
	
	
	
	public byte[] getMem_Pic(String mem_No) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		byte[] mem_Pic = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MEM_PIC);
			pstmt.setString(1, mem_No);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				mem_Pic = rs.getBytes(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					// When a Statement object is closed,
					// its current ResultSet object is also closed
					pstmt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return mem_Pic;
	}
	
	public void updatePointAndMissionCount(Integer mem_Point, Integer mission_Count , String mem_No){
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_POINT_AND_MISSION_COUNT);

		
			pstmt.setInt(1, mem_Point);
			pstmt.setInt(2, mission_Count);
			pstmt.setString(3, mem_No);
			
			

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
	
	public void updatePoint(Integer mem_Point,  String mem_No){
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_POINT);

		
			pstmt.setInt(1, mem_Point);
			pstmt.setString(2, mem_No);
			
			

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
	
	public void updateMem(MemVO memVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_MEM);

			pstmt.setString(1, memVO.getMem_Pw());
			pstmt.setString(2, memVO.getMem_Id());
			pstmt.setString(3, memVO.getMem_Tel());
			pstmt.setString(4, memVO.getMem_Pho());
			pstmt.setInt(5, memVO.getMem_Gend());
			pstmt.setBytes(6, memVO.getMem_Pic());
			pstmt.setString(7, memVO.getMem_Intro());
			pstmt.setDouble(8, memVO.getMem_Gps_Lat());
			pstmt.setDouble(9, memVO.getMem_Gps_Lng());
			pstmt.setString(10, memVO.getMem_Address());
			pstmt.setInt(11, memVO.getMem_Search());
			pstmt.setString(12, memVO.getMem_No());
			
			

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
	
	public void updateMemNoPic(MemVO memVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_MEM_NO_PIC);

			pstmt.setString(1, memVO.getMem_Pw());
			pstmt.setString(2, memVO.getMem_Id());
			pstmt.setString(3, memVO.getMem_Tel());
			pstmt.setString(4, memVO.getMem_Pho());
			pstmt.setInt(5, memVO.getMem_Gend());
			pstmt.setString(6, memVO.getMem_Intro());
			pstmt.setDouble(7, memVO.getMem_Gps_Lat());
			pstmt.setDouble(8, memVO.getMem_Gps_Lng());
			pstmt.setString(9, memVO.getMem_Address());
			pstmt.setInt(10, memVO.getMem_Search());
			pstmt.setString(11, memVO.getMem_No());
			
			

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
	
	public void updateMemState(String mem_No,Integer mem_State) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_MEM_STATE);

			pstmt.setInt(1, mem_State);
			pstmt.setString(2, mem_No);
			

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
