package com.getmission.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.casecandidate.model.*;
import com.getmission.model.*;
import com.mem.model.*;


public class WowAmaze extends HttpServlet {
	
	int clickNum = 990;
   
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("");
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
		JSONObject obj = new JSONObject();
		if("wow".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			MemVO memVO = (MemVO) req.getSession().getAttribute("memVO");
			if (memVO == null) {
				errorMsgs.add("請登入再來喔");
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
				return;
			}else if (memVO.getMem_State() == 0) {
					errorMsgs.add("請驗證再來喔");
					System.out.println(errorMsgs);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
					failureView.forward(req, res);
					return;
			}
			
			Integer plusone = new Integer(req.getParameter("plusone"));
			System.out.println("plusone:"+plusone);
			
			System.out.println("clickNum:"+clickNum);
			
			String mission_No = "MISSION000000016";
			GetMissionService getMissionSvc = new GetMissionService();
			CaseCandidateService caseCandidateSvc = new CaseCandidateService();
			GetMissionVO getMissionVO  = new GetMissionVO();
			getMissionVO= getMissionSvc.getOneMission(mission_No);
			MemService memSvc = new MemService();
			if(clickNum>=1000){
				if(getMissionVO.getMission_State()!=5&&getMissionVO.getMission_State()!=6&&getMissionVO.getMission_State()!=9){
					getMissionSvc.updateOneMissionStatus(mission_No, 5);
					List<CaseCandidateVO> lists = caseCandidateSvc.getCandidate(mission_No);
					int mempoint = memSvc.getOneMem(memVO.getMem_No()).getMem_Point();
					int pay = getMissionVO.getMission_Pay().intValue()+mempoint;
					System.out.println("pay"+pay);
					for(CaseCandidateVO list :lists){
						memSvc.updateMemPoint(list.getCandidate_Mem_No(), pay);
						MissionSocket.pushMissionText(list.getCandidate_Mem_No(),"missionOk"); //websocket
					}
					req.setAttribute("getMissionVO", getMissionVO);
					String url = "/frontdesk/getmission/getMission.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交回送出修改的來源網頁
					successView.forward(req, res);
					
				}else{
					errorMsgs.add("此任務已經結束囉");
					System.out.println("此任務已經結束囉");
					String url = "/frontdesk/getmission/getMissionlogin.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交回送出修改的來源網頁
					successView.forward(req, res);
					return;
				}
			}else{
					clickNum = clickNum + plusone;
					System.out.println("afterclickNum: "+clickNum);
			}
			
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMisisonlogin.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}
		}
	}

}
