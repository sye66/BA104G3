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

import com.casecandidate.model.CaseCandidateService;
import com.casecandidate.model.CaseCandidateVO;
import com.getmission.model.GetMissionService;
import com.getmission.model.GetMissionVO;
import com.mem.model.MemVO;

public class CaseCandidateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("take_mission".equals(action)) { // 來自getmission.jsp 或
												// mission_Detail的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑:
																// 可能為【/getmission/getmission.jsp】
																// 或
																// 【/getmission/mission_Detail.jsp】

			// try {
			/***************************
			 * 1.接收請求參數 - 輸入格式的錯誤處理
			 **********************/

			MemVO memVO = (MemVO) req.getSession().getAttribute("memVO");
			if (memVO == null) {
				errorMsgs.add("請登入再來喔");
				res.sendRedirect(requestURL);
				return;
			}

			String mission_No = req.getParameter("mission_No").trim();

			CaseCandidateVO CaseCandidateVo = new CaseCandidateVO();

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("CaseCandidateVo", CaseCandidateVo); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始查詢 *****************************************/
			CaseCandidateService caseCandidateSvc = new CaseCandidateService();
			CaseCandidateVo = caseCandidateSvc.addCaseCandidate(memVO.getMem_No(), mission_No, 1);

			req.setAttribute("CaseCandidateVo", CaseCandidateVo);
			req.setAttribute("errorMsgs", errorMsgs);
			RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getmission_success.jsp");
			failureView.forward(req, res);
			return; // 程式中斷

			/*************************** 其他可能的錯誤處理 *************************************/
			// } catch (Exception e) {
			// errorMsgs.add("接取任務失敗:"+e.getMessage());
			// RequestDispatcher failureView = req
			// .getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
			// failureView.forward(req, res);
			// }
		}

		if ("chosemem".equals(action)) { // 來自getmission.jsp 或
												// mission_Detail的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			GetMissionVO getMissionVO = (GetMissionVO) req.getAttribute("getMissionVO");
			GetMissionService getMissionSvc = new GetMissionService();
			String mission_No = getMissionVO.getMission_No();
			// try {
			/***************************
			 * 1.接收請求參數 - 輸入格式的錯誤處理
			 **********************/

			

			CaseCandidateVO CaseCandidateVo = new CaseCandidateVO();

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("CaseCandidateVo", CaseCandidateVo); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始查詢 *****************************************/
			CaseCandidateService caseCandidateSvc = new CaseCandidateService();
			getMissionVO = getMissionSvc.getOneMission(mission_No);
			caseCandidateSvc.deleteOneCase(mission_No);
			req.setAttribute("CaseCandidateVo", CaseCandidateVo);
			RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/casecandidate/casecandidate.jsp");
			failureView.forward(req, res);
			return; // 程式中斷

			/*************************** 其他可能的錯誤處理 *************************************/
			// } catch (Exception e) {
			// errorMsgs.add("接取任務失敗:"+e.getMessage());
			// RequestDispatcher failureView = req
			// .getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
			// failureView.forward(req, res);
			// }
		}
	}
}
