package com.getmission.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.http.*;

import org.hibernate.hql.ast.SqlASTFactory;

import com.casecandidate.model.CaseCandidateService;
import com.emp.model.EmpService;
import com.emp.model.EmpVO;
import com.getmission.model.*;
import com.getmission.controller.MailService;
import com.mem.model.MemService;
import com.mem.model.MemVO;

public class GetMissionServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("listmission_ByCompositeQuery".equals(action)) { // 來自getMission.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			String mem_No = (String) req.getSession().getAttribute("mem_No");
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
			if (mem_No == null) {
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

			String mem_No = (String) req.getSession().getAttribute("mem_No");

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
				if (mem_No == null) {
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

			String mem_No = (String) req.getSession().getAttribute("mem_No");
			if (mem_No == null) {

				res.sendRedirect("/BA104G3/loginTest.jsp");
				return;
			}

			String mission_No = req.getParameter("mission_No").trim();
			Integer mission_State = new Integer(req.getParameter("mission_State").trim());

			GetMissionVO getMissionVO = new GetMissionVO();
			GetMissionService getMissionSvc = new GetMissionService();
			CaseCandidateService CaseCandidateSvc = new CaseCandidateService();

			if (getMissionSvc.getOneMission(mission_No).getIssuer_Mem_No() != mem_No) {

				if (!CaseCandidateSvc.getCandidate(mission_No).contains(mem_No)) {
					if (mission_State == 1 || mission_State == 2 || mission_State == 7) {
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
			String mem_No = (String) req.getSession().getAttribute("mem_No");

			if (mem_No == null) {
				res.sendRedirect("/BA104G3/loginTest.jsp");
				return;
			}

			String takecase_Mem_No = (String) req.getParameter("takecase_Mem_No").trim();
			String mission_No = (String) req.getParameter("mission_No").trim();
			GetMissionVO getMissionVO = new GetMissionVO();
			// try {
			/***************************
			 * 1.接收請求參數 - 輸入格式的錯誤處理
			 **********************/

			// set a fresh time
			long now = System.currentTimeMillis();
			java.sql.Timestamp timeStamp = new Timestamp(now);
			long endTime = now + 1000 * 60 * 60 * 24 * 5L;
			java.sql.Date mission_Start_Time = new java.sql.Date(timeStamp.getTime());
			java.sql.Date mission_End_Time = new java.sql.Date(new Timestamp(endTime).getTime());
			Integer mission_State = null;
			if (getMissionVO.getMission_State() == 2) {
				mission_State = 3;
			} else {
				mission_State = 73;
			}

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMisisonlogin.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始修改資料 *****************************************/
			GetMissionService getMissionSvc = new GetMissionService();
			getMissionVO = getMissionSvc.updateOneMission(mission_No, takecase_Mem_No, mission_Start_Time,
					mission_End_Time, mission_State);
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

			String mem_No = (String) req.getSession().getAttribute("mem_No");
			if (mem_No == null) {

				res.sendRedirect("/BA104G3/loginTest.jsp");
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

			req.setAttribute("mem_No", mem_No);

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

			String mem_No = (String) req.getSession().getAttribute("mem_No");
			// if (mem_No == null) {
			//
			// res.sendRedirect("/BA104G3/loginTest.jsp");
			// return;
			// }

			GetMissionVO getMissionVO = new GetMissionVO();

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2. *****************************************/

			req.setAttribute("mem_No", mem_No);
			RequestDispatcher failureView = null;
			if (mem_No == null) {
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

			String mem_No = (String) req.getSession().getAttribute("mem_No");
			if (mem_No == null) {

				res.sendRedirect("/BA104G3/loginTest.jsp");
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

			req.setAttribute("mem_No", mem_No);

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

			String mem_No = (String) req.getSession().getAttribute("mem_No");
			if (mem_No == null) {

				res.sendRedirect("/BA104G3/loginTest.jsp");
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

			req.setAttribute("mem_No", mem_No);

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

			String mem_No = (String) req.getSession().getAttribute("mem_No");
			if (mem_No == null) {

				res.sendRedirect("/BA104G3/loginTest.jsp");
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

			req.setAttribute("mem_No", mem_No);

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

			String mem_No = (String) req.getSession().getAttribute("mem_No");
			if (mem_No == null) {

				res.sendRedirect("/BA104G3/loginTest.jsp");
				return;
			}

			String mission_No = req.getParameter("mission_No").trim();
			Integer mission_State = new Integer(req.getParameter("mission_State").trim());

			GetMissionVO getMissionVO = new GetMissionVO();
			GetMissionService getMissionSvc = new GetMissionService();
			CaseCandidateService CaseCandidateSvc = new CaseCandidateService();

			if (getMissionSvc.getOneMission(mission_No).getIssuer_Mem_No() != mem_No) {

				if (!CaseCandidateSvc.getCandidate(mission_No).contains(mem_No)) {
					if (mission_State == 3 || mission_State == 73) {
						if (mission_State == 3) {
							getMissionVO.setMission_State(4);
						} else {
							getMissionVO.setMission_State(74);
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

			String mem_No = (String) req.getSession().getAttribute("mem_No");
			if (mem_No == null) {

				res.sendRedirect("/BA104G3/loginTest.jsp");
				return;
			}

			String mission_No = req.getParameter("mission_No").trim();
			Integer mission_State = new Integer(req.getParameter("mission_State").trim());

			GetMissionVO getMissionVO = new GetMissionVO();
			GetMissionService getMissionSvc = new GetMissionService();
			CaseCandidateService CaseCandidateSvc = new CaseCandidateService();
			MemService memSvc = new MemService();
			MemVO memVO = new MemVO();
			double mem_Point = memVO.getMem_Point();
			double mission_Pay = getMissionVO.getMission_Pay();
			int now = (int) (mem_Point + mission_Pay);
			String takecase_Mem_No = getMissionSvc.getOneMission(mission_No).getTakecase_Mem_No();

			if (getMissionSvc.getOneMission(mission_No).getIssuer_Mem_No() != mem_No) {

				if (!CaseCandidateSvc.getCandidate(mission_No).contains(mem_No)) {
					if (mission_State == 4 || mission_State == 74) {
						getMissionVO.setMission_State(5);
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
					memVO = memSvc.updateMemPoint(takecase_Mem_No, now);
					req.setAttribute("getMissionVO", getMissionVO);
					req.setAttribute("memVO", memVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/mission/mission_finalsuccess.jsp");
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

			String mem_No = (String) req.getSession().getAttribute("mem_No");
			String mission_No = (String ) req.getSession().getAttribute("mission_No");
			if (mem_No == null) {

				res.sendRedirect("/BA104G3/loginTest.jsp");
				return;
			}
			
			
			MemService memSvc = new MemService();
			GetMissionService getMissionSvc = new GetMissionService();
			String to = "burnerzx@gmail.com";
		      
		    String subject = "任務完成通知";
		      
		    String issuer_Name = memSvc.getOneMem(getMissionSvc.getOneMission(mission_No).getIssuer_Mem_No()).getMem_Id();
		    String mem_Id = memSvc.getOneMem(mem_No).getMem_Id();
		    String messageText = "Hello! " + issuer_Name + " 您所發的任務, " +mem_Id+
		    					 "/n 已經完成囉~請快快去查驗吧~"; 
		    

			GetMissionVO getMissionVO = new GetMissionVO();

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("getMissionVO", getMissionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMissionlogin.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2. *****************************************/
			MailService mailService = new MailService();
		    mailService.sendMail(to, subject, messageText);
			req.setAttribute("mem_No", mem_No);

			RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getmissionlogin.jsp");
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

			String mem_No = (String) req.getSession().getAttribute("mem_No");
			if (mem_No == null) {

				res.sendRedirect("/BA104G3/loginTest.jsp");
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

			req.setAttribute("mem_No", mem_No);

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
				java.sql.Date mission_Due_Time;
				// 任務模式
				Integer mission_Pattern = 2;
				// 任務積分報酬
				Double misssion_Pay = Double.parseDouble(req.getParameter("mission_Pay"));
				// GPS-LAT
				Double mission_Gps_Lat = Double.parseDouble(req.getParameter("mission_Gps_Lat"));
				// GPS-LNG
				Double mission_Gps_Lng = Double.parseDouble(req.getParameter("mission_Gps_Lng"));
				// 任務開始時間 - null
				// 任務結束時間 - null
				Date date = new Date(System.currentTimeMillis());
				
				/**********驗證開始**********/
				if (misssion_Pay != 50.00) {
					errorMsg.add("HTML的READONLY就是叫你不要改啦");
				}
				if (mission_Name==null || (mission_Name.trim()).length() == 0) {
					errorMsg.add("安安請告知任務名稱喔");
				}
				if (mission_Des == null || (mission_Des.trim()).length() == 0) {
					errorMsg.add("不給任務敘述是要我們怎麼幫你啊蛤");
				}
				// 日期驗證 - 格式
				try {
					mission_Due_Time = Date.valueOf((req.getParameter("mission_Due_Time").trim()));
				} catch (IllegalArgumentException e) {
					mission_Due_Time = new Date(System.currentTimeMillis());
					errorMsg.add("日期格式不對!");
				}
				// 日期驗證 - 值
				if (date.after(mission_Due_Time)) {
					errorMsg.add("你是要工具人做時光機逆");
				}
				// 錯誤訊息傳回
				if (!errorMsg.isEmpty()) {
					req.setAttribute("getMissionVO", getMissionVO);
					RequestDispatcher inputError = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_normalmission.jsp");
					inputError.forward(req, res);
					return;
				}
				
				/**********準備寫入與轉向**********/

				GetMissionService getMissionService = new GetMissionService();
				getMissionService.addMission(mission_Category,mission_Name,mission_Des,issuer_Mem_No,null,null,mission_Due_Time, null, null,1,mission_Pattern,misssion_Pay,mission_Gps_Lat,mission_Gps_Lng);
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
				java.sql.Date mission_Due_Time;
				// 任務模式
				Integer mission_Pattern = 1;
				// 任務積分報酬
				Double misssion_Pay = Double.parseDouble(req.getParameter("mission_Pay"));
				// GPS-LAT
				Double mission_Gps_Lat = Double.parseDouble(req.getParameter("mission_Gps_Lat"));
				// GPS-LNG
				Double mission_Gps_Lng = Double.parseDouble(req.getParameter("mission_Gps_Lng"));
				// 任務開始時間 - null
				// 任務結束時間 - null
				Date date = new Date(System.currentTimeMillis());
				
				/**********驗證開始**********/
				if (misssion_Pay < 50.00) {
					errorMsg.add("安安積分太少了吧");
				}
				if (mission_Name==null || (mission_Name.trim()).length() == 0) {
					errorMsg.add("安安請告知任務名稱喔");
				}
				if (mission_Des == null || (mission_Des.trim()).length() == 0) {
					errorMsg.add("不給任務敘述是要我們怎麼幫你啊蛤");
				}
				// 日期驗證 - 格式
				try {
					mission_Due_Time = Date.valueOf((req.getParameter("mission_Due_Time").trim()));
				} catch (IllegalArgumentException e) {
					mission_Due_Time = new Date(System.currentTimeMillis());
					errorMsg.add("日期格式不對!");
				}
				// 日期驗證 - 值
				if (date.after(mission_Due_Time)) {
					errorMsg.add("你是要工具人做時光機逆");
				}
				// 錯誤訊息傳回
				if (!errorMsg.isEmpty()) {
					for (String string : errorMsg) {
						System.out.println(errorMsg);
					}
					req.setAttribute("getMissionVO", getMissionVO);
					RequestDispatcher inputError = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_normalmission.jsp");
					inputError.forward(req, res);
					return;
				}
				
				/**********準備寫入與轉向**********/

				GetMissionService getMissionService = new GetMissionService();
				getMissionService.addMission(mission_Category,mission_Name,mission_Des,issuer_Mem_No,null,null,mission_Due_Time, null, null,1,mission_Pattern,misssion_Pay,mission_Gps_Lat,mission_Gps_Lng);
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
		
	}
	

}
