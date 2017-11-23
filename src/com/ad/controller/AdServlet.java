package com.ad.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.rowset.serial.SerialBlob;


import com.ad.model.AdService;
import com.ad.model.AdVO;

@MultipartConfig(fileSizeThreshold = 1024*1024, maxFileSize = 5*1024*1024, maxRequestSize = 5*5*1024*1024)
public class AdServlet extends HttpServlet {
	
	private String ad_Fty_No;

	public void doGet (HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException{
		doPost(req, res);
		}
	
	public void doPost (HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException{
			
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		/******[ 取出ㄧ個展示 ]******/
		if("getOneAd_For_Display".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("ad_No");
				if(str==null||(str.trim()).length()==0){
					errorMsgs.add(" 請輸入回覆文章編號 !!! ");
				}
				
				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String ad_No = null;
				try{
					ad_No = req.getParameter("ad_No");
				} catch (Exception e){
					errorMsgs.add(" 廣告編號格式不正確 ");
				}
				
				/***************************2.開始查詢資料*****************************************/
				AdService adSvc = new AdService ();
				AdVO adVO = adSvc.getOneAd(ad_No);
				if (adVO==null){
					errorMsgs.add(" 查無資料 ");
				}
				
				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("adVO", adVO);
				String url = "/backdesk/ad/listOneAd_back.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得廣告 : "+ e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getOneAdFMback_For_Display".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("ad_No");
				if(str==null||(str.trim()).length()==0){
					errorMsgs.add(" 請輸入廣告編號 !!! ");
				}
				
				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String ad_No = null;
				try{
					ad_No = req.getParameter("ad_No");
				} catch (Exception e){
					errorMsgs.add(" 廣告編號格式不正確 ");
				}
				
				/***************************2.開始查詢資料*****************************************/
				AdService adSvc = new AdService ();
				AdVO adVO = adSvc.getOneAd(ad_No);
				if (adVO==null){
					errorMsgs.add(" 查無資料 ");
				}
				
				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("adVO", adVO);
				String url = "/backdesk/ad/listOneAd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得廣告 : "+ e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		//@O@???
		if("listAd_ByFtyNo".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

//			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			    HttpSession session = req.getSession();
				String ad_Fty_No = req.getParameter("ad_Fty_No");
				if(ad_Fty_No==null||(ad_Fty_No.trim()).length()==0){
					errorMsgs.add(" 請輸入廣告商編號 !!! ");
				}
System.out.println(ad_Fty_No);
				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
					failureView.forward(req, res);
					return;
				}
System.out.println("AD-Server-111");
				/***************************2.開始查詢資料*****************************************/
				AdService adSvc = new AdService ();
				Set<AdVO> adVO = adSvc.findAdByFtyNo(ad_Fty_No);
System.out.println(ad_Fty_No+"---1111");
System.out.println("AD-Server-222");
				if (adVO==null){
					errorMsgs.add(" 查無此廠商廣告資料 ");
				}
System.out.println("AD-Server-333");
				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
					failureView.forward(req, res);
					return;
				}
System.out.println(ad_Fty_No+"---2222");
System.out.println("AD-Server-444");
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
System.out.println(ad_Fty_No);
				req.setAttribute("adSet", adVO);
				req.setAttribute("ad_Fty_No", ad_Fty_No);
				String url = "/backdesk/ad/listAd_withSet.jsp";
System.out.println(adVO.size());
System.out.println(adVO);
System.out.println(ad_Fty_No+"---333");
System.out.println("AD-Server-555");
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e){
//				errorMsgs.add(" 無法取得資料 : "+ e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		if ("listAD_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				//Map<String, String[]> map = req.getParameterMap();
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				if (req.getParameter("whichPage") == null){
					HashMap<String, String[]> map1 = (HashMap<String, String[]>)req.getParameterMap();
					HashMap<String, String[]> map2 = new HashMap<String, String[]>();
					map2 = (HashMap<String, String[]>)map1.clone();
					session.setAttribute("map",map2);
					map = (HashMap<String, String[]>)req.getParameterMap();
				} 
				
				/***************************2.開始複合查詢***************************************/
				AdService adSvc = new AdService();
				List<AdVO> list  = adSvc.getAllAD(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listAD_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/backdesk/ad/listAD_ByCompositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		/******[ 取出ㄧ個準備更新 ]******/
		if ("getOneAd_For_Update".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數****************************************/
				String ad_No = req.getParameter("ad_No");
				
				/***************************2.開始查詢資料****************************************/
				AdService adSvc = new AdService();
				AdVO adVO = adSvc.getOneAd(ad_No);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("adVO", adVO);
				String url = "/frontdesk/ad/update_Ad_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/listAllAd.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 更新 ]******/
		if("updateAd".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String reqestURL = req.getParameter("reqestURL");
			
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String ad_No = req.getParameter("ad_No");
			
			byte[] ad_Pic = null;
			try{
				Part photo = req.getPart("ad_Pic");
				InputStream in = photo.getInputStream();
				ad_Pic = new byte[in.available()];
				in.read(ad_Pic);
				in.close();
			} catch (FileNotFoundException fe){
				fe.printStackTrace();
			}

			String ad_Desc = req.getParameter("ad_Desc");
			
			if (ad_Desc == null||ad_Desc.trim().length()==0){
				errorMsgs.add(" 回覆內容敘述請勿空白 ");
			}
			
			Timestamp nowTime = new Timestamp(System.currentTimeMillis());
			Timestamp ad_Start = nowTime;
			Timestamp ad_End = new Timestamp(System.currentTimeMillis()+60*60*24*30*1000);
			
			String ad_Fty_No = req.getParameter("ad_Fty_No");
			String ad_Fty_Name = req.getParameter("ad_Fty_Name");
			
			AdVO adVO = new AdVO();
			
			adVO.setAd_No(ad_No);
			adVO.setAd_Pic(ad_Pic);
			adVO.setAd_Desc(ad_Desc);
			adVO.setAd_Start (ad_Start);
			adVO.setAd_End(ad_End);
			adVO.setAd_Fty_No(ad_Fty_No);
			adVO.setAd_Fty_Name (ad_Fty_Name);
			
			if (!errorMsgs.isEmpty()){
				req.setAttribute("adVO",adVO);
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/ad/update_Ad_input.jsp");

				failureView.forward(req, res);
				return;
			}
			
			/***************************2.開始修改資料*****************************************/
			AdService adSvc = new AdService();
			adVO = adSvc.updateAd(ad_No,ad_Pic,ad_Desc,ad_Start,ad_End,ad_Fty_No,ad_Fty_Name);

			/***************************3.修改完成,準備轉交(Send the Success view)*************/
			req.setAttribute("adVO",adVO);
			String url = "/backdesk/ad/listOneAd.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);
		}
		
		if ("insertAd".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			String requestURL = req.getParameter("requestURL");
System.out.println("AD-Server-111");
//			try{
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/	
				String ad_No = req.getParameter("ad_No").trim();
System.out.println("AD-Server-222");
				byte[] ad_Pic = null;
				try{
					Part photo = req.getPart("ad_Pic");
					InputStream in = photo.getInputStream();
					ad_Pic = new byte[in.available()];
					in.read(ad_Pic);
					in.close();
				} catch (FileNotFoundException fe){
					fe.printStackTrace();
				}
System.out.println("AD-Server-333");
				String ad_Desc = req.getParameter("ad_Desc").trim();
				
				if (ad_Desc == null||ad_Desc.trim().length()==0){
					errorMsgs.add(" 回覆內容敘述請勿空白 ");
				}
System.out.println("AD-Server-444");
				Timestamp nowTime = new Timestamp(System.currentTimeMillis());
				Timestamp ad_Start = nowTime;
				Timestamp ad_End = new Timestamp(System.currentTimeMillis()+60*60*24*30*1000);
				
				String ad_Fty_No = req.getParameter("ad_Fty_No").trim();			
				String ad_Fty_Name = req.getParameter("ad_Fty_Name").trim();
System.out.println("AD-Server-555");
				AdVO adVO = new AdVO();				
				adVO.setAd_No(ad_No);
				adVO.setAd_Pic(ad_Pic);
				adVO.setAd_Desc(ad_Desc);
				adVO.setAd_Start (ad_Start);
//				adVO.setAd_End(ad_End);
				adVO.setAd_Fty_No(ad_Fty_No);
				adVO.setAd_Fty_Name (ad_Fty_Name);
System.out.println("AD-Server-666");
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("adVO", adVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/addAd.jsp");
					failureView.forward(req, res);
					return;
				}
System.out.println("AD-Server-777");
				/***************************2.開始新增資料***************************************/
				AdService adSvc = new AdService();
				adVO = adSvc.updateAd(ad_No,ad_Pic,ad_Desc,ad_Start,ad_End,ad_Fty_No,ad_Fty_Name);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("adVo", adVO);
				String url = "/backdesk/ad/listAllAd_back.jsp";
System.out.println("AD-Server-888");
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
System.out.println("AD-Server-999");
				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e){
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/ad/addAd.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		/******[ 刪除 ]******/
		if ("deleteReply".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數***************************************/
				String ad_No = req.getParameter("ad_No");
			
				/***************************2.開始刪除資料***************************************/
				AdService adSvc = new AdService();
				adSvc.deleteAd(ad_No);

				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/backdesk/ad/listAllAd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 刪除回覆資料失敗 : " + e.getMessage());
				RequestDispatcher failuewView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
				failuewView.forward(req, res);
			}
		}
	}
}
