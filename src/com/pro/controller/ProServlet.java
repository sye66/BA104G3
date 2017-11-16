package com.pro.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.pro.model.ProService;
import com.pro.model.ProVO;
import com.proclass.model.ProClassService;

//@WebServlet("/ProServlet.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class ProServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProServlet() {
		super();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)||"getOne_For_Display_F".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
//			String requestURL = req.getParameter("requestURL");
		
			try {
				/***************************
				 * 1.接收請求參數 - 輸入格式的錯誤處理
				 **********************/
				String pro_No = req.getParameter("pro_No");
				
				if (pro_No == null || (pro_No.trim()).length() == 0) {
					errorMsgs.add("輸入格式的錯誤");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/selectPage.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ProService proSvc = new ProService();
				
				 ProVO proVO = proSvc.getOnePro(pro_No);
				if (proVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/selectPage.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/***************************
				 * 3.查詢完成,準備轉交(Send the Success view)
				 *************/
				req.setAttribute("proVO", proVO);
				String url = null;
				if("getOne_For_Display_F".equals(action)){
					
					url = "/frontdesk/pro/selectOnePro.jsp";
				}else {
					url = "/backdesk/pro/listOnePro.jsp";
				}
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/selectPage.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************
				 * 1.接收請求參數 - 輸入格式的錯誤處理
				 *************************/
				String pro_Name = req.getParameter("pro_Name").trim();
				String pro_Info = req.getParameter("pro_Info").trim();

				java.sql.Date pro_Dis_StartDate = null;
				try {
					pro_Dis_StartDate = java.sql.Date.valueOf(req.getParameter("pro_Dis_StartDate").trim());
				} catch (IllegalArgumentException e) {
					pro_Dis_StartDate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				java.sql.Date pro_Dis_EndDate = null;
				try {
					pro_Dis_EndDate = java.sql.Date.valueOf(req.getParameter("pro_Dis_EndDate").trim());
				} catch (IllegalArgumentException e) {
					pro_Dis_EndDate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				Double pro_Price = null;
				try {
					pro_Price = new Double(req.getParameter("pro_Price").trim());
				} catch (NumberFormatException e) {
					pro_Price = 0.0;
					errorMsgs.add("售價請填數字");
				}

				Integer pro_Discount = null;
				try {
					pro_Discount = new Integer(req.getParameter("pro_Discount").trim());
				} catch (NumberFormatException e) {
					pro_Discount = 100;
					errorMsgs.add("折扣請填數字");
				}

				String pro_Class_No = new String(req.getParameter("pro_Class_No").trim());
				String pro_Status = new String(req.getParameter("pro_Status").trim());
				
				
				// 圖片的必要接法
				 Part part = req.getPart("pro_Pic");
				 java.io.InputStream in = part.getInputStream();
				 byte[] pro_Pic=new byte[in.available()];
				 in.read(pro_Pic);
				 in.close();
	
				
				ProVO proVO = new ProVO();
				proVO.setPro_Name(pro_Name);
				proVO.setPro_Price(pro_Price);
				proVO.setPro_Info(pro_Info);
				proVO.setPro_Class_No(pro_Class_No);
				proVO.setPro_Status(pro_Status);
				proVO.setPro_Discount(pro_Discount);
				proVO.setPro_Dis_StartDate(pro_Dis_StartDate);
				proVO.setPro_Dis_EndDate(pro_Dis_EndDate);
			    proVO.setPro_Pic(pro_Pic);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("proVO", proVO); // 含有輸入格式錯誤的proVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/addPro.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				ProService proSvc = new ProService();
				proVO = proSvc.addPro(pro_Name, pro_Price, pro_Info, pro_Class_No, pro_Status, pro_Discount,
						pro_Dis_StartDate, pro_Dis_EndDate,pro_Pic);

				/***************************
				 * 3.新增完成,準備轉交(Send the Success view)
				 ***********/
				String url = "/backdesk/pro/listAllPro.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllPro.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/addPro.jsp");
				failureView.forward(req, res);
			}
		}

		
		if ("getOne_For_Update".equals(action)) { // 來自listAllPro.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			
			try {
				/***************************1.接收請求參數****************************************/
				String pro_No = req.getParameter("pro_No");
				
				/***************************2.開始查詢資料****************************************/
				ProService proSvc = new ProService();
				ProVO proVO = proSvc.getOnePro(pro_No);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("proVO", proVO);// 資料庫取出的proVO物件,存入req
				req.setAttribute(requestURL, requestURL);
				String url = "/backdesk/pro/update_pro_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_pro_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		
		
		
		if ("update".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL");
			String whichPage = req.getParameter("whichPage");
			try {
				/***************************
				 * 1.接收請求參數 - 輸入格式的錯誤處理
				 **********************/
				String pro_No = req.getParameter("pro_No").trim();
				String pro_Name = req.getParameter("pro_Name").trim();
				String pro_Info = req.getParameter("pro_Info").trim();
				String pro_Status = req.getParameter("pro_Status").trim();
				String pro_Class_No = req.getParameter("pro_Class_No").trim();
				
				Double pro_Price = null;
				try {
					pro_Price = new Double(req.getParameter("pro_Price").trim());
				} catch (NumberFormatException e) {
					pro_Price = 0.0;
					errorMsgs.add("商品價錢請填數字.");
				}

				Integer pro_Discount = null;
				try {
					pro_Discount = new Integer(req.getParameter("pro_Discount").trim());
				} catch (NumberFormatException e) {
					pro_Discount = 100;
					errorMsgs.add("商品折扣請填數字.");
				}

				java.sql.Date pro_Dis_StartDate = null;
				try {
					pro_Dis_StartDate = java.sql.Date.valueOf(req.getParameter("pro_Dis_StartDate").trim());
				} catch (IllegalArgumentException e) {
					pro_Dis_StartDate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入正確日期!");
				}
				java.sql.Date pro_Dis_EndDate = null;
				try {
					pro_Dis_EndDate = java.sql.Date.valueOf(req.getParameter("pro_Dis_EndDate").trim());
				} catch (IllegalArgumentException e) {
					pro_Dis_EndDate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入正確日期!");
				}
				
				// 圖片的必要接法
				 Part part = req.getPart("pro_Pic");
				 java.io.InputStream in = part.getInputStream();
				 byte[] pro_Pic=new byte[in.available()];
				 
				 if(pro_Pic.length==0){
					 ProService proSvc = new ProService();
					 ProVO proVO = proSvc.getOnePro(pro_No);
					 pro_Pic=proVO.getPro_Pic();
				 }
				 
				 in.read(pro_Pic);
				 in.close();

				ProVO proVO = new ProVO();
				proVO.setPro_No(pro_No);
				proVO.setPro_Name(pro_Name);
				proVO.setPro_Price(pro_Price);
				proVO.setPro_Info(pro_Info);
				proVO.setPro_Class_No(pro_Class_No);
				proVO.setPro_Status(pro_Status);
				proVO.setPro_Discount(pro_Discount);
				proVO.setPro_Dis_StartDate(pro_Dis_StartDate);
				proVO.setPro_Dis_StartDate(pro_Dis_EndDate);
				proVO.setPro_Pic(pro_Pic);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("proVO", proVO); 
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/update_pro_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				ProService proSvc = new ProService();
				proVO = proSvc.updatePro( pro_Name, pro_Price, pro_Info, pro_Class_No, pro_Status,pro_Discount,pro_Dis_StartDate,pro_Dis_EndDate,pro_Pic,pro_No);
				/***************************
				 * 3.修改完成,準備轉交(Send the Success view)
				 *************/
				ProClassService proClassSvc = new ProClassService();
//				if(requestURL.equals("/pro/listAllPro.jsp"))
				req.setAttribute("listPro_ByProClassNo",proClassSvc.getOneClass(pro_Class_No)); // 資料庫取出的list物件,存入request
				req.setAttribute("proVO", proVO); // 資料庫update成功後,正確的的proVO物件,存入req
				String url = requestURL+"?whichPage="+whichPage+"&pro_No="+pro_No;; // 送出修改的來源網頁的第幾頁(只用於:istAllEmp.jsp)和修改的是哪一筆
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOnePro.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/update_pro_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 ***************************************/
				String pro_No = req.getParameter("pro_No");
				/*************************** 2.開始刪除資料 ***************************************/
				ProService proSvc = new ProService();
				proSvc.deletePro(pro_No);
				/***************************
				 * 3.刪除完成,準備轉交(Send the Success view)
				 ***********/
				String url = "/backdesk/pro/listAllPro.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/listAllPro.jsp");
				failureView.forward(req, res);
			}
		}

		
		if ("listPro_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				Map<String, String[]> map = req.getParameterMap();
				
				/***************************2.開始複合查詢***************************************/
				ProService proSvc = new ProService();
				List<ProVO> list  = proSvc.getAll(map);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listPro_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/frontdesk/pro/selectOneClassPro2.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/pro/showProIndex.jsp");
				failureView.forward(req, res);
			}
		}		
		
		
		
		
		
		
		
		
	}

}
