package com.emp.controller;

import java.io.*;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.emp.model.*;

@WebServlet("/loginhandler")
public class LoginHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//【檢查使用者輸入的帳號(account) 密碼(password)是否有效】
    //【實際上應至資料庫搜尋比對】
  
  
  public void doPost(HttpServletRequest req, HttpServletResponse res)
                                throws ServletException, IOException {
	  req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("emplogin".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("username");
				String str1 = req.getParameter("password");
				if (str == null || (str.trim()).length() == 0 || str1 == null || (str1.trim()).length() == 0) {
					errorMsgs.add("請輸入員工編號和密碼");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
					return;
				}

				String emp_Pwd = null;
				try {
					emp_Pwd = new String(str1);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String emp_No = null;
				try {
					emp_No = new String(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料*****************************************/
				EmpService empSvc = new EmpService();
				EmpVO empVO = empSvc.getOneEmp(emp_No);

				String pwd = empVO.getEmp_Pwd();
System.out.println(pwd+"55555555555555555555555555");
System.out.println(emp_Pwd+"77777777777777777777777777");

				if (empVO == null || !pwd.equals(emp_Pwd) ) {
					errorMsgs.add("查無資料password is wrong");

					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
					return;
				}else{
					req.setAttribute("empVO", empVO); 
					HttpSession session = req.getSession();
					session.setAttribute("empVO", empVO); 
System.out.println(empVO.getEmp_No());
					String url = "/backdesk/backdesk.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);
					
	
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
					return;
				}

/***************************3.查詢完成,準備轉交(Send the Success view)*************/


/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/index.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("logout".equals(action)){
			req.getSession().removeAttribute("empVO");;
			

			String url = "/index.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			
		}
  	}
}