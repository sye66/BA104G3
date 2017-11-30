package com.auth.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auth.model.AuthService;
import com.auth.model.AuthVO;


@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {
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
				String str = req.getParameter("auth_No");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入權限編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/backdesk/auth/selectAuth_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String auth_No = null;
				try {
					auth_No = new String(str);
				} catch (Exception e) {
					errorMsgs.add("權限編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/backdesk/auth/selectAuth_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料*****************************************/
				AuthService authSvc = new AuthService();
				AuthVO authVO = authSvc.getOneAuth(auth_No);
				if (authVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/backdesk/auth/selectAuth_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("authVO", authVO); 
				String url = "/backdesk/auth/listOneAuth.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/backdesk/auth/selectAuth_page.jsp");
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
				String auth_No = new String(req.getParameter("auth_No"));
				
				/***************************2.開始查詢資料****************************************/
				AuthService authSvc = new AuthService();
				AuthVO authVO = authSvc.getOneAuth(auth_No);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("authVO", authVO); 
System.out.println("----------------------------------------");
				String url = "/backdesk/auth/update_auth_input.jsp";
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
				String auth_No = new String(req.getParameter("auth_No").trim());

				String auth_Name = req.getParameter("auth_Name").trim();

				

				AuthVO authVO = new AuthVO();
				authVO.setAuth_No(auth_No);
				authVO.setAuth_Name(auth_Name);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("authVO", authVO); 
					RequestDispatcher failureView = req
							.getRequestDispatcher("/backdesk/auth/update_auth_input.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}
				
				/***************************2.開始修改資料*****************************************/
				
				
				
				AuthService authSvc = new AuthService();
				authVO = authSvc.updateAuth(auth_No, auth_Name);
				
	/***************************3.修改完成,準備轉交(Send the Success view)*************/					
				
/////////////////////////////////////////////////////////////////////////////////////////////////////
	req.setAttribute("authVO", authVO);
	
                String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("錯誤:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/backdesk/auth/update_auth_input.jsp");
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
				String auth_Name = req.getParameter("auth_Name").trim();

				AuthVO authVO = new AuthVO();
				authVO.setAuth_Name(auth_Name);
	

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("authVO", authVO); 
					RequestDispatcher failureView = req
							.getRequestDispatcher("/auth/addAuth.jsp");
					failureView.forward(req, res);
					return;
				}
	
				/***************************2.開始新增資料***************************************/
				AuthService authSvc = new AuthService();
				authVO = authSvc.addAuth(auth_Name);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/backdesk/auth/listAllAuth.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/auth/addAuth.jsp");
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
				String auth_No = new String(req.getParameter("auth_No"));
				
				/***************************2.開始刪除資料***************************************/
				AuthService authSvc = new AuthService();
				AuthVO authVO = authSvc.getOneAuth(auth_No);
				authSvc.deleteAuth(auth_No);
				
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
