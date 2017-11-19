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
import com.getmission.model.*;

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
			String mem_No = (String) req.getSession().getAttribute("mem_No");
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			if (mem_No == null) {
				res.sendRedirect("/BA104G3/loginTest.jsp");
				return;
			}

			try {
				String mission_No = (String) req.getParameter("mission_No");
				String accuse_Detail = (String) req.getSession().getAttribute("accuse_Detail");
				GetMissionService GetMissionSvc = new GetMissionService();
				GetMissionVO getMissionVO = new GetMissionVO();
				if (GetMissionSvc.getOneMission(mission_No) == null) {
				}

				Integer mission_State = GetMissionSvc.getOneMission(mission_No).getMission_State();
				AccuseCaseService accuseCaseSevc = new AccuseCaseService();
				AccuseCaseVO accuseCaseVO = new AccuseCaseVO();
				String issuer_No = GetMissionSvc.getOneMission(mission_No).getIssuer_Mem_No();

				if (issuer_No != mem_No) {
					if (mission_State == 1 || mission_State == 2 || mission_State == 7) {
						mission_State = 7;
						getMissionVO = GetMissionSvc.takeMission(mission_No, mission_State);
						accuseCaseVO = accuseCaseSevc.addAccuseCase(mission_No, mem_No, null, accuse_Detail, 1);
					} else if (mission_State == 3 || mission_State == 4) {
						errorMsgs.add("這任務已經有人接案囉,不能檢舉,如有問題請反應後台管理員,謝謝。");
					} else {

						errorMsgs.add("不好意思 此任務已經結案囉~有問題請反應後台管理員,謝謝。");
					}
				} else {
					errorMsgs.add("嘿~不要檢舉自己的任務!");
				}

				if (errorMsgs.size() != 0) {
					obj.put("errormessage", errorMsgs);

				} else {
					String value = "檢舉成功~";
					obj.put("message", value);

				}
				out.write(obj.toString());
				out.flush();
				out.close();

				getMissionVO = GetMissionSvc.getOneMission(mission_No);
				req.setAttribute("getMissionVO", getMissionVO);
				req.setAttribute("accuseCaseVO", accuseCaseVO);
				req.setAttribute("mem_No", mem_No);
				req.setAttribute("errorMsgs", errorMsgs);
				String url = "/frontdesk/getmission/missionDetaillogin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
			} catch (Exception e) {
				System.out.println(e);
				errorMsgs.add("檢舉失敗:" + e.getMessage());
				req.setAttribute("errorMsgs", errorMsgs);
				RequestDispatcher failureView = req.getRequestDispatcher("");
				failureView.forward(req, res);
			}

		}
	}

}
