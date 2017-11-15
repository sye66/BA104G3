package com.ad.model;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.*;
import java.util.LinkedHashSet;
import java.util.Set;

public class AdJDBCDAO implements AdDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "BA104G3";
	String passwd = "123456";
	
	    private static final String INSERT_AD= 
			"INSERT INTO AD (AD_NO,AD_PIC,AD_DESC,AD_START,AD_END,AD_FTY_NO,AD_FTY_NAME) VALUES ('AD'||LPAD(to_char(AD_SEQUENCE.NEXTVAL),8,'0'),?,?,?,?,?,?)";
		private static final String GET_ALL_AD = 
			"SELECT AD_NO,AD_PIC,AD_DESC,to_char(AD_START,'yyyy-mm-dd hh:mm:ss') AD_START,to_char(AD_END,'yyyy-mm-dd hh:mm:ss') AD_END,AD_FTY_NO,AD_FTY_NAME FROM AD order by AD_NO";
		private static final String GET_ONE_AD = 
			"SELECT AD_NO,AD_PIC,AD_DESC,to_char(AD_START,'yyyy-mm-dd hh:mm:ss') AD_START,to_char(AD_END,'yyyy-mm-dd hh:mm:ss') AD_END,AD_FTY_NO,AD_FTY_NAME FROM AD where AD_NO = ?";
		private static final String DELETE_AD = 
			"DELETE FROM AD where AD_NO = ?";
		private static final String UPDATE_AD = 
			"UPDATE AD set AD_PIC=?, AD_DESC=?, AD_START=?, AD_END=?, AD_FTY_NO=?, AD_FTY_NAME=? where AD_NO =?";
		
		
		@Override
		public void insertAd(AdVO adVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try{
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid,passwd);
				pstmt = con.prepareStatement(INSERT_AD);
				
				pstmt.setBytes(1, adVO.getAd_Pic());
				pstmt.setString(2, adVO.getAd_Desc());
				pstmt.setTimestamp(3, adVO.getAd_Start());
				pstmt.setTimestamp(4, adVO.getAd_End());
				pstmt.setString(5, adVO.getAd_Fty_No());
				pstmt.setString(6, adVO.getAd_Fty_Name());
				
				pstmt.executeUpdate();
				con.commit();
				con.setAutoCommit(true);
				
			} catch (ClassNotFoundException ce){
				throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
			} catch (SQLException se){
				throw new RuntimeException("A database error occured." + se.getMessage());
			} catch (Exception e){
				e.printStackTrace(System.err);
			} finally {
				if (pstmt!=null){
					try{
						pstmt.close();
					} catch (SQLException se){
						se.printStackTrace(System.err);
					}
				}
				if (con!=null){
					try{
						con.close();
					} catch (Exception e){
						e.printStackTrace(System.err);
					}
				}
			}
			
			
		}
		@Override
		public void updateAd(AdVO adVO) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try{
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(UPDATE_AD);

				pstmt.setBytes(1, adVO.getAd_Pic());
				pstmt.setString(2, adVO.getAd_Desc());
				pstmt.setTimestamp(3, adVO.getAd_Start());
				pstmt.setTimestamp(4, adVO.getAd_End());
				pstmt.setString(5, adVO.getAd_Fty_No());
				pstmt.setString(6, adVO.getAd_Fty_Name());
				pstmt.setString(7, adVO.getAd_No());

               pstmt.executeUpdate();
				con.commit();
				con.setAutoCommit(true);

			} catch (ClassNotFoundException ce){
				throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
			} catch (SQLException se){
				throw new RuntimeException ("A database error occured." + se.getMessage());
			} catch (Exception e){
				e.printStackTrace(System.err);
			} finally {
				if (pstmt!=null){
					try{
						pstmt.close();
					} catch (SQLException se){
						se.printStackTrace(System.err);
					}
				}
				if (con!=null){
					try{
						con.close();
					} catch (Exception e){
						e.printStackTrace(System.err);
					}
				}
			}
			
		}
		@Override
		public void deleteAd(String ad_No) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try{
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(DELETE_AD);
				con.setAutoCommit(false);
				
				pstmt.setString(1, ad_No);
				
				pstmt.executeUpdate();
				con.commit();
				con.setAutoCommit(true);
				
			} catch (ClassNotFoundException ce){
				throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
			} catch (SQLException se){
				throw new RuntimeException("A database error occrured." + se.getMessage());
			} catch (Exception e){
				e.printStackTrace(System.err);
			} finally {
				if(pstmt!=null){
					try{
						pstmt.close();
					} catch (SQLException se){
						se.printStackTrace(System.err);
					}
				}
				if (con!=null){
					try{
						con.close();
					} catch (SQLException se){
						se.printStackTrace(System.err);
					}
				}
			}
		}
		@Override
		public AdVO findByPrimaryKey(String ad_No) {
			AdVO adVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try{
				Class.forName(driver);
				con = DriverManager.getConnection(url,userid, passwd);
				pstmt = con.prepareStatement(GET_ONE_AD);

				pstmt.setString(1, ad_No);
				rs = pstmt.executeQuery();

				while(rs.next()){
					adVO = new AdVO();
					adVO.setAd_No(rs.getString("ad_No"));
					adVO.setAd_Pic(rs.getBytes("ad_Pic"));
					adVO.setAd_Desc(rs.getString("ad_Desc"));
					adVO.setAd_Start(rs.getTimestamp("ad_Start"));
					adVO.setAd_End(rs.getTimestamp("ad_End"));
					adVO.setAd_Fty_No(rs.getString("ad_Fty_No"));
					adVO.setAd_Fty_Name(rs.getString("ad_Fty_Name"));

				}

			} catch (ClassNotFoundException ce){
				throw new RuntimeException("Couldn't load database driver." + ce.getMessage());
			} catch (SQLException se){
				throw new RuntimeException("A database error occured." + se.getMessage());
			} catch (Exception e){
				e.printStackTrace(System.err);
			} finally {
				if(rs!=null){
					try{
						rs.close();
					} catch (SQLException se){
						se.printStackTrace(System.err);
					}
				}
				if (pstmt!=null){
					try{
						pstmt.close();
					} catch (SQLException se){
						se.printStackTrace(System.err);
					}
				}
				if (con!=null){
					try{
						con.close();
					} catch (SQLException se){
						se.printStackTrace(System.err);
					}
				}
			}
			return adVO;
		}
		@Override
		public Set<AdVO> getAllAd() {
			Set<AdVO> set = new LinkedHashSet<AdVO>();
			AdVO adVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try{
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_ALL_AD);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					adVO = new AdVO();
					adVO.setAd_No(rs.getString("ad_No"));
					adVO.setAd_Pic(rs.getBytes("ad_Pic"));
					adVO.setAd_Desc(rs.getString("ad_Desc"));
					adVO.setAd_Start(rs.getTimestamp("ad_Start"));
					adVO.setAd_End(rs.getTimestamp("ad_End"));
					adVO.setAd_Fty_No(rs.getString("ad_Fty_No"));
					adVO.setAd_Fty_Name(rs.getString("ad_Fty_Name"));
					set.add(adVO);
				}
				
			} catch (ClassNotFoundException ce){
				throw new RuntimeException("Could't load database driver." + ce.getMessage());
			} catch (SQLException se){
				throw new RuntimeException("A database error occured." + se.getMessage());
			} catch (Exception e){
				e.printStackTrace(System.err);
			} finally {
				if(rs!=null){
					try{
						rs.close();
					} catch (SQLException se){
						se.printStackTrace(System.err);
					}
				}
				if(pstmt!=null){
					try{
						pstmt.close();
					} catch (SQLException se){
						se.printStackTrace(System.err);
					}
				}
				if (con!=null){
					try{
						con.close();
					} catch (SQLException se){
						se.printStackTrace(System.err);
					}
				}
			}
			return set;
		}
		
		public static void main (String args[]) throws IOException{
			FileInputStream in = null;
			
			try{
				in = new FileInputStream("C:/BA104_WebApp/xxx.jpg");
			} catch (FileNotFoundException fe){
				fe.printStackTrace(System.err);
			}
			byte[] ad_Pic = new byte[in.available()];
			in.read(ad_Pic);
			in.close();
			
			AdJDBCDAO dao = new AdJDBCDAO();
			
			// 新增
//			AdVO adVO1 = new AdVO();
//			adVO1.setAd_No("AD00000023");
//			adVO1.setAd_Pic(ad_Pic);
//			adVO1.setAd_Desc("^O^/ 樂樂咖啡另一大賣點是每日手作蛋糕 新產品會po在粉絲團上，但都是限量供應，賣完就沒了 我們這間本來是衝著抹茶戚風蛋糕而來，沒想到一下子就完售(泣) 蛋糕櫃擺有目前有的甜點，品名、價格則寫在一旁柱子上，想吃什麼直接跟店員點就行囉");
//			adVO1.setAd_Start(java.sql.Timestamp.valueOf("2017-02-13 07:11:14"));
//			adVO1.setAd_End(java.sql.Timestamp.valueOf("2017-08-13 07:11:14"));
//			adVO1.setAd_Fty_No("FTY000039");
//			adVO1.setAd_Fty_Name("樂樂咖啡 ^O^");
//			dao.insertAd(adVO1);
			
			// 修改
//			AdVO adVO2 = new AdVO();
//			adVO2.setAd_No("AD00000042");
//			adVO2.setAd_Pic(null);
//			adVO2.setAd_Desc("xxx蛋糕 新產品會po在粉絲團上，但都是限量供應，賣完就沒了 我們這間本來是衝著抹茶戚風蛋糕而來，沒想到一下子就完售(泣) 蛋糕櫃擺有目前有的甜點，品名、價格則寫在一旁柱子上，想吃什麼直接跟店員點就行囉");
//			adVO2.setAd_Start(java.sql.Timestamp.valueOf("2017-03-13 07:11:14"));
//			adVO2.setAd_End(java.sql.Timestamp.valueOf("2017-09-13 07:11:14"));
//			adVO2.setAd_Fty_No("FTY000020");
//			adVO2.setAd_Fty_Name("樂樂咖啡--TPE");
//			dao.updateAd(adVO2);
//			System.out.println(adVO2);
//			System.out.println("OK");
			
			// 刪除
//			dao.deleteAd("AD00000043");
			
			// 查詢
//			AdVO adVO3 = dao.findByPrimaryKey("AD00000022");
//			adVO3.setAd_No("AD00000022");
//			adVO3.setAd_Pic(null);
//			adVO3.setAd_Desc("^O^/ 樂樂咖啡另一大賣點是每日手作蛋糕 新產品會po在粉絲團上，但都是限量供應，賣完就沒了 我們這間本來是衝著抹茶戚風蛋糕而來，沒想到一下子就完售(泣) 蛋糕櫃擺有目前有的甜點，品名、價格則寫在一旁柱子上，想吃什麼直接跟店員點就行囉");
//			adVO3.setAd_Start(java.sql.Timestamp.valueOf("2017-02-13 07:11:14"));
//			adVO3.setAd_End(java.sql.Timestamp.valueOf("2017-08-13 07:11:14"));
//			adVO3.setAd_Fty_No("FTY000020");
//			adVO3.setAd_Fty_Name("樂樂咖啡 ^O^");
//			System.out.println("OK!");
			// 查詢
//			Set<AdVO> set = dao.getAllAd();
//			for(AdVO ad : set){
//				System.out.println(ad.getAd_No() + ",");
//				System.out.println(ad.getAd_Pic() + ",");
//				System.out.println(ad.getAd_Desc() + ",");
//				System.out.println(ad.getAd_Start() + ",");
//				System.out.println(ad.getAd_End() + ",");
//				System.out.println(ad.getAd_Fty_No() + ",");
//				System.out.println(ad.getAd_Fty_Name() + ",");
//			}
		}
}
