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
		if("getAdByArtiTitle_For_Display".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String arti_No = req.getParameter("arti_Title");
				if(arti_No==null||(arti_No.trim()).length()==0){
					errorMsgs.add(" 請輸入回覆廣告編號 !!! ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
					failureView.forward(req, res);
					return;
				}

//				String arti_No= null;
//				try{
//					arti_No = req.getParameter("arti_No");
//				} catch (Exception e){
//					errorMsgs.add(" 回覆文章編號格式不正確 ");
//				}
				
				/***************************2.開始查詢資料*****************************************/
				AdService adSvc = new AdService ();
				AdVO adVO = adSvc.getOneAd(arti_No);
	
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
				errorMsgs.add(" 無法取得資料 : "+ e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		//@O@???
		if("listArtiReply_ByArtiClsNo".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("ad_No");
				if(str==null||(str.trim()).length()==0){
					errorMsgs.add(" 請輸入回覆文章分類編號 !!! ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/***************************2.開始查詢資料*****************************************/
				AdService adSvc = new AdService ();
				AdVO adVO = adSvc.findAd(ad_No);

				if (adVO==null){
					errorMsgs.add(" 查無分類回覆資料 ");
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
				errorMsgs.add(" 無法取得資料 : "+ e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/ad/selectAd_page.jsp");
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
			
//			Timestamp nowTime1 = new Timestamp(System.currentTimeMillis());
//			Timestamp ad_End = nowTime1;
			
			String ad_Fty_No = req.getParameter("ad_Fty_No");
			String ad_Fty_Name = req.getParameter("ad_Fty_Name");
			
			AdVO adVO = new AdVO();
			
			adVO.setAd_No(ad_No);
			adVO.setAd_Pic(ad_Pic);
			adVO.setAd_Desc(ad_Desc);
			adVO.setAd_Start (ad_Start);
//			adVO.setAd_End(ad_End);
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
			
			try{
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/	
				String ad_No = req.getParameter("ad_No").trim();
				
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
				
				String ad_Desc = req.getParameter("Desc_No").trim();
				
				if (ad_Desc == null||ad_Desc.trim().length()==0){
					errorMsgs.add(" 回覆內容敘述請勿空白 ");
				}
				
				Timestamp nowTime = new Timestamp(System.currentTimeMillis());
				Timestamp ad_Start = nowTime;
				
//				Timestamp nowTime1 = new Timestamp(System.currentTimeMillis());
//				Timestamp ad_End = nowTime1;
				
				String ad_Fty_No = req.getParameter("arti_Fty_No").trim();			
				String ad_Fty_Name = req.getParameter("arti_Fty_Name").trim();
				
				AdVO adVO = new AdVO();				
				adVO.setAd_No(ad_No);
				adVO.setAd_Pic(ad_Pic);
				adVO.setAd_Desc(ad_Desc);
				adVO.setAd_Start (ad_Start);
//				adVO.setAd_End(ad_End);
				adVO.setAd_Fty_No(ad_Fty_No);
				adVO.setAd_Fty_Name (ad_Fty_Name);

				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("adVO", adVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/ad/addAd.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				AdService adSvc = new AdService();
				adVO = adSvc.updateAd(ad_No,ad_Pic,ad_Desc,ad_Start,ad_End,ad_Fty_No,ad_Fty_Name);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("adVo", adVO);
				String url = "/backdesk/ad/listAllAd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/ad/addAd.jsp");
				failureView.forward(req, res);
			}
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
