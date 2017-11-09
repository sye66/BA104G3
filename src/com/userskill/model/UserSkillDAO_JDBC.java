package com.userskill.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserSkillDAO_JDBC implements UserSkillDAO_interface{
	private static final String DRIVER = "oracle.jdbc.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USR = "BA104G3";
	private static final String PSW = "123456";

	private static final String INSERT_STMT = "INSERT INTO USER_SKILL(mem_No, skill_no, SKILL_DETAIL, SKILL_CERT) VALUES(?,?,?,?)";
	private static final String GET_ONE_STMT = "SELECT * FROM USER_SKILL WHERE mem_No=? AND skill_no=?";
	private static final String GET_ALL_STMT = "SELECT * FROM USER_SKILL";
	private static final String DELETE_STMT = "DELETE FROM USER_SKILL WHERE mem_No = ? AND skill_no = ?";
	private static final String UPDATE_STMT = "UPDATE USER_SKILL SET SKILL_DETAIL=?, SKILL_CERT=? WHERE mem_No=? AND skill_no=?";

	@Override
	public void insert(UserSkillVO skillVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, skillVO.getMem_No());
			pstmt.setString(2, skillVO.getSkill_No());
			pstmt.setString(3, skillVO.getSkill_Detail());
			pstmt.setBytes(4, skillVO.getSkill_Cert());

			pstmt.executeUpdate();
			System.out.println("新增成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("新增有問題1");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			System.out.println("新增有問題2");
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
	public void delete(String mem_No, String skill_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(DELETE_STMT);
			pstmt.setString(1, mem_No);
			pstmt.setString(2, skill_no);
			pstmt.executeUpdate();
			System.out.println("刪除成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("刪除有問題1");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("刪除有問題2");
			System.out.println(e.getMessage());
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
	public void update(UserSkillVO skillVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, skillVO.getSkill_Detail());
			pstmt.setBytes(2, skillVO.getSkill_Cert());
			pstmt.setString(3, skillVO.getMem_No());
			pstmt.setString(4, skillVO.getSkill_No());
			
			pstmt.executeUpdate();
			
			System.out.println("更新成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("更新有問題");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("更新有問題");
			System.out.println(e.getMessage());
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
	public UserSkillVO findByPrimaryKey(String mem_No, String skill_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		UserSkillVO skillVO = null;
		ResultSet rs = null;
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, mem_No);
			pstmt.setString(2, skill_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				skillVO = new UserSkillVO();
				skillVO.setMem_No(rs.getString(1));
				skillVO.setSkill_No(rs.getString(2));
				skillVO.setSkill_Detail(rs.getString(3));
				skillVO.setSkill_Cert(rs.getBytes(4));
			}
			System.out.println("主鍵查詢完畢");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("主鍵查詢有問題");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("主鍵查詢有問題");
			System.out.println(e.getMessage());
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
		
		return skillVO;
	}

	@Override
	public List<UserSkillVO> getall() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserSkillVO skillVO = null;
		List<UserSkillVO> listSkillVO = new ArrayList<UserSkillVO>();
		
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				skillVO = new UserSkillVO();
				skillVO.setMem_No(rs.getString("mem_No"));
				skillVO.setSkill_No(rs.getString("skill_no"));
				skillVO.setSkill_Detail(rs.getString("SKILL_DETAIL"));
				skillVO.setSkill_Cert(rs.getBytes("SKILL_CERT"));
				listSkillVO.add(skillVO);
				System.out.println(rs.getString("mem_No"));
			}
			System.out.println("全部查詢完畢");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("全查詢有問題1");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("全查詢有問題2");
			System.out.println(e.getMessage());
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
		return listSkillVO;
	}
	
	public static void main(String[] args) {
		
		UserSkillDAO_interface dao = new UserSkillDAO_JDBC();
		
		UserSkillVO insertUserSkill = new UserSkillVO();
		UserSkillVO updateUserSkill = new UserSkillVO();
		UserSkillVO getOneUserSkill= new UserSkillVO();

		
		
		insertUserSkill.setMem_No("M000003");
		insertUserSkill.setSkill_No("SKL000007");
		insertUserSkill.setSkill_Detail("幽靈馬車");
		insertUserSkill.setSkill_Cert(null);
		dao.insert(insertUserSkill);
		
		updateUserSkill.setMem_No("M000002");
		updateUserSkill.setSkill_No("SKL000017");
		updateUserSkill.setSkill_Detail("double頭");
		updateUserSkill.setSkill_Cert(null);
		dao.update(updateUserSkill);
		
		dao.delete("M000002", "SKL000017");
		
		getOneUserSkill = dao.findByPrimaryKey("M000001","SKL000001");
		System.out.println(getOneUserSkill.getMem_No());
		System.out.println(getOneUserSkill.getSkill_No());
		System.out.println(getOneUserSkill.getSkill_Detail());
		System.out.println(getOneUserSkill.getSkill_Cert());
		
		List<UserSkillVO> listGetAll = dao.getall();
		for(UserSkillVO userSkillVO : listGetAll) {
			System.out.println(userSkillVO.getMem_No());
			System.out.println(userSkillVO.getSkill_No());
			System.out.println(userSkillVO.getSkill_Detail());
			System.out.println(userSkillVO.getSkill_Cert());
		}
		
	}
}
