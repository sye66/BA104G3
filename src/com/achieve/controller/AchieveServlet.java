package com.achieve.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.sql.rowset.serial.SerialBlob;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.achieve.model.AchieveService;
import com.achieve.model.AchieveVO;
import com.achieve.model.*;


@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class AchieveServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("ach_No");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入成就編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/selectAchieve_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String ach_No = null;
				try {
					ach_No = new String(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/selectAchieve_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料*****************************************/
				AchieveService achieveSvc = new AchieveService();
				AchieveVO achieveVO = achieveSvc.getOneAchieve(ach_No);
				if (achieveVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/selectAchieve_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("achieveVO", achieveVO); 
				String url = "/backdesk/achieve/listOneAchieve.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/selectAchieve_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); 		
			
			try {
				/***************************1.接收請求參數****************************************/
				String ach_No = new String(req.getParameter("ach_No"));
				
				/***************************2.開始查詢資料****************************************/
				AchieveService achieveSvc = new AchieveService();
				AchieveVO achieveVO = achieveSvc.getOneAchieve(ach_No);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("achieveVO", achieveVO); 
System.out.println("----------------------------------------");
				String url = "/backdesk/achieve/update_achieve_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { 
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL"); 
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				
				String ach_No = new String(req.getParameter("ach_No").trim());
				String ach_Name = req.getParameter("ach_Name").trim();
				String ach_Explain = req.getParameter("ach_Explain").trim();
				
				AchieveVO achieveVO = new AchieveVO();
				
				byte[] ach_Picture = null;
	 			   try{
	 			    Part photo = req.getPart("ach_Picture");
	 			    InputStream in = photo.getInputStream();
	 			   ach_Picture = new byte[in.available()];
	 			    in.read(ach_Picture);
	 			    in.close();
	 			   } catch (FileNotFoundException fe){
	 			    fe.printStackTrace();
	 			   }
	 			   
	 			achieveVO.setAch_No(ach_No);
				achieveVO.setAch_Name(ach_Name);
				achieveVO.setAch_Picture(ach_Picture);
				achieveVO.setAch_Explain(ach_Explain);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("achieveVO", achieveVO); 
					RequestDispatcher failureView = req
							.getRequestDispatcher("/backdesk/achieve/update_achieve_input.jsp");
					failureView.forward(req, res);
					return; 
				}
				/***************************2.開始修改資料*****************************************/
				
				AchieveService achieveSvc = new AchieveService();
				achieveVO = achieveSvc.updateAchieve(ach_No, ach_Name, ach_Picture, ach_Explain);

	/***************************3.修改完成,準備轉交(Send the Success view)*************/					
				
/////////////////////////////////////////////////////////////////////////////////////////////////////
	req.setAttribute("achieveVO", achieveVO);
	
                String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("錯誤:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/backdesk/achieve/update_achieve_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		 if ("insert".equals(action)) {  
			 
			 			List<String> errorMsgs = new LinkedList<String>();
			 			// Store this set in the request scope, in case we need to
			 			// send the ErrorPage view.
			 			req.setAttribute("errorMsgs", errorMsgs);
	

			 			try {
			 				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/

			 				
			 				String ach_Name = req.getParameter("ach_Name").trim();
			 				String ach_Explain = req.getParameter("ach_Explain").trim();
			 				
			 				

			 				byte[] ach_Picture = null;
				 			   try{
				 			    Part photo = req.getPart("ach_Picture");
				 			    InputStream in = photo.getInputStream();
				 			   ach_Picture = new byte[in.available()];
				 			    in.read(ach_Picture);
				 			    in.close();
				 			   } catch (FileNotFoundException fe){
				 			    fe.printStackTrace();
				 			   }
    
			 				
			 				AchieveVO achieveVO = new AchieveVO();
			 				
			 				
			 				achieveVO.setAch_Name(ach_Name);
			 				achieveVO.setAch_Picture(ach_Picture);
			 				achieveVO.setAch_Explain(ach_Explain);
			 				
			

			 				// Send the use back to the form, if there were errors
			 				if (!errorMsgs.isEmpty()) {
			 					req.setAttribute("achieveVO", achieveVO); 
			 					RequestDispatcher failureView = req
			 							.getRequestDispatcher("/achieve/addAchieve.jsp");
			 					failureView.forward(req, res);
			 					return;
			 				}
			 				
			 				/***************************2.開始新增資料***************************************/
			 				AchieveService achieveSvc = new AchieveService();
			 				achieveVO = achieveSvc.addAchieve(ach_Name, ach_Picture, ach_Explain);
			 				
			 				/***************************3.新增完成,準備轉交(Send the Success view)***********/
			 				String url = "/backdesk/achieve/listAllAchieve.jsp";
			 				RequestDispatcher successView = req.getRequestDispatcher(url);
			 				successView.forward(req, res);				
			 				
			 				/***************************其他可能的錯誤處理**********************************/
			 			} catch (Exception e) {
			 				errorMsgs.add(e.getMessage());
			 				RequestDispatcher failureView = req
			 						.getRequestDispatcher("/backdesk/achieve/addAchieve.jsp");
			 				failureView.forward(req, res);
			 			}
			 		}
			 		
			        
			 		if ("delete".equals(action)) { 

			 			List<String> errorMsgs = new LinkedList<String>();
			 			// Store this set in the request scope, in case we need to
			 			// send the ErrorPage view.
			 			req.setAttribute("errorMsgs", errorMsgs);
			 			
			 			String requestURL = req.getParameter("requestURL");

			 			try {
			 				/***************************1.接收請求參數***************************************/
			 				String ach_No = new String(req.getParameter("ach_No"));
			 				
			 				/***************************2.開始刪除資料***************************************/
			 				AchieveService achieveSvc = new AchieveService();
			 				AchieveVO achieveVO = achieveSvc.getOneAchieve(ach_No);
			 				achieveSvc.deleteAchieve(ach_No);
			 				
			 				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
			 				
			 				
			 				String url = requestURL;
			 				RequestDispatcher successView = req.getRequestDispatcher(url); 
			 				successView.forward(req, res);
			 				
			 				/***************************其他可能的錯誤處理**********************************/
			 			} catch (Exception e) {
			 				errorMsgs.add("刪除資料失敗:"+e.getMessage());
			 				RequestDispatcher failureView = req
			 						.getRequestDispatcher(requestURL);
			 				failureView.forward(req, res);
			 			}
			 		}
			 	}
			 }
