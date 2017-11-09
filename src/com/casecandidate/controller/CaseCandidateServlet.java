package com.casecandidate.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.getmission.model.GetMissionService;
import com.getmission.model.GetMissionVO;

public class CaseCandidateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
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
	}

}
