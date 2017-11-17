package com.follow_tool_man.model;

import org.hibernate.*;
import hibernate.util.HibernateUtil;
import java.util.*;

public class Follow_tmDAO implements Follow_tmDAO_interface{
	

	private static final String INSERT_STMT=
			"INSERT INTO follow_tool_man (follower_Mem_No,followed_Mem_No,follow_Status)"
			+ "VALUES (?,?,?)";
	
	private static final String GET_ALL_STMT=
			"SELECT followed_Mem_No,follow_Status"
			+ " FROM follow_tool_man WHERE follower_Mem_No=? order by follower_Mem_No";
	
	private static final String SELECT=
			"SELECT follower_Mem_No,followed_Mem_No,follow_Status"
			+ " FROM follow_tool_man WHERE follower_Mem_No=?";
	
	private static final String UPDATE=
			"UPDATE follow_tool_man SET follow_Status=?"
			+ "WHERE follower_Mem_No=? and followed_Mem_No=?";
			
	private static final String DELETE=
			"DELETE FROM follow_tool_man WHERE follower_Mem_No=? and followed_Mem_No=? ";
	
	
	@Override
	public void insert(Follow_tmVO follow_tmVO) {
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(follow_tmVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	
	
	@Override
	public void delete(String follower_Mem_No, String followed_Mem_No) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(follower_Mem_No,followed_Mem_No);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	
	

	@Override
	public void update(Follow_tmVO follow_tmVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(follow_tmVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	

	@Override
	public Follow_tmVO findByPrimaryKey(String follower_Mem_No, String followed_Mem_No) {
		Follow_tmVO follow_tmVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			follow_tmVO = (Follow_tmVO) session.get(Follow_tmVO.class, follow_tmVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return follow_tmVO;
	}

	@Override
	public List<Follow_tmVO> getAllDependOnFollower_Mem_No(String follower_Mem_No) {
		List<Follow_tmVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	
	
	public static void main(String[] args) {

		Follow_tmDAO dao = new Follow_tmDAO();

		// 新增
		Follow_tmVO follow_tmVO1 = new Follow_tmVO();
		follow_tmVO1.setFollower_Mem_No("吳永志1");
		follow_tmVO1.setFollowed_Mem_No("MANAGER");
		follow_tmVO1.setFollow_Status(0);
		dao.insert(follow_tmVO1);

		// 修改
		Follow_tmVO follow_tmVO3 = new Follow_tmVO();
		follow_tmVO3.setFollower_Mem_No("吳永志1");
		follow_tmVO3.setFollowed_Mem_No("MANAGER");
		follow_tmVO3.setFollow_Status(0);
	
		dao.update(follow_tmVO3);

		// 刪除
//		dao.delete(7014);

		// 查詢
		Follow_tmVO follow_tmVO2 = dao.findByPrimaryKey("M000001","M000002");
		System.out.print(follow_tmVO2.getFollower_Mem_No() + ",");
		System.out.print(follow_tmVO2.getFollowed_Mem_No() + ",");
		System.out.print(follow_tmVO2.getFollow_Status() + ",");
		
		System.out.println("---------------------");

		// 查詢
		List<Follow_tmVO> list = dao.getAllDependOnFollower_Mem_No("M000001");
		for (Follow_tmVO aFollow_tmVO : list) {
			System.out.print(aFollow_tmVO.getFollower_Mem_No() + ",");
			System.out.print(aFollow_tmVO.getFollowed_Mem_No() + ",");
			System.out.print(aFollow_tmVO.getFollow_Status() + ",");
	
			System.out.println();
		}
	}
			
}
