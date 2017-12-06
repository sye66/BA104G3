package com.mem.model;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemJDBCDAO implements MemDAO_interface{

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "123456"; 
	
	private static final String REGISTER=
			"INSERT INTO mem (mem_No,mem_Pw,mem_Name,mem_Id,mem_Bday,"
					+ "mem_Tel,mem_Pho,mem_Gend,mem_Email,mem_Pic,mem_Intro,mem_State,mem_Ip,mem_Date,mem_Address,"
					+ "mem_Search , mem_Code) VALUES ('M'||LPAD(mem_No.NEXTVAL,6,'0'), ?, ?, ?,  ?, ?, ?, ?, ?, "
					+ "?, ?, ?, ?, ?, ?, ?, ?)"; /*先把mem_Pic拿掉*/
	
	private static final String LOGIN_MEM=
			"SELECT * FROM mem WHERE mem_Email=?";
	
	private static final String UPDATEPW=
			"UPDATE MEM SET mem_Pw=? WHERE mem_Email=?";
	
	private static final String WEBSOCKET=
			"SELECT * FROM mem WHERE mem_Id=?";
	
	private static final String AUTHENTICATION=
			"UPDATE mem SET mem_State =? ,mem_Id=?, mem_No=? WHERE mem_Email=?";
	
	private static final String RECHARGE=
			"UPDATE MEM SET MEM_POINT=? WHERE MEM_NO=?";
	
	private static final String UPDATEBYEMP=
			"UPDATE MEM SET MEM_STATE=? WHERE MEM_NO=?";
	
	private static final String INSERT_STMT=
			"INSERT INTO mem (mem_No,mem_Pw,mem_Name,mem_Id,mem_Bday,"
			+ "mem_Tel,mem_Pho,mem_Gend,mem_Email,mem_Pic,mem_Intro,mem_Code,"
			+ "mem_State,mem_Gps_Lat,mem_Gps_Lng,mem_Ip,mem_Date,mission_Count,mem_Address,"
			+ "mem_Search,mem_Point) VALUES ('M'||LPAD(mem_No.NEXTVAL,6,'0'), ?, ?, ?,  ?, ?, ?, ?, ?,"
			+ " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; /*先把mem_Pic拿掉*/

	private static final String GET_ALL_STMT=
			"SELECT mem_No,mem_Pw,mem_Name,mem_Id,mem_Bday,"
			+ "mem_Tel,mem_Pho,mem_Gend,mem_Email,mem_Pic,mem_Intro,mem_Code,"
			+ "mem_State,mem_Gps_Lat,mem_Gps_Lng,mem_Ip,mem_Date,mission_Count,mem_Address,"
			+ "mem_Search,mem_Point FROM"
			+ " mem order by mem_No";/*先把mem_Pic拿掉*/
	
	private static final String GET_ALL_EXCD_STMT = "SELECT * FROM MEM WHERE MEM_SEARCH=1";
	
	private static final String GET_ALL_MEM_WITHOUT_ME=
			"SELECT mem_No,mem_Pw,mem_Name,mem_Id,mem_Bday,"
			+ "mem_Tel,mem_Pho,mem_Gend,mem_Email,mem_Pic,mem_Intro,mem_Code,"
			+ "mem_State,mem_Gps_Lat,mem_Gps_Lng,mem_Ip,mem_Date,mission_Count,mem_Address,"
			+ "mem_Search,mem_Point FROM"
			+ " mem where mem_No<>?";/*先把mem_Pic拿掉*/
	
	private static final String SELECT=
			"SELECT mem_No,mem_Pw,mem_Name,mem_Id,mem_Bday,"
			+ "mem_Tel,mem_Pho,mem_Gend,mem_Email,mem_Pic,mem_Intro,mem_Code,"
			+ "mem_State,mem_Gps_Lat,mem_Gps_Lng,mem_Ip,mem_Date,mission_Count,mem_Address,"
			+ "mem_Search,mem_Point FROM"
			+ " mem WHERE mem_No=?";/*先把mem_Pic拿掉*/
	
	private static final String SELECTBYEMAIL=
			"SELECT mem_No,mem_Pw,mem_Name,mem_Id,mem_Bday,"
			+ "mem_Tel,mem_Pho,mem_Gend,mem_Email,mem_Pic,mem_Intro,mem_Code,"
			+ "mem_State,mem_Gps_Lat,mem_Gps_Lng,mem_Ip,mem_Date,mission_Count,mem_Address,"
			+ "mem_Search,mem_Point FROM"
			+ " mem WHERE mem_Email=?";/*先把mem_Pic拿掉*/
	
//	private static final String UPDATE=
//	"SELECT mem_Pw,mem_Name,mem_Id,mem,mem_Tel,mem_Pho,mem_sex,"
//	+ "mem_Email,mem_Pic,intro,skill,mem_Address,mem_Search) FROM"
//	+ "mem order by mem_No";
	
	private static final String UPDATEBYMEM=
			"UPDATE mem SET mem_Pw =?, mem_Name =?, mem_Id =?, mem_Bday =?, mem_Tel =?,"
			+ "mem_Pho =?, mem_Gend =?, mem_Email =?, mem_Pic =?, mem_Intro =?, "
			+ "mem_Address =?, mem_Search =? WHERE mem_No = ?";
	
	
	
	private static final String UPDATE=
			"UPDATE mem SET mem_Pw =?, mem_Name =?, mem_Id =?, mem_Bday =?, mem_Tel =?,"
			+ "mem_Pho =?, mem_Gend =?, mem_Email =?, mem_Pic =?, mem_Intro =?, "
			+ "mem_Code =?, mem_State =?, mem_Gps_Lat =?, mem_Gps_Lng =?,"
			+ " mem_Date =?, mem_Ip =?, mission_Count =?, mem_Address =?, mem_Search =?, mem_Point=? WHERE mem_No = ?";
	
	private static final String DELETE=
			"DELETE FROM mem WHERE mem_No = ?";
	
	
	
	
	
	@Override
	public List<MemVO> getAllForFriend(String mem_No){

		List<MemVO> list = new ArrayList<MemVO>();
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_MEM_WITHOUT_ME);
			pstmt.setString(1, mem_No);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				MemVO memVO  = new MemVO();
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
		
		
		
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	



	@Override
	public MemVO loginMem(String mem_Email) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(LOGIN_MEM);
			
			pstmt.setString(1, mem_Email);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				
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
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		return memVO;
	}
	
	
	
	

	@Override
	public MemVO Authentication(MemVO memVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(AUTHENTICATION);
			
			pstmt.setInt(1, memVO.getMem_State());
			pstmt.setString(2, memVO.getMem_Id());
			pstmt.setString(3, memVO.getMem_No());
			pstmt.setString(4, memVO.getMem_Email());
			
			pstmt.executeQuery();
			
			}catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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
		return memVO;
		}


	
	

	@Override
	public void recharge(MemVO memVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(RECHARGE);
			
			
			pstmt.setInt(1, memVO.getMem_Point());
			pstmt.setString(2, memVO.getMem_No());
			
			pstmt.executeUpdate();
			
			
			
			
	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
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
	public void updatePw(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATEPW);
			
			
			pstmt.setString(1, memVO.getMem_Pw());
			pstmt.setString(2, memVO.getMem_Email());
			
			pstmt.executeUpdate();
			
			
			
			
	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
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
			public void updateByEmp(MemVO memVO) {
		
				Connection con = null;
				PreparedStatement pstmt = null;
				
				
				try {
					Class.forName(driver);
					con = DriverManager.getConnection(url, userid, passwd);
					pstmt = con.prepareStatement(UPDATEBYEMP);
					
					
					pstmt.setInt(1, memVO.getMem_State());
					pstmt.setString(2, memVO.getMem_No());
					
					pstmt.executeUpdate();
					
					
					
					
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
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
	public void insert(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			
			
//			pstmt.setString(1, memVO.getMem_No());
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
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public void register(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(REGISTER);
			
			
			
//			pstmt.setString(1, memVO.getMem_No());
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
			pstmt.setInt(11, memVO.getMem_State());
			pstmt.setString(12, memVO.getMem_Ip());
			pstmt.setDate(13, memVO.getMem_Date());
			pstmt.setString(14, memVO.getMem_Address());
			pstmt.setInt(15, memVO.getMem_Search());
			pstmt.setInt(16, memVO.getMem_Code());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public void updateByMem(MemVO memVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATEBYMEM);
			
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
			pstmt.setString(11, memVO.getMem_Address());
			pstmt.setInt(12, memVO.getMem_Search());
			pstmt.setString(13, memVO.getMem_No());
			
			pstmt.executeUpdate();
			
			
			
			
	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
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
	public void update(MemVO memVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			pstmt.setDate(15, memVO.getMem_Date());
			pstmt.setString(16, memVO.getMem_Ip());
			pstmt.setInt(17, memVO.getMission_Count());
			pstmt.setString(18, memVO.getMem_Address());
			pstmt.setInt(19, memVO.getMem_Search());
			pstmt.setInt(20, memVO.getMem_Point());
			pstmt.setString(21, memVO.getMem_No());
			
			pstmt.executeUpdate();
			
			
			
			
	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
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
	public void delete(String mem_No) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, mem_No);
			
			pstmt.executeUpdate();
			
			
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{	
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
	public MemVO findByMemEmail(String mem_Email) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SELECT);
			
			pstmt.setString(1, mem_Email);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
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
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		return memVO;
	}


//	@Override
//	public MemVO findByMemId(String mem_Id) {
//		MemVO memVO = null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(WEBSOCKET);
//			
//			pstmt.setString(1, mem_Id);
//			
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()){
//				
//				memVO = new MemVO();
//				memVO.setMem_No(rs.getString("mem_No"));
//				memVO.setMem_Pw(rs.getString("mem_Pw"));
//				memVO.setMem_Name(rs.getString("mem_Name"));
//				memVO.setMem_Id(rs.getString("mem_Id"));
//				memVO.setMem_Bday(rs.getDate("mem_Bday"));
//				memVO.setMem_Tel(rs.getString("mem_Tel"));
//				memVO.setMem_Pho(rs.getString("mem_Pho"));
//				memVO.setMem_Gend(rs.getInt("mem_Gend"));
//				memVO.setMem_Email(rs.getString("mem_Email"));
//				memVO.setMem_Pic(rs.getBytes("mem_Pic"));
//				memVO.setMem_Intro(rs.getString("mem_Intro"));
//				memVO.setMem_Code(rs.getInt("mem_Code"));
//				memVO.setMem_State(rs.getInt("mem_State"));
//				memVO.setMem_Gps_Lat(rs.getDouble("mem_Gps_Lat"));
//				memVO.setMem_Gps_Lng(rs.getDouble("mem_Gps_Lng"));
//				memVO.setMem_Ip(rs.getString("mem_Ip"));
//				memVO.setMem_Date(rs.getDate("mem_Date"));
//				memVO.setMission_Count(rs.getInt("mission_Count"));
//				memVO.setMem_Address(rs.getString("mem_Address"));
//				memVO.setMem_Search(rs.getInt("mem_Search"));
//				memVO.setMem_Point(rs.getInt("mem_Point"));
//				
//				
//			}
//		} catch (ClassNotFoundException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}finally{	
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}				
//		return memVO;
//	}
	
	
	@Override
	public MemVO findByPrimaryKey(String mem_No) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SELECTBYEMAIL);
			
			pstmt.setString(1, mem_No);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
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
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		return memVO;
	}




	@Override
	public List<MemVO> getAll() {
		List<MemVO> list = new ArrayList<MemVO>();
		MemVO memVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()){
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
		
		
		
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	
	
	/**
	 * @author Sander
	 * 重載getAll，排除MEM_SEARCH=0 的人
	 */
	@Override
	public List<MemVO> getAll(Integer searchable) {
		List<MemVO> list = new ArrayList<MemVO>();
		MemVO memVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_EXCD_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()){
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
		
		
		
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	

	
	public static void main(String[] args) {
		
		MemJDBCDAO dao = new MemJDBCDAO();
	
//		String pic_name= "WebContent/mem/images/M000001.jpg";
//		File pic = new File("pic_name");
//		try {
//			byte[] buffer = Files.readAllBytes(pic.toPath());
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		
		//登入驗證
		
		
//		MemVO memVO = dao.loginMem("aaa@gmail.com");
//		System.out.print(memVO.getMem_No() + ",");
//		System.out.print(memVO.getMem_Pw() + ",");
//		System.out.print(memVO.getMem_Name() + ",");
//		System.out.print(memVO.getMem_Id() + ",");
//		System.out.print(memVO.getMem_Bday() + ",");
//		System.out.print(memVO.getMem_Tel() + ",");
//		System.out.print(memVO.getMem_Pho() + ",");
//		System.out.print(memVO.getMem_Gend() + ",");
//		System.out.print(memVO.getMem_Email() + ",");
//		System.out.print(memVO.getMem_Pic() + ",");
//		System.out.print(memVO.getMem_Intro() + ",");
//		System.out.print(memVO.getMem_Code() + ",");
//		System.out.print(memVO.getMem_Gps_Lat() + ",");
//		System.out.print(memVO.getMem_Gps_Lng() + ",");
//		System.out.print(memVO.getMem_Ip() + ",");
//		System.out.print(memVO.getMission_Count() + ",");
//		System.out.print(memVO.getMem_Address() + ",");
//		System.out.print(memVO.getMem_Search() + ",");
//		System.out.println(memVO.getMem_Point());
//		System.out.println("===============================================");
		
		
		
		//新增
		MemVO memVO1 = new MemVO();
		
		File pic = new File("WebContent/lib/publicfile/include/img","登入ICON.png");
		byte[] buffer = null;
		try {
			buffer = Files.readAllBytes(pic.toPath());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		memVO1.setMem_Pw("123456");
		memVO1.setMem_Name("新垣結衣");
		memVO1.setMem_Id("結衣");
		memVO1.setMem_Bday(java.sql.Date.valueOf("1988-6-11"));
		memVO1.setMem_Tel("03-7533967");
		memVO1.setMem_Pho("0988-520520");
		memVO1.setMem_Gend(2);
		memVO1.setMem_Email("uiui520@gmail.com");
		memVO1.setMem_Pic(buffer);
		memVO1.setMem_Intro("大家好 ! 我是結衣 !");
		memVO1.setMem_Code(1122334455);
		memVO1.setMem_State(2);
		memVO1.setMem_Gps_Lat(120.132522);
		memVO1.setMem_Gps_Lng(112.645821);
		memVO1.setMem_Ip("192.168.0.29");
		memVO1.setMem_Date(java.sql.Date.valueOf("2017-08-06"));
		memVO1.setMission_Count(99);
		memVO1.setMem_Address("日本沖繩縣那霸市");
		memVO1.setMem_Search(1);
		memVO1.setMem_Point(1800);
		dao.insert(memVO1);
		
		//修改
		
				File pic_update = new File("WebContent/lib/publicfile/include/img","登入ICON.png");
				byte[] buffer_update = null;
				try {
					buffer_update = Files.readAllBytes(pic_update.toPath());
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				MemVO memVO2 = new MemVO();
				

				memVO2.setMem_Pw("123456");
				memVO2.setMem_Name("許勝驊");
				memVO2.setMem_Id("遊戲王");
				memVO2.setMem_Bday(Date.valueOf("1995-03-03"));
				memVO2.setMem_Tel("03-9487943");
				memVO2.setMem_Pho("0987-987987");
				memVO2.setMem_Gend(1);
				memVO2.setMem_Email("burnerzx@gmail.com");
				memVO2.setMem_Pic(buffer_update);
				memVO2.setMem_Intro("黑魔導女孩 ~ 就決定是妳了 !");
				memVO2.setMem_Code(7533967);
				memVO2.setMem_State(2);
				memVO2.setMem_Gps_Lat(120.132523);
				memVO2.setMem_Gps_Lng(112.645822);
				memVO2.setMem_Ip("10.120.25.31");
				memVO2.setMem_Date(Date.valueOf("2017-10-10"));
				memVO2.setMission_Count(9);
				memVO2.setMem_Address("桃園市內壢區中山路128號");
				memVO2.setMem_Search(1);
				memVO2.setMem_Point(2400);
				memVO2.setMem_No("M000021");

				dao.update(memVO2);

				
				//刪除
//				dao.delete("M000004");
		
		
//		//查詢
//		MemVO memVO3 = dao.findByPrimaryKey("M000001");
//		System.out.print(memVO3.getMem_No() + ",");
//		System.out.print(memVO3.getMem_Pw() + ",");
//		System.out.print(memVO3.getMem_Name() + ",");
//		System.out.print(memVO3.getMem_Id() + ",");
//		System.out.print(memVO3.getMem_Bday() + ",");
//		System.out.print(memVO3.getMem_Tel() + ",");
//		System.out.print(memVO3.getMem_Pho() + ",");
//		System.out.print(memVO3.getMem_Gend() + ",");
//		System.out.print(memVO3.getMem_Email() + ",");
//		System.out.print(memVO3.getMem_Pic() + ",");
//		System.out.print(memVO3.getMem_Intro() + ",");
//		System.out.print(memVO3.getMem_Code() + ",");
//		System.out.print(memVO3.getMem_Gps_Lat() + ",");
//		System.out.print(memVO3.getMem_Gps_Lng() + ",");
//		System.out.print(memVO3.getMem_Ip() + ",");
//		System.out.print(memVO3.getMem_Date() + ",");
//		System.out.print(memVO3.getMission_Count() + ",");
//		System.out.print(memVO3.getMem_Address() + ",");
//		System.out.println(memVO3.getMem_Search() + ",");
//		System.out.println(memVO3.getMem_Point());
//		System.out.println("===============================================");
//		
//		
		//查詢
		List<MemVO> list = dao.getAll();
		for(MemVO aMem : list){
			System.out.print(aMem.getMem_No() + ",");
			System.out.print(aMem.getMem_Pw() + ",");
			System.out.print(aMem.getMem_Name() + ",");
			System.out.print(aMem.getMem_Id() + ",");
			System.out.print(aMem.getMem_Bday() + ",");
			System.out.print(aMem.getMem_Tel() + ",");
			System.out.print(aMem.getMem_Pho() + ",");
			System.out.print(aMem.getMem_Gend() + ",");
			System.out.print(aMem.getMem_Email() + ",");
//			System.out.print(aMem.getMem_Pic() + ",");
			System.out.print(aMem.getMem_Intro() + ",");
			System.out.print(aMem.getMem_Code() + ",");
			System.out.print(aMem.getMem_Gps_Lat() + ",");
			System.out.print(aMem.getMem_Gps_Lng() + ",");
			System.out.print(aMem.getMem_Ip() + ",");
			System.out.print(aMem.getMem_Date() + ",");
			System.out.print(aMem.getMission_Count() + ",");
			System.out.print(aMem.getMem_Address() + ",");
			System.out.println(aMem.getMem_Search() + ",");
			System.out.println(aMem.getMem_Point());
			System.out.println("===============================================");
		}
		
		
		
		//註冊
		

		MemVO memVO4 = new MemVO();
		
//		File pic_reg = new File("WebContent/mem/image","Ui.jpg");
//		byte[] buffer_reg = null;
//		try {
//			buffer_reg = Files.readAllBytes(pic_reg.toPath());
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		
		memVO4.setMem_Pw("123456");
		memVO4.setMem_Name("新垣結衣");
		memVO4.setMem_Id("結衣");
		memVO4.setMem_Bday(java.sql.Date.valueOf("1988-6-11"));
		memVO4.setMem_Tel("03-7533967");
		memVO4.setMem_Pho("0988-520520");
		memVO4.setMem_Gend(2);
		memVO4.setMem_Email("uiui520@gmail.com");
//		memVO4.setMem_Pic(buffer);
		memVO4.setMem_Intro("大家好 ! 我是結衣 !");
		memVO4.setMem_State(2);
		memVO4.setMem_Ip("192.168.0.29");
		memVO4.setMem_Date(java.sql.Date.valueOf("2017-08-06"));
		memVO4.setMem_Address("日本沖繩縣那霸市日本沖繩縣那霸市");
		memVO4.setMem_Search(1);
		memVO4.setMem_Code(123456789);
		dao.register(memVO4);

		
		
		//驗證
		
		MemVO memVO5 = new MemVO();
		
		memVO5.setMem_State(1);
		memVO5.setMem_Id("驗證用ID");
		memVO5.setMem_No("");
		memVO5.setMem_Email("aaa@gmail.com");
		
		
		
		
		
//		File pic_updateByMem = new File("WebContent/mem/image","M000001.jpg");
//		byte[] buffer_updateByMem = null;
//		try {
//			buffer_updateByMem = Files.readAllBytes(pic_update.toPath());
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		MemVO memVO6 = new MemVO();
		

		memVO6.setMem_Pw("123456");
		memVO6.setMem_Name("許勝驊");
		memVO6.setMem_Id("遊戲王");
		memVO6.setMem_Bday(Date.valueOf("1995-03-03"));
		memVO6.setMem_Tel("03-9487943");
		memVO6.setMem_Pho("0987-987987");
		memVO6.setMem_Gend(1);
		memVO6.setMem_Email("burnerzx@gmail.com");
//		memVO6.setMem_Pic(buffer_update);
		memVO6.setMem_Intro("黑魔導女孩 ~ 就決定是妳了 !");
		memVO6.setMem_Code(7533967);
		memVO6.setMem_State(2);
		memVO6.setMem_Gps_Lat(120.132523);
		memVO6.setMem_Gps_Lng(112.645822);
		memVO6.setMem_Ip("10.120.25.31");
		memVO6.setMem_Date(Date.valueOf("2017-10-10"));
		memVO6.setMission_Count(9);
		memVO6.setMem_Address("桃園市內壢區中山路128號");
		memVO6.setMem_Search(1);
		memVO6.setMem_Point(2400);
		memVO6.setMem_No("M000021");

		dao.update(memVO6);
		
		

		MemVO memVO7 = new MemVO();
		
		memVO7.setMem_Point(3500);
		memVO7.setMem_No("M000001");
		
		dao.recharge(memVO7);
		
		System.out.println(memVO7.getMem_Point());
		
		
		MemVO memVO8 = new MemVO();
		
		memVO8.setMem_State(9);
		memVO8.setMem_No("M000001");
		
		dao.updateByEmp(memVO8);
		
		System.out.println(memVO8.getMem_State());
		
		MemVO memVO9 = new MemVO();
		
		memVO9.setMem_Pw("A123456");
		memVO9.setMem_Email("aa0953711016@gmail.com");
		

	}




	@Override
	public void updateMemPoint(MemVO memVO) {
		// TODO Auto-generated method stub
		
	}


}
