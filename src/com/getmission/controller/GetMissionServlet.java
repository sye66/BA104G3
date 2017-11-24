package com.getmission.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;
import java.sql.Date;
import java.sql.Time;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.apache.catalina.connector.Request;
import org.hibernate.hql.ast.SqlASTFactory;

import com.accusecase.model.*;
import com.casecandidate.model.*;
import com.emp.model.EmpService;
import com.emp.model.EmpVO;
import com.getmission.model.*;
import com.getmission.controller.MailService;
import com.mem.model.MemService;
import com.mem.model.MemVO;

import sun.util.resources.cldr.aa.CalendarData_aa_ER;

public class GetMissionServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("listmission_ByCompositeQuery".equals(action)) { // 來自getMission.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			MemVO memVO =  (MemVO) req.getSession().getAttribute("memVO");
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			// try {

			/*************************** 1.將輸入資料轉為Map **********************************/
			// 採用Map<String,String[]> getParameterMap()的方法
			// 注意:an immutable java.util.Map
			// Map<String, String[]> map = req.getParameterMap();
			HttpSession session = req.getSession();
			Map<String, String[]> map = (Map<String, String[]>) session.getAttribute("map");
			if (req.getParameter("whichPage") == null) {
				HashMap<String, String[]> map1 = (HashMap<String, String[]>) req.getParameterMap();
				HashMap<String, String[]> map2 = new HashMap<String, String[]>();
				map2 = (HashMap<String, String[]>) map1.clone();
				session.setAttribute("map", map2);
				map = (HashMap<String, String[]>) req.getParameterMap();
			}
			/*************************** 2.開始複合查詢 ***************************************/
			GetMissionService getMissionSvc = new GetMissionService();
			List<GetMissionVO> list = getMissionSvc.getAll(map);
			/***************************
			 * 3.查詢完成,準備轉交(Send the Success view)
			 ************/
			req.setAttribute("listmission_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
			RequestDispatcher successView = null;
			if (memVO == null) {
				successView = req.getRequestDispatcher("/frontdesk/getmission/getMissionSearch.jsp"); // 成功轉交getMissionSearch.jsp
			} else {
				successView = req.getRequestDispatcher("/frontdesk/getmission/getMissionSearchlogin.jsp"); // 成功轉交getMissionSearchlogin.jsp
			}

			successView.forward(req, res);

			/*************************** 其他可能的錯誤處理 **********************************/
			// } catch (Exception e) {
			// errorMsgs.add(e.getMessage());
			// RequestDispatcher failureView = req
			// .getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
			// failureView.forward(req, res);
			// }
		}

		if ("mission_Detail".equals(action)) { // 來自getMission.jsp 的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑:
																// 可能為【/emp/listAllEmp.jsp】
																// 或
																// 【/dept/listEmps_ByDeptno.jsp】
																// 或 【
																// /dept/listAllDept.jsp】

			MemVO memVO = (MemVO) req.getSession().getAttribute("memVO");

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String mission_No = req.getParameter("mission_No");

				/*************************** 2.開始查詢資料 ****************************************/
				GetMissionService getMissionSvc = new GetMissionService();
				GetMissionVO getMissionVO = getMissionSvc.getOneMission(mission_No);

				/***************************
				 * 3.查詢完成,準備轉交(Send the Success view)
				 ************/
				req.setAttribute("getMissionVO", getMissionVO); // 資料庫取出的empVO物件,存入req
				String url = null;
				if (memVO == null) {
					url = "/frontdesk/getmission/missionDetail.jsp";
				} else {
					url = "/frontdesk/getmission/missionDetaillogin.jsp";
				}

				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ************************************/
			} catch (Exception e) {
				errorMsgs.add("資料取出時失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}

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
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
			
				return;
			}

			String mission_No = req.getParameter("mission_No").trim();
			GetMissionService getMissionSvc = new GetMissionService();
			GetMissionVO getMissionVO = new GetMissionVO();
			Integer mission_State = getMissionSvc.getOneMission(mission_No).getMission_State();

			CaseCandidateService CaseCandidateSvc = new CaseCandidateService();
			

			if (!getMissionSvc.getOneMission(mission_No).getIssuer_Mem_No().equals(memVO.getMem_No()) ) {

				if (!CaseCandidateSvc.getCandidate(mission_No).contains(memVO.getMem_No())) {
					if (mission_State == 1 || mission_State == 2 || mission_State == 7 || mission_State == 72) {
						if (mission_State == 1 || mission_State == 2) {
							getMissionVO.setMission_State(2);
						} else {
							getMissionVO.setMission_State(72);
						}
						getMissionVO.setMission_No(mission_No);
					} else if (mission_State == 6) {
						errorMsgs.add("此任務已失效");
						RequestDispatcher failureView = req
								.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
						failureView.forward(req, res);
						return;
					} else {
						errorMsgs.add("此任務已結案");
						RequestDispatcher failureView = req
								.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
						failureView.forward(req, res);
						return;
					}

					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
						failureView.forward(req, res);
						return; // 程式中斷
					}

					/*************************** 2.開始修改資料 *****************************************/

					getMissionVO = getMissionSvc.takeMission(mission_No, getMissionVO.getMission_State());

					req.setAttribute("getMissionVO", getMissionVO);
					req.setAttribute("memVO", memVO);
					req.setAttribute("errorMsgs", errorMsgs);

					RequestDispatcher failureView = req.getRequestDispatcher("/casecandidate/casecandidate.do");
					failureView.forward(req, res);
					return; // 程式中斷

					/*************************** 其他可能的錯誤處理 *************************************/
					// } catch (Exception e) {
					// System.out.println(e);
					// errorMsgs.add("修改資料失敗:"+e.getMessage());
					// RequestDispatcher failureView = req
					// .getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
					// failureView.forward(req, res);
					// }
				} else {
					errorMsgs.add("請不要重覆接取相同任務~");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
					failureView.forward(req, res);
					return;
				}

			} else {
				errorMsgs.add("不能接自己的任務喔~");
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
				failureView.forward(req, res);
				return;
			}

		}

		if ("chosemem".equals(action)) { // 來自getmission.jsp 或
											// mission_Detail的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑:
																// 可能為【/getmission/getmission.jsp】
																// 或
																// 【/getmission/mission_Detail.jsp】
			MemVO memVO = (MemVO) req.getSession().getAttribute("memVO");
			if (memVO == null) {
				errorMsgs.add("請登入再來喔");
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/casecandidate/casecandidate.jsp");
				failureView.forward(req, res);
			
				return;
			}

			String takecase_Mem_No = (String) req.getParameter("takecase_Mem_No").trim();
			String mission_No = (String) req.getParameter("mission_No").trim();
			GetMissionVO getMissionVO = new GetMissionVO();
			GetMissionService getMissionSvc = new GetMissionService();
			getMissionVO = getMissionSvc.getOneMission(mission_No);
			AccuseCaseService accuseCaseService = new AccuseCaseService();
			List<AccuseCaseVO> accuseCaseList = accuseCaseService.getCaseBymission(mission_No);
			
			// try {
			/***************************
			 * 1.接收請求參數 - 輸入格式的錯誤處理
			 **********************/

			// set a fresh time
			long now = System.currentTimeMillis();
			java.sql.Timestamp timeStamp = new Timestamp(now);
			long endTime = now + 1000 * 60 * 60 * 24 * 5L;
			java.sql.Timestamp mission_Start_Time = timeStamp;
			java.sql.Timestamp mission_End_Time = new java.sql.Timestamp(endTime);
			Integer mission_State = getMissionVO.getMission_State();
			if (getMissionVO.getMission_State() == 2 || getMissionVO.getMission_State() == 72) {
				mission_State = 3;
				for(AccuseCaseVO  accuseCaseVO:accuseCaseList){
					accuseCaseService.deleteAccuseCase(accuseCaseVO.getAccuse_No());
				}
				
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMisisonlogin.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}
			/*************************** 2.開始修改資料 *****************************************/
			getMissionVO = getMissionSvc.updateOneMission(mission_No, takecase_Mem_No, mission_Start_Time,
					mission_End_Time, mission_State);
			getMissionVO = getMissionSvc.getOneMission(mission_No);
			/***************************
			 * 3.修改完成,準備轉交(Send the Success view)
			 *************/

			req.setAttribute("getMissionVO", getMissionVO);
			String url = "/casecandidate/casecandidate.do";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交回送出修改的來源網頁
			successView.forward(req, res);

			/*************************** 其他可能的錯誤處理 *************************************/
			// } catch (Exception e) {
			// errorMsgs.add("修改資料失敗:" + e.getMessage());
			// System.out.println("66666");
			// RequestDispatcher failureView =
			// req.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
			// failureView.forward(req, res);
			// }
		}

		if ("missiongroup".equals(action)) { // 來自getmission.jsp 或
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
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
			
				return;
			}

			GetMissionVO getMissionVO = new GetMissionVO();

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2. *****************************************/

			req.setAttribute("memVO", memVO);

			RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mission/missiongroup.jsp");
			failureView.forward(req, res);
			return; // 程式中斷

			/*************************** 其他可能的錯誤處理 *************************************/
			// } catch (Exception e) {
			// System.out.println(e);
			// errorMsgs.add("修改資料失敗:"+e.getMessage());
			// RequestDispatcher failureView = req
			// .getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
			// failureView.forward(req, res);
			// }
		}

		if ("missionindex".equals(action)) { // 來自getmission.jsp 或
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
			
			GetMissionVO getMissionVO = new GetMissionVO();

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2. *****************************************/

			req.setAttribute("memVO", memVO);
			RequestDispatcher failureView = null;
			if (memVO == null) {
				failureView = req.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			} else {
				failureView = req.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 其他可能的錯誤處理 *************************************/
			// } catch (Exception e) {
			// System.out.println(e);
			// errorMsgs.add("修改資料失敗:"+e.getMessage());
			// RequestDispatcher failureView = req
			// .getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
			// failureView.forward(req, res);
			// }
		}

		if ("mymission".equals(action)) { // 來自getmission.jsp 或
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
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
			
				return;
			}

			GetMissionVO getMissionVO = new GetMissionVO();

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2. *****************************************/

			req.setAttribute("memVO", memVO);

			RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/casecandidate/casecandidate.jsp");
			failureView.forward(req, res);
			return; // 程式中斷

			/*************************** 其他可能的錯誤處理 *************************************/
			// } catch (Exception e) {
			// System.out.println(e);
			// errorMsgs.add("修改資料失敗:"+e.getMessage());
			// RequestDispatcher failureView = req
			// .getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
			// failureView.forward(req, res);
			// }
		}

		if ("missionwait".equals(action)) { // 來自getmission.jsp 或
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
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
			
				return;
			}
			
			GetMissionVO getMissionVO = new GetMissionVO();

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2. *****************************************/

			req.setAttribute("memVO", memVO);

			RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/casecandidate/waitcase.jsp");
			failureView.forward(req, res);
			return; // 程式中斷

			/*************************** 其他可能的錯誤處理 *************************************/
			// } catch (Exception e) {
			// System.out.println(e);
			// errorMsgs.add("修改資料失敗:"+e.getMessage());
			// RequestDispatcher failureView = req
			// .getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
			// failureView.forward(req, res);
			// }
		}

		if ("successgetmission".equals(action)) { // 來自getmission.jsp 或
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
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
			
				return;
			}

			GetMissionVO getMissionVO = new GetMissionVO();

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2. *****************************************/

			req.setAttribute("memVO", memVO);

			RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mission/finalstep.jsp");
			failureView.forward(req, res);
			return; // 程式中斷

			/*************************** 其他可能的錯誤處理 *************************************/
			// } catch (Exception e) {
			// System.out.println(e);
			// errorMsgs.add("修改資料失敗:"+e.getMessage());
			// RequestDispatcher failureView = req
			// .getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
			// failureView.forward(req, res);
			// }
		}

		if ("checkmem".equals(action)) { // 來自getmission.jsp 或
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
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/mission/issuerfinalstep.jsp");
				failureView.forward(req, res);
			
				return;
			}

			String mission_No = req.getParameter("mission_No").trim();
			String takecase_Mem_No = req.getParameter("takecase_Mem_No").trim();
			GetMissionService getMissionSvc = new GetMissionService();
			GetMissionVO getMissionVO = new GetMissionVO();
			getMissionVO = getMissionSvc.getOneMission(mission_No);
			Integer mission_State = getMissionVO.getMission_State(); //此任務的狀態
			if (getMissionSvc.getOneMission(mission_No).getIssuer_Mem_No().equals(memVO.getMem_No()) ) {

				if (getMissionSvc.getOneMission(mission_No).getTakecase_Mem_No().equals(takecase_Mem_No) ) {
					if (mission_State == 3 ) {
						getMissionVO.setMission_State(4);
						getMissionVO.setMission_No(mission_No);
					} else if (mission_State == 9) {
						errorMsgs.add("此任務已失效");
						RequestDispatcher failureView = req
								.getRequestDispatcher("/frontdesk/mission/issuerfinalstep.jsp");
						failureView.forward(req, res);
						return;
					} else {
						errorMsgs.add("此任務已結案");
						RequestDispatcher failureView = req
								.getRequestDispatcher("/frontdesk/mission/issuerfinalstep.jsp");
						failureView.forward(req, res);
						return;
					}

					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/frontdesk/mission/issuerfinalstep.jsp");
						failureView.forward(req, res);
						return; // 程式中斷
					}

					/*************************** 2.開始修改資料 *****************************************/

					getMissionVO = getMissionSvc.takeMission(mission_No, getMissionVO.getMission_State());
System.out.println(getMissionVO.getMission_State());
					req.setAttribute("getMissionVO", getMissionVO);
					req.setAttribute("memVO", memVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mission/issuerfinalstep.jsp");
					failureView.forward(req, res);
					return; // 程式中斷

					/*************************** 其他可能的錯誤處理 *************************************/
					// } catch (Exception e) {
					// System.out.println(e);
					// errorMsgs.add("修改資料失敗:"+e.getMessage());
					// RequestDispatcher failureView = req
					// .getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
					// failureView.forward(req, res);
					// }
				} else {
					errorMsgs.add("哎~接案者不太對喔");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/mission/issuerfinalstep.jsp");
					failureView.forward(req, res);
					return;
				}

			} else {
				errorMsgs.add("不能玩別人的任務喔~");
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk//mission/issuerfinalstep.jsp");
				failureView.forward(req, res);
				return;
			}

		}

		if ("givepay".equals(action)) { // 來自getmission.jsp 或
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
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			
				return;
			}

			String mission_No = req.getParameter("mission_No").trim();
			GetMissionVO getMissionVO = new GetMissionVO();
			GetMissionService getMissionSvc = new GetMissionService();
			Integer mission_State = getMissionSvc.getOneMission(mission_No).getMission_State();

			MemService memSvc = new MemService();
			String takecase_Mem_No = getMissionSvc.getOneMission(mission_No).getTakecase_Mem_No();
			double takecasemem_Point = memSvc.getOneMem(takecase_Mem_No).getMem_Point();
			double mission_Pay = getMissionSvc.getOneMission(mission_No).getMission_Pay();
			int now = (int) (takecasemem_Point + mission_Pay);
			if (getMissionSvc.getOneMission(mission_No).getIssuer_Mem_No().equals(memVO.getMem_No())) {

				if (getMissionSvc.getOneMission(mission_No).getTakecase_Mem_No().equals(takecase_Mem_No)) {
					if (mission_State == 4 ) {
						getMissionVO.setMission_State(5);
						getMissionVO.setMission_No(mission_No);
					} else if (mission_State == 6) {
						errorMsgs.add("此任務已失效");
						RequestDispatcher failureView = req
								.getRequestDispatcher(requestURL);
						failureView.forward(req, res);
						return;
					} else {
						errorMsgs.add("此任務已結案");
						RequestDispatcher failureView = req
								.getRequestDispatcher(requestURL);
						failureView.forward(req, res);
						return;
					}

					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher(requestURL);
						failureView.forward(req, res);
						return; // 程式中斷
					}

					/*************************** 2.開始修改資料 *****************************************/

					getMissionVO = getMissionSvc.takeMission(mission_No, getMissionVO.getMission_State());
					memVO = memSvc.updateMemPoint(takecase_Mem_No, now);
					req.setAttribute("getMissionVO", getMissionVO);
					req.setAttribute("memVO", memVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mission/mission_finalsuccess.jsp");
					failureView.forward(req, res);
					return; // 程式中斷

					/*************************** 其他可能的錯誤處理 *************************************/
					// } catch (Exception e) {
					// System.out.println(e);
					// errorMsgs.add("修改資料失敗:"+e.getMessage());
					// RequestDispatcher failureView = req
					// .getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
					// failureView.forward(req, res);
					// }
				} else {
					errorMsgs.add("請不要重覆接取相同任務~");
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
					return;
				}

			} else {
				errorMsgs.add("不能處理自己的任務喔~");
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
				return;
			}

		}

		if ("finishwork".equals(action)) { // 來自getmission.jsp 或
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

			String mission_No = (String ) req.getParameter("mission_No");
			MemVO memVO = (MemVO) req.getSession().getAttribute("memVO");
			if (memVO == null) {
				errorMsgs.add("請登入再來喔");
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			
				return;
			}
			
			MemService memSvc = new MemService();
			GetMissionService getMissionSvc = new GetMissionService();
			String to = memVO.getMem_Email();
		      
		    String subject = "任務完成通知";//傳 mail
		      
		    String issuer_Name = memVO.getMem_Id();
		    String takecase_Mem_No = memSvc.getOneMem(getMissionSvc.getOneMission(mission_No).getTakecase_Mem_No()).getMem_Id();
		    String mission_Name = getMissionSvc.getOneMission(mission_No).getMission_Name();
		    String messageText = "Hello! " + issuer_Name + " 您所發的任務, ["+mission_Name +"]~ \n" +takecase_Mem_No+
		    					 " 已經完成囉~請快快去查驗吧~"; 
		    

			GetMissionVO getMissionVO = new GetMissionVO();
			getMissionVO = getMissionSvc.getOneMission(mission_No);
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2. *****************************************/
			MailService mailService = new MailService();
		    mailService.sendMail(to, subject, messageText);
			req.setAttribute("memVO", memVO);
			req.setAttribute("getMissionVO", getMissionVO);
			req.setAttribute("mailService", mailService);
			RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
			failureView.forward(req, res);
			return; // 程式中斷

			/*************************** 其他可能的錯誤處理 *************************************/
			// } catch (Exception e) {
			// System.out.println(e);
			// errorMsgs.add("修改資料失敗:"+e.getMessage());
			// RequestDispatcher failureView = req
			// .getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
			// failureView.forward(req, res);
			// }
	
		}
		
		if ("missiondone".equals(action)) { // 來自getmission.jsp 或
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
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);
			
				return;
			}

			GetMissionVO getMissionVO = new GetMissionVO();

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2. *****************************************/

			req.setAttribute("memVO", memVO);

			RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mission/issuerfinalstep.jsp");
			failureView.forward(req, res);
			return; // 程式中斷

			/*************************** 其他可能的錯誤處理 *************************************/
			// } catch (Exception e) {
			// System.out.println(e);
			// errorMsgs.add("修改資料失敗:"+e.getMessage());
			// RequestDispatcher failureView = req
			// .getRequestDispatcher("/frontdesk/getmission/getmission.jsp");
			// failureView.forward(req, res);
			// }
		}
		
		/**
		 * @author Sander
		 * 新增一般任務，積分五十點。
		 */
		// 任務類別
		if ("issue_Normal_Mission".equals(action)) {
			
			// Value Receiving Test
			System.out.println("got post from issuemission");
			
			// 錯誤處理
			List<String> errorMsg = new LinkedList<>();
			req.setAttribute("errorMsg", errorMsg);
			GetMissionVO getMissionVO = new GetMissionVO();
			
			try {				
				// 任務類別
				String mission_Category = req.getParameter("mission_Category");
				// 任務名稱
				String mission_Name = req.getParameter("mission_Name");
				// 任務敘述
				String  mission_Des = req.getParameter("mission_Des");
				// 發案人會員編號
				String issuer_Mem_No = req.getParameter("issuer_Mem_No");
				// 任務截止時間
				Timestamp mission_Due_Time;
				// 任務模式
				Integer mission_Pattern = 2;
				// 任務積分報酬
				Double mission_Pay = Double.parseDouble(req.getParameter("mission_Pay"));
				// GPS-LAT
				Double mission_Gps_Lat = Double.parseDouble(req.getParameter("mission_Gps_Lat"));
				// GPS-LNG
				Double mission_Gps_Lng = Double.parseDouble(req.getParameter("mission_Gps_Lng"));
				// 任務開始時間 - null
				// 任務結束時間 - null
				Date date = new Date(System.currentTimeMillis());
				
				/**********驗證開始**********/
				if (mission_Pay != 50.00) {
					errorMsg.add("HTML的READONLY就是叫你不要改啦");
				}
				if (mission_Name==null || (mission_Name.trim()).length() == 0) {
					errorMsg.add("安安請告知任務名稱喔");
				}
				if (mission_Des == null || (mission_Des.trim()).length() == 0) {
					errorMsg.add("不給任務敘述是要我們怎麼幫你啊蛤");
				}
				// 錯誤訊息傳回
				if (!errorMsg.isEmpty()) {
					for (String string : errorMsg) {
						System.out.println(string);
					}
					req.setAttribute("getMissionVO", getMissionVO);
					RequestDispatcher inputError = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_normalmission.jsp");
					inputError.forward(req, res);
					return;
				}
				/**********儲值驗證，不夠就轉向積分不足頁面，再轉儲值或是發任務頁面**********/
				MemService memService = new MemService();
				MemVO memVO = memService.getOneMem(issuer_Mem_No);
				if (memVO.getMem_Point() < mission_Pay) {
					RequestDispatcher NotEnoughPoint = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_Failed_NotEnough.jsp");
					NotEnoughPoint.forward(req, res);
					return;
				}
				/**********準備寫入與轉向**********/
				// 任務截止時間加工
				// 開始後五天為截止，看起來DAO沒辦法改了。在此手動加五天
				Calendar calendar = Calendar.getInstance();
				//以現在的時間點創建(任務建立時間點)
				calendar.setTimeInMillis(System.currentTimeMillis());
				//加五天
				calendar.add(calendar.DAY_OF_MONTH, 5);
				//第一次getTime()是Date, 第二次getTime()是Timestamp
				mission_Due_Time = new Timestamp(calendar.getTime().getTime());
				System.out.println(mission_Due_Time);
				
				GetMissionService getMissionService = new GetMissionService();
				getMissionService.addMission(mission_Category,mission_Name,mission_Des,issuer_Mem_No,null,null,mission_Due_Time, null, null,1,mission_Pattern,mission_Pay,mission_Gps_Lat,mission_Gps_Lng);
				memService.DecreaseMemPoint(issuer_Mem_No, mission_Pay.intValue());
				System.out.println("新增一般任務，會員: " + issuer_Mem_No);
				RequestDispatcher successView = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_Success.jsp");
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsg.add(e.getMessage());
				System.out.println(e.getMessage());
				RequestDispatcher inputError = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_normalmission.jsp");
				inputError.forward(req, res);
			}
			
		}
		/**
		 * @author Sander
		 * 新增緊急任務，積分無上限。
		 */
		// 任務類別
		if ("issue_Emergency_Mission".equals(action)) {
			
			// Value Receiving Test
			System.out.println("got post from Emergency");
			
			// 錯誤處理
			List<String> errorMsg = new LinkedList<>();
			req.setAttribute("errorMsg", errorMsg);
			GetMissionVO getMissionVO = new GetMissionVO();
			
			try {				
				// 任務類別
				String mission_Category = req.getParameter("mission_Category");
				// 任務名稱
				String mission_Name = req.getParameter("mission_Name");
				// 任務敘述
				String  mission_Des = req.getParameter("mission_Des");
				// 發案人會員編號
				String issuer_Mem_No = req.getParameter("issuer_Mem_No");
				// 任務截止時間
				Timestamp mission_Due_Time;
				// 任務模式
				Integer mission_Pattern = 1;
				// 任務積分報酬
				Double mission_Pay = Double.parseDouble(req.getParameter("mission_Pay"));
				// GPS-LAT
				Double mission_Gps_Lat = Double.parseDouble(req.getParameter("mission_Gps_Lat"));
				// GPS-LNG
				Double mission_Gps_Lng = Double.parseDouble(req.getParameter("mission_Gps_Lng"));
				// 任務開始時間 - null
				// 任務結束時間 - null
				
				/**********驗證開始**********/
				if (mission_Pay < 50.00) {
					errorMsg.add("安安積分太少了吧");
				}
				if (mission_Name==null || (mission_Name.trim()).length() == 0) {
					errorMsg.add("安安請告知任務名稱喔");
				}
				if (mission_Des == null || (mission_Des.trim()).length() == 0) {
					errorMsg.add("不給任務敘述是要我們怎麼幫你啊蛤");
				}

				// 錯誤訊息傳回
				if (!errorMsg.isEmpty()) {
					for (String string : errorMsg) {
						System.out.println(errorMsg);
					}
					req.setAttribute("getMissionVO", getMissionVO);
					RequestDispatcher inputError = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_Failed.jsp");
					inputError.forward(req, res);
					return;
				}
				
				/**********儲值驗證，不夠就轉向積分不足頁面，再轉儲值或是發任務頁面**********/
				MemService memService = new MemService();
				MemVO memVO = memService.getOneMem(issuer_Mem_No);
				if (memVO.getMem_Point() < mission_Pay) {
					RequestDispatcher NotEnoughPoint = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_Failed_NotEnough.jsp");
					NotEnoughPoint.forward(req, res);
					return;
				}

				/**********準備寫入與轉向**********/
				// 任務截止時間加工
				// 開始後五天為截止，看起來DAO沒辦法改了。在此手動加五天
				Calendar calendar = Calendar.getInstance();
				//以現在的時間點創建(任務建立時間點)
				calendar.setTimeInMillis(System.currentTimeMillis());
				//加五天
				calendar.add(calendar.DAY_OF_MONTH, 5);
				//第一次getTime()是Date, 第二次getTime()是Timestamp
				mission_Due_Time = new Timestamp(calendar.getTime().getTime());
				System.out.println(mission_Due_Time);
				
				GetMissionService getMissionService = new GetMissionService();
				getMissionService.addMission(mission_Category,mission_Name,mission_Des,issuer_Mem_No,null,null,mission_Due_Time, null, null,1,mission_Pattern,mission_Pay,mission_Gps_Lat,mission_Gps_Lng);
				memService.DecreaseMemPoint(issuer_Mem_No, mission_Pay.intValue());
				System.out.println("新增一般任務，會員: " + issuer_Mem_No);
				RequestDispatcher successView = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_Success.jsp");
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsg.add(e.getMessage());
				System.out.println(e.getMessage());
				RequestDispatcher inputError = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_Failed.jsp");
				inputError.forward(req, res);
			}	
		}	
	}
}
