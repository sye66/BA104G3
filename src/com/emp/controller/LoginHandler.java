package com.emp.controller;

import java.io.*;
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
		
		
		if ("getOne_For_Display".equals(action)) { 

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
							.getRequestDispatcher("/backdesk/emp/index.jsp");
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
							.getRequestDispatcher("/backdesk/emp/index.jsp");
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
							.getRequestDispatcher("/backdesk/emp/index.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料*****************************************/
				EmpService empSvc = new EmpService();
				EmpVO empVO = empSvc.getOneEmp(emp_No);
System.out.println(empVO);
System.out.println(emp_No);
				
				String pwd = empVO.getEmp_Pwd();
System.out.println(pwd);
System.out.println(str1);
				
				if (empVO == null || !pwd.equals(emp_Pwd) ) {
					errorMsgs.add("查無資料password is wrong");
System.out.println("SFDSGDSGDSG");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/backdesk/emp/index.jsp");
					failureView.forward(req, res);
					return;
				}else{
					req.setAttribute("empVO", empVO); 
					HttpSession session = req.getSession();
					session.setAttribute("empVO", empVO);   //*工作1: 才在session內做已經登入過的標識
  
					try {                                                        
						String location = (String) session.getAttribute("location");
						if (location != null) {
							session.removeAttribute("location");   //*工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)
							res.sendRedirect(location);            
							return;
						}
					}catch (Exception ignored) { }

					res.sendRedirect(req.getContextPath()+"/backdesk/backdesk.jsp");
	
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/backdesk/emp/index.jsp");
					failureView.forward(req, res);
					return;
				}

/***************************3.查詢完成,準備轉交(Send the Success view)*************/


/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/backdesk/emp/index.jsp");
				failureView.forward(req, res);
			}
		}
  }
}