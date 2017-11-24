package com.android.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.android.model.MissionVO;

public class Mission_ImagesDAO implements Mission_ImagesDAO_interface{
	static String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userid = "BA104G3";
	String passwd = "123456";

	
	static {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		}
		
	}
	
	
	private static final String INSERT_STMT = "INSERT INTO MISSION_IMAGES(IMAGE_NO, MISSION_NO, ISSUER_MEM_NO, ISSUER_IMAGES) VALUES ('PIC'||LPAD(IMAGE_SEQ.NEXTVAL,6,'0'),?,?,?)";
	private static final String INSERT_NO_IMAGE = "INSERT INTO MISSION_IMAGES(IMAGE_NO, MISSION_NO, ISSUER_MEM_NO) VALUES ('PIC'||LPAD(IMAGE_SEQ.NEXTVAL,6,'0'),?, ?)";
	private static final String UPDATE = "UPDATE MISSION_IMAGES SET MISSION_NO = ?, ISSUER_MEM_NO = ? , ISSUER_IMAGES = ? WHERE IMAGE_NO =?";
	private static final String DELETE = "DELETE FROM MISSION_IMAGES WHERE IMAGE_NO = ?";
	private static final String DELETE_BY_MISSION_NO = "DELETE FROM MISSION_IMAGES WHERE MISSION_NO = ?";
	private static final String GET_ALL_STMT = "SELECT * FROM MISSION_IMAGES ORDER BY MISSION_NO";
//	private static final String GET_STMT_BY_MISSION_NO = "SELECT IMAGE_NO FROM MISSION_IMAGES where MISSION_No = ?";
	private static final String GET_STMT_BY_MISSION_NO = "SELECT ISSUER_IMAGES FROM MISSION_IMAGES WHERE MISSION_NO = ? AND ROWNUM<=1";
	
	@Override
	public void insert(Mission_ImagesVO mission_ImagesVO) {
		// TODO Auto-generated method stub
			Connection con = null;
			PreparedStatement pstmt= null;
		try {
			con = DriverManager.getConnection(url,userid,passwd);	
			pstmt = con.prepareStatement(INSERT_STMT);
			System.out.println("mmmmmmmno"+mission_ImagesVO.getMission_No());
			pstmt.setString(1, mission_ImagesVO.getMission_No());
			System.out.println("mmmmmmmmmemno"+mission_ImagesVO.getIssuer_Mem_No());
			pstmt.setString(2, mission_ImagesVO.getIssuer_Mem_No());
			pstmt.setBytes(3, mission_ImagesVO.getIssuer_Images());
			System.out.println("immmmmmage"+mission_ImagesVO.getIssuer_Images());
			pstmt.executeUpdate();

			// Handle any driver errors
		}  catch (SQLException se) {
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
	public void insertNoImage(Mission_ImagesVO mission_ImagesVO) {
		// TODO Auto-generated method stub
			Connection con = null;
			PreparedStatement pstmt= null;
		try {
			con = DriverManager.getConnection(url,userid,passwd);
			
			pstmt = con.prepareStatement(INSERT_NO_IMAGE);

			pstmt.setString(1, mission_ImagesVO.getMission_No());
			pstmt.setString(2, mission_ImagesVO.getIssuer_Mem_No());


			pstmt.executeUpdate();

			// Handle any driver errors
		}  catch (SQLException se) {
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
	public void update(String image_No) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(String image_No) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void deleteByMissionNo(String mission_No) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt= null;
	try {
		con = DriverManager.getConnection(url,userid,passwd);
		
		pstmt = con.prepareStatement(DELETE_BY_MISSION_NO);

		pstmt.setString(1, mission_No);
		
		pstmt.executeUpdate();

		// Handle any driver errors
	}  catch (SQLException se) {
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
	public Mission_ImagesVO findByPrimaryKey(String image_No) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Mission_ImagesVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> getImageNoByMissionNo(String mission_No) {
		List<String> image_NoList = new ArrayList();
		Mission_ImagesVO mission_ImagesVO = null;
		MissionVO mission = null;
		ResultSet rs = null;
		Connection con = null;
		
	
		PreparedStatement pstmt= null;
	try {
		con = DriverManager.getConnection(url,userid,passwd);		
			pstmt = con.prepareStatement(GET_STMT_BY_MISSION_NO);
			pstmt.setString(1, mission_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				mission_ImagesVO = new Mission_ImagesVO();
				mission_ImagesVO.setImage_No(rs.getString("image_No"));
//				mission_ImagesVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
//				mission_ImagesVO.setIssuer_Images(rs.getBytes("issuer_Images"));
//				mission_ImagesVO.setMission_No(mission_No);
				image_NoList.add(mission_ImagesVO.getImage_No());
				
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
		
		
		
		
		return image_NoList;
	}
	
	
	@Override
	public byte[] getIssuerImageByMissionNo(String mission_No) {
		byte[] issuer_Image = null;
		Mission_ImagesVO mission_ImagesVO = null;
		MissionVO mission = null;
		ResultSet rs = null;
		
		Connection con = null;
		PreparedStatement pstmt= null;
	try {
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(GET_STMT_BY_MISSION_NO);
			pstmt.setString(1, mission_No);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				mission_ImagesVO = new Mission_ImagesVO();
//				mission_ImagesVO.setImage_No(rs.getString("imgae_No"));
//				mission_ImagesVO.setIssuer_Mem_No(rs.getString("issuer_Mem_No"));
				mission_ImagesVO.setIssuer_Images(rs.getBytes("issuer_Images"));
//				mission_ImagesVO.setMission_No(mission_No);
				issuer_Image = mission_ImagesVO.getIssuer_Images();
				
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
		
	
		return issuer_Image;
	}


	@Override
	public void insert(String mission_No) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void insertNoImage(String mission_No, String issuer_Mem_No) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt= null;
	try {
		con = DriverManager.getConnection(url,userid,passwd);
		
		pstmt = con.prepareStatement(INSERT_NO_IMAGE);

		pstmt.setString(1, mission_No);
		pstmt.setString(2, issuer_Mem_No);


		pstmt.executeUpdate();

		// Handle any driver errors
	}  catch (SQLException se) {
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
