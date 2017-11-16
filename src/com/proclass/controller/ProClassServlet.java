package com.proclass.controller;

import java.io.IOException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;


import com.pro.model.ProVO;
import com.proclass.model.ProClassService;
import com.proclass.model.ProClassVO;

public class ProClassServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************
				 * 1.接收請求參數 - 輸入格式的錯誤處理
				 *************************/
				String pro_Class_Name = req.getParameter("pro_Class_Name").trim();
				
				
				ProClassVO proClassVO = new ProClassVO();
				proClassVO.setPro_Class_Name(pro_Class_Name);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("proClassVO", proClassVO); 
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/proClass/addProClass.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				ProClassService proClassSvc = new ProClassService();
				proClassVO = proClassSvc.addProClass(pro_Class_Name);

				/***************************
				 * 3.新增完成,準備轉交(Send the Success view)
				 ***********/

				String url = "/backdesk/proClass/addProClass.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/proCalss/addProClass.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOneClassPro".equals(action)) {

	
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***************************
				 * 1.接收請求參數 
				 **********************/
				String pro_Class_No = req.getParameter("pro_Class_No");
					
				/*************************** 2.開始查詢資料 *****************************************/
				ProClassService proClassSvc = new ProClassService();
				
				 Set<ProVO> oneClassPro = proClassSvc.getOneClassPro(pro_Class_No);
				

				/***************************
				 * 3.查詢完成,準備轉交(Send the Success view)
				 *************/
				req.setAttribute("oneClassPro", oneClassPro);
			              
				String url = "/frontdesk/pro/selectOneClassPro.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/proClass/addProClass.jsp");
				failureView.forward(req, res);
			}
		}
	
		
		
		
		
		
		
		
		
		
		
		
	}
}
