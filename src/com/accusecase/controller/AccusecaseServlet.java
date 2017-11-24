package com.accusecase.controller;

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

import com.accusecase.model.*;
import com.casecandidate.model.*;
import com.emp.model.*;
import com.getmission.model.*;
import com.mem.model.MemVO;

public class AccusecaseServlet extends HttpServlet {

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

		if ("accusecase".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
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
//			try {
				String mission_No = (String) req.getParameter("mission_No");
				String accuse_Detail = (String) req.getParameter("accuse_Detail");
				GetMissionService GetMissionSvc = new GetMissionService();
				GetMissionVO getMissionVO = new GetMissionVO();
				Integer mission_State = GetMissionSvc.getOneMission(mission_No).getMission_State();
				AccuseCaseService accuseCaseSevc = new AccuseCaseService();
				AccuseCaseVO accuseCaseVO = new AccuseCaseVO();
				String issuer_No = GetMissionSvc.getOneMission(mission_No).getIssuer_Mem_No();
				if (!issuer_No.equals(memVO.getMem_No())) {
					if (mission_State == 1 || mission_State == 2 || mission_State == 7 || mission_State == 72) {
						System.out.println("111111");
						if(mission_State == 1 || mission_State == 7){
							System.out.println("22222222");
							mission_State = 7;
						}else{
							mission_State = 72;
						}
						getMissionVO = GetMissionSvc.takeMission(mission_No, mission_State);
						accuseCaseVO = accuseCaseSevc.addAccuseCase(mission_No, memVO.getMem_No(), null, accuse_Detail, 1);
					} else if (mission_State == 3 || mission_State == 4) {
						errorMsgs.add("這任務已經有人接案囉,不能檢舉,如有問題請反應後台管理員,謝謝。");
					} else {

						errorMsgs.add("不好意思 此任務已經結案囉~有問題請反應後台管理員,謝謝。");
					}
				} else {
					errorMsgs.add("嘿~不要檢舉自己的任務!");
				}

				if (errorMsgs.size() != 0) {
//					obj.put("errormessage", errorMsgs);

				} else {
					String value = "檢舉成功~";
//					obj.put("message", value);

				}
				out.write(obj.toString());
				getMissionVO = GetMissionSvc.getOneMission(mission_No);
				req.setAttribute("getMissionVO", getMissionVO);
				req.setAttribute("accuseCaseVO", accuseCaseVO);
				req.setAttribute("errorMsgs", errorMsgs);
				String url = "/frontdesk/getmission/missionDetaillogin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				out.flush();
				out.close();
//			} catch (Exception e) {
//				System.out.println(e);
//				errorMsgs.add("檢舉失敗:" + e.getMessage());
//				req.setAttribute("errorMsgs", errorMsgs);
//				RequestDispatcher failureView = req.getRequestDispatcher("");
//				failureView.forward(req, res);
//				return;
//			}

		}
		
		
		if ("cancelaccusecase".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
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
			try {
				String mission_No = (String) req.getParameter("mission_No");
				GetMissionService GetMissionSvc = new GetMissionService();
				GetMissionVO getMissionVO = new GetMissionVO();
				
				Integer mission_State = GetMissionSvc.getOneMission(mission_No).getMission_State();
				AccuseCaseService accuseCaseSevc = new AccuseCaseService();
				AccuseCaseVO accuseCaseVO = new AccuseCaseVO();
				String issuer_No = GetMissionSvc.getOneMission(mission_No).getIssuer_Mem_No();
				if (!issuer_No.equals(memVO.getMem_No()) ) {
					if ( mission_State == 7 || mission_State == 72) {
						if(mission_State == 7 ){
							mission_State = 1;
						}else if(mission_State == 72 && accuseCaseSevc.getCaseBymission(mission_No)==null){
							mission_State = 2;
						}else{
							mission_State = 72;
						}
						getMissionVO = GetMissionSvc.takeMission(mission_No, mission_State);
						String accuse_No = accuseCaseSevc.getOneAccuseCaseBymissionAndmem(mission_No, memVO.getMem_No()).getAccuse_No();
						System.out.println();
						accuseCaseSevc.deleteAccuseCase(accuse_No);
					}else if(mission_State == 1 || mission_State == 2){
						errorMsgs.add("嘿~你從來沒檢舉過喔");
					}else if (mission_State == 3 || mission_State == 4) {
						errorMsgs.add("這任務已經有人接案囉,檢舉已失效,如有問題請反應後台管理員,謝謝。");
					} else {
						errorMsgs.add("不好意思 此任務已經結案囉~有問題請反應後台管理員,謝謝。");
					}
				} else {
					errorMsgs.add("嘿~不要玩自己的任務!");
				}

				if (errorMsgs.size() != 0) {
					obj.put("errormessage", errorMsgs);

				} else {
					String value = "消除檢舉成功~";
					obj.put("message", value);

				}
				out.write(obj.toString());
				
				getMissionVO = GetMissionSvc.getOneMission(mission_No);
				req.setAttribute("getMissionVO", getMissionVO);
				req.setAttribute("accuseCaseVO", accuseCaseVO);
				req.setAttribute("errorMsgs", errorMsgs);
				String url = "/frontdesk/getmission/missionDetaillogin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				out.flush();
				out.close();
			} catch (Exception e) {
				System.out.println(e);
				errorMsgs.add("消除檢舉失敗:" + e.getMessage());
				req.setAttribute("errorMsgs", errorMsgs);
				RequestDispatcher failureView = req.getRequestDispatcher("");
				failureView.forward(req, res);
				return;
			}

		}
		
		
		if ("manageaccuse".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			EmpVO empVO = (EmpVO) req.getSession().getAttribute("empVO");
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");

			if (empVO.getEmp_No() == null) {
				res.sendRedirect("/BA104G3/backdesk/index.jsp");
				return;
			}
			try {
				String accuse_No = (String) req.getParameter("accuse_No");
				String mission_No = (String)req.getParameter("mission_No");
				Integer accuse_State = new Integer(req.getParameter("accuse_State"));
				GetMissionService GetMissionSvc = new GetMissionService();
				GetMissionVO getMissionVO = new GetMissionVO();
				AccuseCaseService AccuseCaseSvc = new AccuseCaseService();
				AccuseCaseVO accuseVO = new AccuseCaseVO();
				CaseCandidateService caseCandidateService = new CaseCandidateService();
				
				if(accuse_State == 2){
					if(caseCandidateService.getCandidate(mission_No)==null){
						getMissionVO = GetMissionSvc.takeMission(mission_No, 9);
						accuseVO = AccuseCaseSvc.updateAccuseCasebyemp(accuse_No, empVO.getEmp_No(), accuse_State);
					}else if(caseCandidateService.getCandidate(mission_No)!=null){
						getMissionVO = GetMissionSvc.takeMission(mission_No, 9);
						accuseVO = AccuseCaseSvc.updateAccuseCasebyemp(accuse_No, empVO.getEmp_No(), accuse_State);
						caseCandidateService.deleteOneCase(mission_No);
					}
					
				}else if(accuse_State == 3){
					if(GetMissionSvc.getOneMission(mission_No).getMission_State() ==72 ){
						getMissionVO = GetMissionSvc.takeMission(mission_No, 2);
						accuseVO = AccuseCaseSvc.updateAccuseCasebyemp(accuse_No, empVO.getEmp_No(), accuse_State);
					}else if(GetMissionSvc.getOneMission(mission_No).getMission_State() ==7){
						getMissionVO = GetMissionSvc.takeMission(mission_No, 1);
						accuseVO = AccuseCaseSvc.updateAccuseCasebyemp(accuse_No, empVO.getEmp_No(), accuse_State);
					}
					
				}else{
					errorMsgs.add("檢舉還未處理喔");
					req.setAttribute("errorMsgs", errorMsgs);
					RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
					return;
				}
				getMissionVO = GetMissionSvc.getOneMission(mission_No);
				accuseVO = AccuseCaseSvc.getOneAccuseCase(accuse_No);
				req.setAttribute("accuseVO", accuseVO);
				req.setAttribute("getMissionVO", getMissionVO);
				req.setAttribute("errorMsgs", errorMsgs);
				req.setAttribute("empVO", empVO);
				String url = "/backdesk/missionManage/missionManage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交
				successView.forward(req, res);
				return;
			} catch (Exception e) {
				System.out.println(e);
				errorMsgs.add("消除檢舉失敗:" + e.getMessage());
				req.setAttribute("errorMsgs", errorMsgs);
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
				return;
			}

		}
	}

}
