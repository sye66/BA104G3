package com.skillcategory.model;

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

public class SkillCategoryDAO implements SkillCategoryDAO_interface{
	
	private static final String INSERT_STMT = "INSERT INTO SKILL_CATEGORY(skill_cate_no, SKILL_CATE_NAME) VALUES(?,?)";
	private static final String GET_ONE_STMT = "SELECT * FROM SKILL_CATEGORY WHERE skill_cate_no=?";
	private static final String GET_ALL_STMT = "SELECT * FROM SKILL_CATEGORY";
	private static final String DELETE_STMT = "DELETE FROM SKILL_CATEGORY WHERE skill_cate_no = ?";
	private static final String UPDATE_STMT = "UPDATE SKILL_CATEGORY SET SKILL_CATE_NAME=? WHERE skill_cate_no=?";

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
	public void insert(SkillCategoryVO skillCategoryVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, skillCategoryVO.getSkill_Cate_No());
			pstmt.setString(2, skillCategoryVO.getSkill_Cate_Name());
			
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
	public void delete(String skill_cate_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(DELETE_STMT);
			pstmt.setString(1, skill_cate_no);
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
	public void update(SkillCategoryVO skillCategoryVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, skillCategoryVO.getSkill_Cate_Name());
			pstmt.setString(2, skillCategoryVO.getSkill_Cate_No());
			
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
	public SkillCategoryVO findByPrimaryKey(String skill_cate_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		SkillCategoryVO skillCategoryVO = null;
		ResultSet rs = null;
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, skill_cate_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				skillCategoryVO = new SkillCategoryVO();
				skillCategoryVO.setSkill_Cate_No(rs.getString(1));
				skillCategoryVO.setSkill_Cate_Name(rs.getString(2));
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
		
		return skillCategoryVO;
	}

	@Override
	public List<SkillCategoryVO> getall() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SkillCategoryVO skillCategoryVO = null;
		List<SkillCategoryVO> listAllSkillCategory = new ArrayList<SkillCategoryVO>();
		
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				skillCategoryVO = new SkillCategoryVO();
				skillCategoryVO.setSkill_Cate_No(rs.getString(1));
				skillCategoryVO.setSkill_Cate_Name(rs.getString(2));
				listAllSkillCategory.add(skillCategoryVO);
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
		return listAllSkillCategory;
	}
	public static void main(String[] args) {
		SkillCategoryDAO_interface dao = new SkillCategoryDAO_JDBC();
		SkillCategoryVO insertSklCate = new SkillCategoryVO();
		SkillCategoryVO updateSklCate = new SkillCategoryVO();
		SkillCategoryVO selectSklCate = new SkillCategoryVO();
		
		insertSklCate.setSkill_Cate_No("CATE0000005");
		insertSklCate.setSkill_Cate_Name("Killing");
		dao.insert(insertSklCate);
		
		updateSklCate.setSkill_Cate_No("CATE0000002");
		updateSklCate.setSkill_Cate_Name("Saving People");
		dao.update(updateSklCate);
		
		dao.delete("CATE0000005");
		
		selectSklCate = dao.findByPrimaryKey("CATE0000004");
		System.out.println(selectSklCate.getSkill_Cate_No());
		System.out.println(selectSklCate.getSkill_Cate_Name());
		
		List<SkillCategoryVO> listGetAll = dao.getall();
		for(SkillCategoryVO SKVO : listGetAll) {
			System.out.println(SKVO.getSkill_Cate_No());
			System.out.println(SKVO.getSkill_Cate_Name());
		}
	}
}
