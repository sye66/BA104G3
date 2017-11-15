package com.skill.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class SkillDAO implements SkillDAO_interface{
	private static final String INSERT_STMT = "INSERT INTO SKILL(SKILL_NO, SKILL_NAME, SKILL_CATE_NO) VALUES('SKL'||LPAD(SEQ_SKILL_NO.NEXTVAL,6,'0'),?,?)";
	private static final String GET_ONE_STMT = "SELECT * FROM SKILL WHERE SKILL_NO=?";
	private static final String GET_ALL_STMT = "SELECT * FROM SKILL";
	private static final String DELETE_STMT = "DELETE FROM SKILL WHERE SKILL_NO = ?";
	private static final String UPDATE_STMT = "UPDATE SKILL SET SKILL_NAME=?, SKILL_CATE_NO=? WHERE SKILL_NO=?";
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	@Override
	public void insert(SkillVO skillVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, skillVO.getSkill_Name());
			pstmt.setString(2, skillVO.getSkill_Cate_No());
			
			pstmt.executeQuery();
			System.out.println("新增成功");
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
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(DELETE_STMT);
			pstmt.setString(1, skill_no);
			pstmt.executeUpdate();
			System.out.println("刪除成功");
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
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, skillVO.getSkill_Name());
			pstmt.setString(2, skillVO.getSkill_Cate_No());
			pstmt.setString(3, skillVO.getSkill_No());
			
			pstmt.executeUpdate();
			
			System.out.println("更新成功");
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
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, skill_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				skillVO = new SkillVO();
				skillVO.setSkill_No(rs.getString(1));
				skillVO.setSkill_Name(rs.getString(2));
				skillVO.setSkill_Cate_No(rs.getString(3));
			}
			System.out.println("主鍵查詢完畢");
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
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				skillVO = new SkillVO();
				skillVO.setSkill_No(rs.getString(1));
				skillVO.setSkill_Name(rs.getString(2));
				skillVO.setSkill_Cate_No(rs.getString(3));
				listSkill.add(skillVO);
			}
			System.out.println("全部查詢完畢");
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
}
