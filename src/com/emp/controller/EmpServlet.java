package com.emp.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp.model.EmpService;
import com.emp.model.EmpVO;


@WebServlet("/EmpServlet")
public class EmpServlet extends HttpServlet {
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
				String str = req.getParameter("emp_No");
				
				
				
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入員工編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/select_page.jsp");
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
							.getRequestDispatcher("/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料*****************************************/
				EmpService empSvc = new EmpService();
				EmpVO empVO = empSvc.getOneEmp(emp_No);

				if (empVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("empVO", empVO); 
				String url = "/backdesk/emp/listOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/select_page.jsp");
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
				String emp_No = new String(req.getParameter("emp_No"));
				
				/***************************2.開始查詢資料****************************************/
				EmpService empSvc = new EmpService();
				EmpVO empVO = empSvc.getOneEmp(emp_No);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("empVO", empVO); 
System.out.println("----------------------------------------");
				String url = "/backdesk/emp/update_emp_input.jsp";
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
System.out.println("55555555555555555555555555");
			String requestURL = req.getParameter("requestURL"); 
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String emp_No = new String(req.getParameter("emp_No").trim());
System.out.println(emp_No);
				String emp_Name = req.getParameter("emp_Name").trim();
System.out.println(emp_Name);
//				String emp_Pwd = req.getParameter("emp_Pwd").trim();				
				String emp_Mail = req.getParameter("emp_Mail").trim();
				String emp_Job = req.getParameter("emp_Job").trim();
				String emp_Phone = req.getParameter("emp_Phone").trim();
				String emp_State = req.getParameter("emp_State").trim(); 

//System.out.println(emp_Pwd);

				EmpVO empVO = new EmpVO();
				empVO.setEmp_No(emp_No);
				empVO.setEmp_Name(emp_Name);
//				empVO.setEmp_Pwd(emp_Pwd);
				empVO.setEmp_Mail(emp_Mail);
				empVO.setEmp_Job(emp_Job);
				empVO.setEmp_Phone(emp_Phone);
				empVO.setEmp_State(emp_State);
System.out.println(emp_Phone);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("empVO", empVO); 
					RequestDispatcher failureView = req
							.getRequestDispatcher("/backdesk/emp/update_emp_input.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}
				
				/***************************2.開始修改資料*****************************************/
				
				
				
				EmpService empSvc = new EmpService();
				empVO = empSvc.updateEmp(emp_No, emp_Name, emp_Mail, emp_Job, emp_Phone,emp_State);
	System.out.println("*****"+empVO.getEmp_Name());			
	/***************************3.修改完成,準備轉交(Send the Success view)*************/					
				
/////////////////////////////////////////////////////////////////////////////////////////////////////
	req.setAttribute("empVO", empVO);
	
                String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("錯誤:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/backdesk/emp/update_emp_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) {  
System.out.println("11111111111");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String emp_Name = req.getParameter("emp_Name").trim();
				Integer random = (int)(Math.random()*999+1);
				String emp_Pwd = String.valueOf(random);
//				String emp_Pwd = String.valueOf((int)(Math.random()*999+1));
				String emp_Mail = req.getParameter("emp_Mail").trim();
				String emp_Job = req.getParameter("emp_Job").trim();
				String emp_Phone = req.getParameter("emp_Phone").trim();
				String emp_State = req.getParameter("emp_State").trim();
				
				
				String to = emp_Mail;
				String subject = "密碼通知";
				String youName = emp_Name;
				String messageText = "Hello! " + youName + " 請謹記此密碼: " + random + "\n" +
   					 " (已經啟用) "; 
				

				EmpVO empVO = new EmpVO();
				empVO.setEmp_Name(emp_Name);
				empVO.setEmp_Pwd(emp_Pwd);
				empVO.setEmp_Mail(emp_Mail);
				empVO.setEmp_Job(emp_Job);
				empVO.setEmp_Phone(emp_Phone);
				empVO.setEmp_State(emp_State);
System.out.println(emp_Pwd);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("empVO", empVO); 
					RequestDispatcher failureView = req
							.getRequestDispatcher("/emp/addEmp.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				EmpService empSvc = new EmpService();
				empVO = empSvc.addEmp(emp_Name, emp_Pwd, emp_Mail, emp_Job, emp_Phone, emp_State);
//				String emp_No = empVO.getEmp_No();
				
				EmpMailService emailSvc = new EmpMailService();
				emailSvc.sendMail(to, subject, messageText);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/backdesk/emp/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/emp/addEmp.jsp");
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
				String emp_No = new String(req.getParameter("emp_No"));
				
				/***************************2.開始刪除資料***************************************/
				EmpService empSvc = new EmpService();
				EmpVO empVO = empSvc.getOneEmp(emp_No);
				empSvc.deleteEmp(emp_No);
				
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
