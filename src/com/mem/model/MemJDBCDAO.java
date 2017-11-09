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
	String userid = "BA104_G3";
	String passwd = "BA104"; 
	
	private static final String LOGIN_MEM=
			"SELECT * FROM mem WHERE mem_email=?";
	
	private static final String INSERT_STMT=
			"INSERT INTO mem (mem_no,mem_pw,mem_name,mem_id,mem_bday,"
			+ "mem_tel,mem_pho,mem_gend,mem_email,mem_pic,mem_intro,mem_code,"
			+ "mem_state,mem_gps_lat,mem_gps_lng,mem_ip,mem_date,mission_count,mem_address,"
			+ "mem_search,mem_point) VALUES ('M'||LPAD(MEM_NO.NEXTVAL,6,'0'), ?, ?, ?,  ?, ?, ?, ?, ?,"
			+ " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; /*先把mem_pic拿掉*/

	private static final String GET_ALL_STMT=
			"SELECT mem_no,mem_pw,mem_name,mem_id,mem_bday,"
			+ "mem_tel,mem_pho,mem_gend,mem_email,mem_pic,mem_intro,mem_code,"
			+ "mem_state,mem_gps_lat,mem_gps_lng,mem_ip,mem_date,mission_count,mem_address,"
			+ "mem_search,mem_point FROM"
			+ " mem order by mem_no";/*先把mem_pic拿掉*/
	
	private static final String SELECT=
			"SELECT mem_no,mem_pw,mem_name,mem_id,mem_bday,"
			+ "mem_tel,mem_pho,mem_gend,mem_email,mem_pic,mem_intro,mem_code,"
			+ "mem_state,mem_gps_lat,mem_gps_lng,mem_ip,mem_date,mission_count,mem_address,"
			+ "mem_search,mem_point FROM"
			+ " mem WHERE mem_no=?";/*先把mem_pic拿掉*/
	
//	private static final String UPDATE=
//	"SELECT mem_pw,mem_name,mem_id,mem,mem_tel,mem_pho,mem_sex,"
//	+ "mem_email,mem_pic,intro,skill,mem_address,mem_search) FROM"
//	+ "mem order by mem_no";
	
	private static final String UPDATE=
			"UPDATE mem SET mem_pw =?, mem_name =?, mem_id =?, mem_bday =?, mem_tel =?,"
			+ "mem_pho =?, mem_gend =?, mem_email =?, mem_pic =?, mem_intro =?, "
			+ "mem_code =?, mem_state =?, mem_gps_lat =?, mem_gps_lng =?,"
			+ "mem_ip =?, mission_count =?, mem_address =?, mem_search =?, mem_point=? WHERE mem_no = ?";
	
	private static final String DELETE=
			"DELETE FROM mem WHERE mem_no = ?";
	
	
	

	
	



	@Override
	public MemVO loginMem(String mem_email) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(LOGIN_MEM);
			
			pstmt.setString(1, mem_email);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				
				memVO = new MemVO();
				memVO.setMem_no(rs.getString("mem_no"));
				memVO.setMem_pw(rs.getString("mem_pw"));
				memVO.setMem_name(rs.getString("mem_name"));
				memVO.setMem_id(rs.getString("mem_id"));
				memVO.setMem_bday(rs.getDate("mem_bday"));
				memVO.setMem_tel(rs.getString("mem_tel"));
				memVO.setMem_pho(rs.getString("mem_pho"));
				memVO.setMem_gend(rs.getInt("mem_gend"));
				memVO.setMem_email(rs.getString("mem_email"));
//				memVO.setMem_pic(rs.getBytes("mem_pic"));
				memVO.setMem_intro(rs.getString("mem_intro"));
				memVO.setMission_count(rs.getInt("mission_count"));
				memVO.setMem_address(rs.getString("mem_address"));
				memVO.setMem_search(rs.getInt("mem_search"));
				memVO.setMem_point(rs.getInt("mem_point"));
				
				
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
	public void insert(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			
			
//			pstmt.setString(1, memVO.getMem_no());
			pstmt.setString(1, memVO.getMem_pw());
			pstmt.setString(2, memVO.getMem_name());
			pstmt.setString(3, memVO.getMem_id());
			pstmt.setDate(4, memVO.getMem_bday());
			pstmt.setString(5, memVO.getMem_tel());
			pstmt.setString(6, memVO.getMem_pho());
			pstmt.setInt(7, memVO.getMem_gend());
			pstmt.setString(8, memVO.getMem_email());
			pstmt.setBytes(9, memVO.getMem_pic());
			pstmt.setString(10, memVO.getMem_intro());
			pstmt.setInt(11, memVO.getMem_code());
			pstmt.setInt(12, memVO.getMem_state());
			pstmt.setDouble(13, memVO.getMem_gps_lat());
			pstmt.setDouble(14, memVO.getMem_gps_lng());
			pstmt.setString(15, memVO.getMem_ip());
			pstmt.setDate(16, memVO.getMem_date());
			pstmt.setInt(17, memVO.getMission_count());
			pstmt.setString(18, memVO.getMem_address());
			pstmt.setInt(19, memVO.getMem_search());
			pstmt.setInt(20, memVO.getMem_point());
			
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
	public void update(MemVO memVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, memVO.getMem_pw());
			pstmt.setString(2, memVO.getMem_name());
			pstmt.setString(3, memVO.getMem_id());
			pstmt.setDate(4, memVO.getMem_bday());
			pstmt.setString(5, memVO.getMem_tel());
			pstmt.setString(6, memVO.getMem_pho());
			pstmt.setInt(7, memVO.getMem_gend());
			pstmt.setString(8, memVO.getMem_email());
			pstmt.setBytes(9, memVO.getMem_pic());
			pstmt.setString(10, memVO.getMem_intro());
			pstmt.setInt(11, memVO.getMem_code());
			pstmt.setInt(12, memVO.getMem_state());
			pstmt.setDouble(13, memVO.getMem_gps_lat());
			pstmt.setDouble(14, memVO.getMem_gps_lng());
			pstmt.setString(15, memVO.getMem_ip());
			pstmt.setInt(16, memVO.getMission_count());
			pstmt.setString(17, memVO.getMem_address());
			pstmt.setInt(18, memVO.getMem_search());
			pstmt.setInt(19, memVO.getMem_point());
			pstmt.setString(20, memVO.getMem_no());
			
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
	public void delete(String mem_no) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, mem_no);
			
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
	public MemVO findByPrimaryKey(String mem_no) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SELECT);
			
			pstmt.setString(1, mem_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				memVO = new MemVO();
				memVO.setMem_no(rs.getString("mem_no"));
				memVO.setMem_pw(rs.getString("mem_pw"));
				memVO.setMem_name(rs.getString("mem_name"));
				memVO.setMem_id(rs.getString("mem_id"));
				memVO.setMem_bday(rs.getDate("mem_bday"));
				memVO.setMem_tel(rs.getString("mem_tel"));
				memVO.setMem_pho(rs.getString("mem_pho"));
				memVO.setMem_gend(rs.getInt("mem_gend"));
				memVO.setMem_email(rs.getString("mem_email"));
//				memVO.setMem_pic(rs.getBytes("mem_pic"));
				memVO.setMem_intro(rs.getString("mem_intro"));
				memVO.setMission_count(rs.getInt("mission_count"));
				memVO.setMem_address(rs.getString("mem_address"));
				memVO.setMem_search(rs.getInt("mem_search"));
				memVO.setMem_point(rs.getInt("mem_point"));
				
				
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
				memVO.setMem_no(rs.getString("mem_no"));
				memVO.setMem_pw(rs.getString("mem_pw"));
				memVO.setMem_name(rs.getString("mem_name"));
				memVO.setMem_id(rs.getString("mem_id"));
				memVO.setMem_bday(rs.getDate("mem_bday"));
				memVO.setMem_tel(rs.getString("mem_tel"));
				memVO.setMem_pho(rs.getString("mem_pho"));
				memVO.setMem_gend(rs.getInt("mem_gend"));
				memVO.setMem_email(rs.getString("mem_email"));
				memVO.setMem_pic(rs.getBytes("mem_pic"));
				memVO.setMem_intro(rs.getString("mem_intro"));
				memVO.setMem_code(rs.getInt("mem_code"));
				memVO.setMem_state(rs.getInt("mem_state"));
				memVO.setMem_gps_lat(rs.getDouble("mem_gps_lat"));
				memVO.setMem_gps_lng(rs.getDouble("mem_gps_lng"));
				memVO.setMem_ip(rs.getString("mem_ip"));
				memVO.setMem_date(rs.getDate("mem_date"));
				memVO.setMission_count(rs.getInt("mission_count"));
				memVO.setMem_address(rs.getString("mem_address"));
				memVO.setMem_search(rs.getInt("mem_search"));
				memVO.setMem_point(rs.getInt("mem_point"));
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
		
		
		MemVO memVO = dao.loginMem("aaa@gmail.com");
		System.out.print(memVO.getMem_no() + ",");
		System.out.print(memVO.getMem_pw() + ",");
		System.out.print(memVO.getMem_name() + ",");
		System.out.print(memVO.getMem_id() + ",");
		System.out.print(memVO.getMem_bday() + ",");
		System.out.print(memVO.getMem_tel() + ",");
		System.out.print(memVO.getMem_pho() + ",");
		System.out.print(memVO.getMem_gend() + ",");
		System.out.print(memVO.getMem_email() + ",");
//		System.out.print(memVO.getMem_pic() + ",");
		System.out.print(memVO.getMem_intro() + ",");
		System.out.print(memVO.getMem_code() + ",");
		System.out.print(memVO.getMem_gps_lat() + ",");
		System.out.print(memVO.getMem_gps_lng() + ",");
		System.out.print(memVO.getMem_ip() + ",");
		System.out.print(memVO.getMission_count() + ",");
		System.out.print(memVO.getMem_address() + ",");
		System.out.print(memVO.getMem_search() + ",");
		System.out.println(memVO.getMem_point());
		System.out.println("===============================================");
		
		
		
		//新增
		MemVO memVO1 = new MemVO();
		
		File pic = new File("WebContent/mem/image","Ui.jpg");
		byte[] buffer = null;
		try {
			buffer = Files.readAllBytes(pic.toPath());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		memVO1.setMem_pw("123456");
		memVO1.setMem_name("新垣結衣");
		memVO1.setMem_id("結衣");
		memVO1.setMem_bday(java.sql.Date.valueOf("1988-6-11"));
		memVO1.setMem_tel("03-7533967");
		memVO1.setMem_pho("0988-520520");
		memVO1.setMem_gend(2);
		memVO1.setMem_email("uiui520@gmail.com");
		memVO1.setMem_pic(buffer);
		memVO1.setMem_intro("大家好 ! 我是結衣 !");
		memVO1.setMem_code(1122334455);
		memVO1.setMem_state(2);
		memVO1.setMem_gps_lat(120.132522);
		memVO1.setMem_gps_lng(112.645821);
		memVO1.setMem_ip("192.168.0.29");
		memVO1.setMem_date(java.sql.Date.valueOf("2017-08-06"));
		memVO1.setMission_count(99);
		memVO1.setMem_address("日本沖繩縣那霸市");
		memVO1.setMem_search(1);
		memVO1.setMem_point(1800);
		dao.insert(memVO1);
		
		//修改
		
				File pic_update = new File("WebContent/mem/image","M000001.jpg");
				byte[] buffer_update = null;
				try {
					buffer_update = Files.readAllBytes(pic_update.toPath());
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				MemVO memVO2 = new MemVO();
				
				memVO2.setMem_no("M000021");
				memVO2.setMem_pw("123456");
				memVO2.setMem_name("許勝驊");
				memVO2.setMem_id("遊戲王");
				memVO2.setMem_bday(Date.valueOf("1995-03-03"));
				memVO2.setMem_tel("03-9487943");
				memVO2.setMem_pho("0987-987987");
				memVO2.setMem_gend(1);
				memVO2.setMem_email("burnerzx@gmail.com");
				memVO2.setMem_pic(buffer_update);
				memVO2.setMem_intro("黑魔導女孩 ~ 就決定是妳了 !");
				memVO2.setMem_code(7533967);
				memVO2.setMem_state(2);
				memVO2.setMem_gps_lat(120.132523);
				memVO2.setMem_gps_lng(112.645822);
				memVO2.setMem_ip("10.120.25.31");
				memVO2.setMission_count(9);
				memVO2.setMem_address("桃園市內壢區中山路128號");
				memVO2.setMem_search(1);
				memVO2.setMem_point(2400);

				dao.update(memVO2);

				
				//刪除
//				dao.delete("M000004");
		
		
		//查詢
		MemVO memVO3 = dao.findByPrimaryKey("M000001");
		System.out.print(memVO3.getMem_no() + ",");
		System.out.print(memVO3.getMem_pw() + ",");
		System.out.print(memVO3.getMem_name() + ",");
		System.out.print(memVO3.getMem_id() + ",");
		System.out.print(memVO3.getMem_bday() + ",");
		System.out.print(memVO3.getMem_tel() + ",");
		System.out.print(memVO3.getMem_pho() + ",");
		System.out.print(memVO3.getMem_gend() + ",");
		System.out.print(memVO3.getMem_email() + ",");
//		System.out.print(memVO3.getMem_pic() + ",");
		System.out.print(memVO3.getMem_intro() + ",");
		System.out.print(memVO3.getMem_code() + ",");
		System.out.print(memVO3.getMem_gps_lat() + ",");
		System.out.print(memVO3.getMem_gps_lng() + ",");
		System.out.print(memVO3.getMem_ip() + ",");
		System.out.print(memVO3.getMission_count() + ",");
		System.out.print(memVO3.getMem_address() + ",");
		System.out.println(memVO3.getMem_search() + ",");
		System.out.println(memVO3.getMem_point());
		System.out.println("===============================================");
		
		
		//查詢
		List<MemVO> list = dao.getAll();
		for(MemVO aMem : list){
			System.out.print(aMem.getMem_no() + ",");
			System.out.print(aMem.getMem_pw() + ",");
			System.out.print(aMem.getMem_name() + ",");
			System.out.print(aMem.getMem_id() + ",");
			System.out.print(aMem.getMem_bday() + ",");
			System.out.print(aMem.getMem_tel() + ",");
			System.out.print(aMem.getMem_pho() + ",");
			System.out.print(aMem.getMem_gend() + ",");
			System.out.print(aMem.getMem_email() + ",");
//			System.out.print(aMem.getMem_pic() + ",");
			System.out.print(aMem.getMem_intro() + ",");
			System.out.print(aMem.getMem_code() + ",");
			System.out.print(aMem.getMem_gps_lat() + ",");
			System.out.print(aMem.getMem_gps_lng() + ",");
			System.out.print(aMem.getMem_ip() + ",");
			System.out.print(aMem.getMission_count() + ",");
			System.out.print(aMem.getMem_address() + ",");
			System.out.println(aMem.getMem_search() + ",");
			System.out.println(aMem.getMem_point());
			System.out.println("===============================================");
		}
		
		
		
		
	}







}
