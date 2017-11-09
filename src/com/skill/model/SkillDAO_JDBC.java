package com.skill.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SkillDAO_JDBC implements SkillDAO_interface{

	private static final String DRIVER = "oracle.jdbc.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USR = "BA104G3";
	private static final String PSW = "123456";
	
	private static final String INSERT_STMT = "INSERT INTO SKILL(SKILL_NO, SKILL_NAME, SKILL_CATE_NO) VALUES(?,?,?)";
	private static final String GET_ONE_STMT = "SELECT * FROM SKILL WHERE SKILL_NO=?";
	private static final String GET_ALL_STMT = "SELECT * FROM SKILL";
	private static final String DELETE_STMT = "DELETE FROM SKILL WHERE SKILL_NO = ?";
	private static final String UPDATE_STMT = "UPDATE SKILL SET SKILL_NAME=?, SKILL_CATE_NO=? WHERE SKILL_NO=?";
	
	@Override
	public void insert(SkillVO skillVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, skillVO.getSkill_no());
			pstmt.setString(2, skillVO.getSkill_name());
			pstmt.setString(3, skillVO.getSkill_cate_no());
			pstmt.executeQuery();
			System.out.println("新增成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
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
	public void delete(String skill_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(DELETE_STMT);
			pstmt.setString(1, skill_no);
			pstmt.executeUpdate();
			System.out.println("刪除成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
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
	public void update(SkillVO skillVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, skillVO.getSkill_name());
			pstmt.setString(2, skillVO.getSkill_cate_no());
			pstmt.setString(3, skillVO.getSkill_no());
			
			pstmt.executeUpdate();
			
			System.out.println("更新成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
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
	public SkillVO findByPrimaryKey(String skill_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		SkillVO skillVO = null;
		ResultSet rs = null;
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, skill_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				skillVO = new SkillVO();
				skillVO.setSkill_no(rs.getString(1));
				skillVO.setSkill_name(rs.getString(2));
				skillVO.setSkill_cate_no(rs.getString(3));
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
	public List<SkillVO> getall() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SkillVO skillVO = null;
		List<SkillVO> listSkill = new ArrayList<SkillVO>();
		
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				skillVO = new SkillVO();
				skillVO.setSkill_no(rs.getString(1));
				skillVO.setSkill_name(rs.getString(2));
				skillVO.setSkill_cate_no(rs.getString(3));
				listSkill.add(skillVO);
			}
			System.out.println("全部查詢完畢");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
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
		return listSkill;
	}
	
	public static void main(String[] args) {
		SkillDAO_interface dao = new SkillDAO_JDBC();
		SkillVO insertSkill = new SkillVO();
		SkillVO updateSkill = new SkillVO();
		SkillVO selectSkill = new SkillVO();
		
		insertSkill.setSkill_no("SKL000030");
		insertSkill.setSkill_name("修飛機");
		insertSkill.setSkill_cate_no("CATE0000003");
		dao.insert(insertSkill);
		
		updateSkill.setSkill_no("SKL000030");
		updateSkill.setSkill_name("修戰鬥機");
		updateSkill.setSkill_cate_no("CATE0000003");
		dao.update(updateSkill);
		
		dao.delete("SKL000030");
		selectSkill = dao.findByPrimaryKey("SKL000001");
		System.out.println(selectSkill.getSkill_no());
		System.out.println(selectSkill.getSkill_name());
		System.out.println(selectSkill.getSkill_cate_no());
		
		List<SkillVO> listGetAll = dao.getall();
		for(SkillVO skillVO : listGetAll) {
			System.out.println(skillVO.getSkill_no());
			System.out.println(skillVO.getSkill_name());
			System.out.println(skillVO.getSkill_cate_no());
		}
	}

}
