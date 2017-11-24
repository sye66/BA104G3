package com.mem.model;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
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

public class MemDAO implements MemDAO_interface{

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String REGISTER=
			"INSERT INTO mem (mem_No,mem_Pw,mem_Name,mem_Id,mem_Bday,"
					+ "mem_Tel,mem_Pho,mem_Gend,mem_Email,mem_Pic,mem_Intro,mem_State,mem_Ip,mem_Date,mem_Address,"
					+ "mem_Search,mem_Code) VALUES ('M'||LPAD(mem_No.NEXTVAL,6,'0'), ?, ?, ?,  ?, ?, ?, ?, ?, "
					+ "?, ?, ?, ?, ?, ?, ?, ?)"; /*先把mem_Pic拿掉*/
	
	private static final String LOGIN_MEM=
			"SELECT * FROM mem WHERE mem_Email=?";
	
	private static final String WEBSOCKET=
			"SELECT * FROM mem WHERE mem_Id=?";
	
	private static final String Authentication=
			"UPDATE mem SET mem_State =?, mem_Id=?, mem_No=? WHERE mem_Email=?";
	
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
		
//		private static final String GET_ALL_STMT=
//				"SELECT mem_no,mem_pw,mem_name,mem_id,mem_bday,mem_tel,mem_pho,mem_gend,"
//				+ "mem_email,mem_pic,mem_intro,mem_address,mem_search FROM"
//				+ " mem order by mem_no";/*先把mem_pic拿掉*/		

	private static final String GET_ALL_STMT=
			"SELECT mem_No,mem_Pw,mem_Name,mem_Id,mem_Bday,"
			+ "mem_Tel,mem_Pho,mem_Gend,mem_Email,mem_Pic,mem_Intro,mem_Code,"
			+ "mem_State,mem_Gps_Lat,mem_Gps_Lng,mem_Ip,mem_Date,mission_Count,mem_Address,"
			+ "mem_Search,mem_Point FROM"
			+ " mem order by mem_No";/*先把mem_Pic拿掉*/
	
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
		
//		private static final String SELECT=
//				"SELECT mem_no,mem_pw,mem_name,mem_id,mem_bday,mem_tel,mem_pho,mem_gend,"
//				+ "mem_email,mem_intro,mission_count,mem_address,mem_search FROM"
//				+ " mem where mem_no=?";/*先把mem_pic拿掉*/

		
		
//		private static final String UPDATE=
//				"UPDATE mem SET mem_pic = ? WHERE mem_no = ?";
	
	private static final String UPDATEBYMEM=
			"UPDATE mem SET mem_Pw =?, mem_Name =?, mem_Id =?, mem_Bday =?, mem_Tel =?,"
			+ "mem_Pho =?, mem_Gend =?, mem_Email =?, mem_Pic =?, mem_Intro =?, "
			+ "mem_Address =?, mem_Search =? WHERE mem_No = ?";
	
	
	
	private static final String UPDATE=
			"UPDATE mem SET mem_Pw =?, mem_Name =?, mem_Id =?, mem_Bday =?, mem_Tel =?,"
			+ "mem_Pho =?, mem_Gend =?, mem_Email =?, mem_Pic =?, mem_Intro =?, "
			+ "mem_Code =?, mem_State =?, mem_Gps_Lat =?, mem_Gps_Lng =?,"
			+ "mem_Date =?, mem_Ip =?,    mission_Count =?, mem_Address =?, mem_Search =?, mem_Point=? WHERE mem_No = ?";
	
	private static final String DELETE=
			"DELETE FROM mem WHERE mem_No = ?";
		
		
	private static final String UPDATE_POINT = 
			"UPDATE mem set mem_Point = ? where mem_No=? ";


	
		@Override
		public List<MemVO> getAllForFriend(String mem_No){
			List<MemVO> list = new ArrayList<MemVO>();
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try{
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_MEM_WITHOUT_ME);
				rs = pstmt.executeQuery();
				
//				File pic = new File("WebContent/mem/image","Ui.jpg");
//				byte[] buffer = null;
//				try {
//					buffer = Files.readAllBytes(pic.toPath());
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//				
				while (rs.next()){
					MemVO memVO =  new MemVO();
					
//					String mem_no = rs.getString("mem_no").trim();
					
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
			
			
			
			}catch (SQLException e) {
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
			
			
			try{
				con = ds.getConnection();
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
			
			
			try{
				con = ds.getConnection();
				pstmt = con.prepareStatement(Authentication);
				
				pstmt.setInt(1, memVO.getMem_State());
				pstmt.setString(2, memVO.getMem_Id());
				pstmt.setString(3, memVO.getMem_No());
				pstmt.setString(4, memVO.getMem_Email());
				
				pstmt.executeQuery();
				
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
				con = ds.getConnection();
				pstmt = con.prepareStatement(RECHARGE);
				
				
				pstmt.setInt(1, memVO.getMem_Point());
				pstmt.setString(2, memVO.getMem_No());
				
				pstmt.executeUpdate();
				
				
				
				
		}catch (SQLException e) {
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
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATEBYEMP);
				
				
				pstmt.setInt(1, memVO.getMem_State());
				pstmt.setString(2, memVO.getMem_No());
				
				pstmt.executeUpdate();
				
				
				
				
		}catch (SQLException e) {
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
				
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_STMT);
				
				
				
//				pstmt.setString(1, memVO.getMem_No());
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
			ResultSet rs = null;
			
			try {
				
				con = ds.getConnection();
				
	// 1、先建立一個字串陣列,把要使用的自增主鍵參數放進, 再使用con.prepareStatement( 'SQL指令' , 字串陣列) 存到pstmt
				String[] col = {"mem_No"};
				pstmt = con.prepareStatement(REGISTER,col);
				
				
//				pstmt.setString(1, memVO.getMem_No());
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
				
	// 2、再用getGeneratedKeys(), 用rs指向直向的欄位,所以第一個在這邊是指 mem_No (再到MemServlet 的registerNew部分的 
				rs = pstmt.getGeneratedKeys();
				rs.next();
				memVO.setMem_No(rs.getString(1));
				
//				System.out.println(memVO.getMem_No());
				
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
				con = ds.getConnection();
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
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE);
				
				pstmt.setString(1, mem_No);
				
				pstmt.executeUpdate();
				
				
			}catch (SQLException e) {
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
		public MemVO findByPrimaryKey(String mem_No) {
			MemVO memVO = new MemVO();
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(SELECT);
				
				pstmt.setString(1, mem_No);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					
					//memVO = new MemVO();
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
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{	
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
			return memVO;
		}

		
		
		@Override
		public MemVO findByMemEmail(String mem_Email) {
			MemVO memVO = new MemVO();
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(SELECTBYEMAIL);
				
				pstmt.setString(1, mem_Email);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					
					//memVO = new MemVO();
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
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{	
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
			return memVO;
		}



//		@Override
//		public MemVO findByMemId(String mem_Id) {
//			MemVO memVO = new MemVO();
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			ResultSet rs = null;
//			
//			try {
//				con = ds.getConnection();
//				pstmt = con.prepareStatement(WEBSOCKET);
//				
//				pstmt.setString(1, mem_Id);
//				
//				rs = pstmt.executeQuery();
//				
//				while(rs.next()){
//					
//					//memVO = new MemVO();
//					memVO.setMem_No(rs.getString("mem_No"));
//					memVO.setMem_Pw(rs.getString("mem_Pw"));
//					memVO.setMem_Name(rs.getString("mem_Name"));
//					memVO.setMem_Id(rs.getString("mem_Id"));
//					memVO.setMem_Bday(rs.getDate("mem_Bday"));
//					memVO.setMem_Tel(rs.getString("mem_Tel"));
//					memVO.setMem_Pho(rs.getString("mem_Pho"));
//					memVO.setMem_Gend(rs.getInt("mem_Gend"));
//					memVO.setMem_Email(rs.getString("mem_Email"));
//					memVO.setMem_Pic(rs.getBytes("mem_Pic"));
//					memVO.setMem_Intro(rs.getString("mem_Intro"));
//					memVO.setMem_Code(rs.getInt("mem_Code"));
//					memVO.setMem_State(rs.getInt("mem_State"));
//					memVO.setMem_Gps_Lat(rs.getDouble("mem_Gps_Lat"));
//					memVO.setMem_Gps_Lng(rs.getDouble("mem_Gps_Lng"));
//					memVO.setMem_Ip(rs.getString("mem_Ip"));
//					memVO.setMem_Date(rs.getDate("mem_Date"));
//					memVO.setMission_Count(rs.getInt("mission_Count"));
//					memVO.setMem_Address(rs.getString("mem_Address"));
//					memVO.setMem_Search(rs.getInt("mem_Search"));
//					memVO.setMem_Point(rs.getInt("mem_Point"));
//					
//					
//				}
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}finally{	
//				if (rs != null) {
//					try {
//						rs.close();
//					} catch (SQLException se) {
//						se.printStackTrace(System.err);
//					}
//				}
//				if (pstmt != null) {
//					try {
//						pstmt.close();
//					} catch (SQLException se) {
//						se.printStackTrace(System.err);
//					}
//				}
//				if (con != null) {
//					try {
//						con.close();
//					} catch (Exception e) {
//						e.printStackTrace(System.err);
//					}
//				}
//			}				
//			return memVO;
//		}
		
		


		@Override
		public List<MemVO> getAll() {
			List<MemVO> list = new ArrayList<MemVO>();
			MemVO memVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			
			
			
			
			try{
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();
				
//				File pic = new File("WebContent/mem/image","Ui.jpg");
//				byte[] buffer = null;
//				try {
//					buffer = Files.readAllBytes(pic.toPath());
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//				
				while (rs.next()){
					memVO = new MemVO();
					
//					String mem_no = rs.getString("mem_no").trim();
					
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
			
			
			
			}catch (SQLException e) {
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
		public void updateMemPoint(MemVO memVO) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_POINT);
				
				pstmt.setInt(1, memVO.getMem_Point());
				pstmt.setString(2, memVO.getMem_No());
				
				pstmt.executeUpdate();				
				
		}catch (SQLException e) {
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



		




		
		
		

		
//		public static void main(String[] args) {
//			
//			MemJDBCDAO dao = new MemJDBCDAO();
//		
////			String pic_name= "WebContent/mem/images/M000001.jpg";
////			File pic = new File("pic_name");
////			try {
////				byte[] buffer = Files.readAllBytes(pic.toPath());
////			} catch (IOException e) {
////				e.printStackTrace();
////			}
//			
//			
//			//新增
//			MemVO memVO1 = new MemVO();
//			
//			File pic = new File("WebContent/mem/image","Ui.jpg");
//			byte[] buffer = null;
//			try {
//				buffer = Files.readAllBytes(pic.toPath());
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//			
//			memVO1.setMem_pw("123456");
//			memVO1.setMem_name("新垣結衣");
//			memVO1.setMem_id("結衣");
//			memVO1.setMem_bday(java.sql.Date.valueOf("1988-6-11"));
//			memVO1.setMem_tel("03-7533967");
//			memVO1.setMem_pho("0988-520520");
//			memVO1.setMem_gend(2);
//			memVO1.setMem_email("uiui520@gmail.com");
//			memVO1.setMem_pic(buffer);
//			memVO1.setMem_intro("大家好 ! 我是結衣 !");
//			memVO1.setMem_code(1122334455);
//			memVO1.setMem_state(2);
//			memVO1.setMem_gps_lat("lat:520520");
//			memVO1.setMem_gps_lng("lng:645820");
//			memVO1.setMem_ip("192.168.0.29");
//			memVO1.setMem_date(java.sql.Date.valueOf("2017-08-06"));
//			memVO1.setMission_count(99);
//			memVO1.setMem_address("日本沖繩縣那霸市");
//			memVO1.setMem_search(1);
//			dao.insert(memVO1);
//			
//			//修改
//			
//					File pic_update = new File("WebContent/image","M000001.jpg");
//					byte[] buffer_update = null;
//					try {
//						buffer_update = Files.readAllBytes(pic_update.toPath());
//					} catch (IOException e) {
//						// TODO Auto-generated catch block
//						e.printStackTrace();
//					}
//					
//					MemVO memVO2 = new MemVO();
//					
//					memVO2.setMem_no("M000001");
//					memVO2.setMem_pic(buffer_update);
//					dao.update(memVO2);
//					
//					
//					
//					//刪除
////					dao.delete("M000004");
//			
//			
//			//查詢
//			MemVO memVO3 = dao.findByPrimaryKey("M000001");
//			System.out.print(memVO3.getMem_no() + ",");
//			System.out.print(memVO3.getMem_pw() + ",");
//			System.out.print(memVO3.getMem_name() + ",");
//			System.out.print(memVO3.getMem_id() + ",");
//			System.out.print(memVO3.getMem_bday() + ",");
//			System.out.print(memVO3.getMem_tel() + ",");
//			System.out.print(memVO3.getMem_pho() + ",");
//			System.out.print(memVO3.getMem_gend() + ",");
//			System.out.print(memVO3.getMem_email() + ",");
////			System.out.print(memVO3.getMem_pic() + ",");
//			System.out.print(memVO3.getMem_intro() + ",");
//		System.out.print(memVO3.getMission_count() + ",");
//			System.out.print(memVO3.getMem_address() + ",");
//			System.out.println(memVO3.getMem_search() + ",");
//			System.out.println("===============================================");
//			
//			
//			//查詢
//			List<MemVO> list = dao.getAll();
//			for(MemVO aMem : list){
//				System.out.print(aMem.getMem_no() + ",");
//				System.out.print(aMem.getMem_pw() + ",");
//				System.out.print(aMem.getMem_name() + ",");
//				System.out.print(aMem.getMem_id() + ",");
//				System.out.print(aMem.getMem_bday() + ",");
//				System.out.print(aMem.getMem_tel() + ",");
//				System.out.print(aMem.getMem_pho() + ",");
//				System.out.print(aMem.getMem_gend() + ",");
//				System.out.print(aMem.getMem_email() + ",");
////				System.out.print(aMem.getMem_pic() + ",");
//				System.out.print(aMem.getMem_intro() + ",");
//				System.out.print(aMem.getMem_address() + ",");
//				System.out.println(aMem.getMem_search() + ",");
//				System.out.println("===============================================");
//			}
//			
//			
//			
//			
//		}
//
//
//
//
//
//
	}


