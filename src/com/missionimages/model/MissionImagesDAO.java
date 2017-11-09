package com.missionimages.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MissionImagesDAO implements MissionImagesDAO_interface {

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
		"INSERT INTO emp2 (image_no, mission_no,issuer_mem_no,issuer_images) VALUES (image_seq.NEXTVAL, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT image_no, mission_no,issuer_mem_no,issuer_images FROM mission_images order by image_no";
	private static final String GET_ONE_STMT = 
		"SELECT image_no, mission_no,issuer_mem_no,issuer_images FROM mission_images where image_no = ?";
	private static final String DELETE = 
		"DELETE FROM mission_images where image_no = ?";
	private static final String UPDATE = 
		"UPDATE mission_images set  mission_no=?, issuer_mem_no=?, issuer_images=? where image_no = ?";
	private static final String GET_ONEIPO_PHO = 
		"SELECT image_no, mission_no,issuer_mem_no,issuer_images FROM mission_images where mission_no = ? and issuer_mem_no=?";

	private static final String GET_MISSION_PHO = 
		"SELECT image_no, mission_no,issuer_mem_no,issuer_images FROM mission_images where mission_no = ? ";

	@Override
	public void insert(MissionImagesVO missionImagesVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			
			pstmt.setString(1, missionImagesVO.getMission_No());
			pstmt.setString(2, missionImagesVO.getIssuer_Mem_No());
			pstmt.setBytes(3, missionImagesVO.getIssuer_images());
			

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
	public void update(MissionImagesVO missionImagesVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, missionImagesVO.getMission_No());
			pstmt.setString(2, missionImagesVO.getIssuer_Mem_No());
			pstmt.setBytes(3, missionImagesVO.getIssuer_images());
			pstmt.setString(4, missionImagesVO.getImage_No());
			
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
	public void delete(String image_No) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, image_No);

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
	public MissionImagesVO findByPrimaryKey(String image_No) {

		MissionImagesVO missionImagesVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, image_No);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				missionImagesVO = new MissionImagesVO();
				missionImagesVO.setImage_No(rs.getString("image_no"));
				missionImagesVO.setMission_No(rs.getString("mission_no"));
				missionImagesVO.setIssuer_Mem_No(rs.getString("issuer_mem_no"));
				missionImagesVO.setIssuer_images(rs.getBytes("issuer_images"));
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
		return missionImagesVO;
	}

	@Override
	public List<MissionImagesVO> getAll() {
		List<MissionImagesVO> list = new ArrayList<MissionImagesVO>();
		MissionImagesVO missionImagesVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				missionImagesVO = new MissionImagesVO();
				missionImagesVO.setImage_No(rs.getString("image_no"));
				missionImagesVO.setMission_No(rs.getString("mission_no"));
				missionImagesVO.setIssuer_Mem_No(rs.getString("issuer_mem_no"));
				missionImagesVO.setIssuer_images(rs.getBytes("issuer_images"));
				list.add(missionImagesVO); // Store the row in the list
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
	public MissionImagesVO findIpopho(String mission_no ,String issuer_mem_no) {

		MissionImagesVO missionImagesVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONEIPO_PHO);

			pstmt.setString(1, mission_no);
			pstmt.setString(2, issuer_mem_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				missionImagesVO = new MissionImagesVO();
				missionImagesVO.setImage_No(rs.getString("image_no"));
				missionImagesVO.setMission_No(rs.getString("mission_no"));
				missionImagesVO.setIssuer_Mem_No(rs.getString("issuer_mem_no"));
				missionImagesVO.setIssuer_images(rs.getBytes("issuer_images"));
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
		return missionImagesVO;
	}
	
	
	
	
	@Override
	public List<MissionImagesVO> getMissionpho(String mission_no) {
		List<MissionImagesVO> list = new ArrayList<MissionImagesVO>();
		MissionImagesVO missionImagesVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MISSION_PHO);

			pstmt.setString(1, mission_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				missionImagesVO = new MissionImagesVO();
				missionImagesVO.setImage_No(rs.getString("image_no"));
				missionImagesVO.setMission_No(rs.getString("mission_no"));
				missionImagesVO.setIssuer_Mem_No(rs.getString("issuer_mem_no"));
				missionImagesVO.setIssuer_images(rs.getBytes("issuer_images"));
				list.add(missionImagesVO); // Store the row in the list
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
}