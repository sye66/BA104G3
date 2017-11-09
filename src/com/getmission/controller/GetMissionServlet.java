package com.getmission.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.getmission.model.*;

public class GetMissionServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("search_Mission".equals(action)) { // 來自getMission.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("mission_No");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入任務編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String mission_No = null;
				try {
					mission_No = new String(str);
				} catch (Exception e) {
					errorMsgs.add("任務編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				GetMissionService getMissionSvc = new GetMissionService();
				GetMissionVO getMissionVO = getMissionSvc.getOneMission(mission_No);
				if (getMissionVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/select_mpage.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("mission_No", mission_No); // 資料庫取出的empVO物件,存入req
				String url = "/frontdesk/getmission/listOneMission.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("mission_Detail".equals(action)) { //來自getMission.jsp 的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】		
			
			try {
				/***************************1.接收請求參數****************************************/
				String mission_No = req.getParameter("mission_No");
				
				/***************************2.開始查詢資料****************************************/
				GetMissionService getMissionSvc = new GetMissionService();
				GetMissionVO getMissionVO = getMissionSvc.getOneMission(mission_No);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("mission_No", getMissionVO); // 資料庫取出的empVO物件,存入req
				String url = "/frontdesk/getmission/missionDetail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); //  成功轉交update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.add("資料取出時失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		
		if ("take_mission".equals(action)) { // 來自getmission.jsp 或 mission_Detail的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/getmission/getmission.jsp】 或  【/getmission/mission_Detail.jsp】
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				String mem_No =(String) req.getSession().getAttribute("mem_No");
				if(mem_No == null){
					
					res.sendRedirect("/BA104G3/loginTest.jsp");
					return;
				}
				
				String mission_No = req.getParameter("mission_No").trim();
				Integer mission_State = new Integer( req.getParameter("mission_State").trim());
				GetMissionVO getMissionVO = new GetMissionVO();
				if(mission_State == 1 || mission_State ==2 || mission_State ==7){
					getMissionVO.setMission_No(mission_No);
					getMissionVO.setMission_State(mission_State);
				}else if(mission_State == 6){
					errorMsgs.add("此任務已失效");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
					failureView.forward(req, res);
					return;
				}else{
					errorMsgs.add("此任務已結案");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				
				
				/***************************2.開始修改資料*****************************************/
				GetMissionService getMissionSvc = new GetMissionService();
				if(mission_State == 1){
					getMissionVO = getMissionSvc.takeMission(mission_No, 2);
				}
				
				req.setAttribute("getMissionVO", getMissionVO); 
				RequestDispatcher failureView = req
						.getRequestDispatcher("/casecandidate/casecandidate.do");
				failureView.forward(req, res);
				return; //程式中斷
			
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
				failureView.forward(req, res);
			}
		}

		
			if ("take_mission1".equals(action)) { // 來自getmission.jsp 或 mission_Detail的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/getmission/getmission.jsp】 或  【/getmission/mission_Detail.jsp】
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mission_No = req.getParameter("mission_No").trim();
				String mission_Category = req.getParameter("mission_Category").trim();
				String mission_Name = req.getParameter("mission_name").trim();	
				String mission_Des = req.getParameter("mission_Des").trim();
				String issuer_Mem_No = req.getParameter("issuer_Mem_No").trim();
				String takecase_Mem_No =  req.getParameter("takecase_Mem_No").trim();
				Integer mission_State = new Integer( req.getParameter("mission_State").trim());
				Integer mission_Pattern = new Integer( req.getParameter("mission_Pattern").trim());
				Double mission_Gps_Lat = new Double(req.getParameter("mission_Gps_Lat").trim());
				Double mission_Gps_Lng = new Double(req.getParameter("mission_Gps_Lng").trim());
				
				java.sql.Date mission_Release_Time = null;
				try {
					mission_Release_Time = java.sql.Date.valueOf(req.getParameter("mission_Release_Time").trim());
				} catch (IllegalArgumentException e) {
					mission_Release_Time=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				java.sql.Date mission_Due_Time = null;
				try {
					mission_Due_Time = java.sql.Date.valueOf(req.getParameter("mission_Due_Time").trim());
				} catch (IllegalArgumentException e) {
					mission_Due_Time=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				
				java.sql.Date mission_Start_Time = null;
				try {
					mission_Start_Time = java.sql.Date.valueOf(req.getParameter("mission_Start_Time").trim());
				} catch (IllegalArgumentException e) {
					mission_Start_Time=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				java.sql.Date mission_End_Time = null;
				try {
					mission_End_Time = java.sql.Date.valueOf(req.getParameter("mission_End_Time").trim());
				} catch (IllegalArgumentException e) {
					mission_End_Time=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				Double mission_Pay = null;
				try {
					mission_Pay = new Double(req.getParameter("mission_Pay").trim());
				} catch (NumberFormatException e) {
					mission_Pay = 0.0;
					errorMsgs.add("積分請填數字.");
				}

				

				GetMissionVO getMissionVO = new GetMissionVO();
				getMissionVO.setMission_No(mission_No);
				getMissionVO.setMission_Category(mission_Category);
				getMissionVO.setMission_Name(mission_Name);
				getMissionVO.setMission_Des(mission_Des);
				getMissionVO.setIssuer_Mem_No(issuer_Mem_No);
				getMissionVO.setTakecase_Mem_No(takecase_Mem_No);
				
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/getmission/update_emp_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				GetMissionService getMissionSvc = new GetMissionService();
				getMissionVO = getMissionSvc.updateMission(mission_No,mission_Category,mission_Name,mission_Des,issuer_Mem_No
						,takecase_Mem_No,mission_Release_Time,mission_Due_Time,mission_Start_Time,mission_End_Time,mission_State,mission_Pattern,mission_Pay,mission_Gps_Lat,mission_Gps_Lng);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
//				MemService deptSvc = new MemService();
//				if(requestURL.equals("/dept/listEmps_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(deptno)); // 資料庫取出的list物件,存入request
//
//                String url = requestURL;
//				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
//				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/emp/update_emp_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
        if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				
				String mission_Category = req.getParameter("mission_Category").trim();
				String mission_Name = req.getParameter("mission_name").trim();	
				String mission_Des = req.getParameter("mission_Des").trim();
				String issuer_Mem_No = req.getParameter("issuer_Mem_No").trim();
				String takecase_Mem_No =  req.getParameter("takecase_Mem_No").trim();
				Integer mission_State = new Integer( req.getParameter("mission_State").trim());
				Integer mission_Pattern = new Integer( req.getParameter("mission_Pattern").trim());
				Double mission_Gps_Lat = new Double(req.getParameter("mission_Gps_Lat").trim());
				Double mission_Gps_Lng = new Double(req.getParameter("mission_Gps_Lng").trim());
				
				java.sql.Date mission_Release_Time = null;
				try {
					mission_Release_Time = java.sql.Date.valueOf(req.getParameter("mission_Release_Time").trim());
				} catch (IllegalArgumentException e) {
					mission_Release_Time=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				Double mission_Pay = null;
				try {
					mission_Pay = new Double(req.getParameter("mission_Pay").trim());
				} catch (NumberFormatException e) {
					mission_Pay = 0.0;
					errorMsgs.add("積分請填數字.");
				}
				
				
				
				

				GetMissionVO getMissionVO = new GetMissionVO();
				
				getMissionVO.setMission_Category(mission_Category);
				getMissionVO.setMission_Name(mission_Name);
				getMissionVO.setMission_Des(mission_Des);
				getMissionVO.setIssuer_Mem_No(issuer_Mem_No);
				getMissionVO.setTakecase_Mem_No(takecase_Mem_No);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/emp/addEmp.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
//				MemService empSvc = new MemService();
//				empVO = empSvc.addEmp(ename, job, hiredate, sal, comm, deptno);
//				
//				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				String url = "/emp/listAllEmp.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
//				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/emp/addEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
       
		if ("delete".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】

			try {
				/***************************1.接收請求參數***************************************/
				String mission_No = req.getParameter("empno");
				
				/***************************2.開始刪除資料***************************************/
				GetMissionService getMissionSvc = new GetMissionService();
				GetMissionVO getMissionVO = getMissionSvc.getOneMission(mission_No);
				getMissionSvc.deleteMission(mission_No);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
//				MemService deptSvc = new MemService();
//				if(requestURL.equals("/dept/listEmps_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(empVO.getDeptno())); // 資料庫取出的list物件,存入request
//				
//				String url = requestURL;
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 刪除成功後,轉交回送出刪除的來源網頁
//				successView.forward(req, res);
				
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
