package com.getmission.controller;

import java.io.*;
import java.security.Key;
import java.sql.Timestamp;
import java.util.*;
import java.sql.Date;
import java.sql.Time;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import javax.swing.plaf.synth.SynthSeparatorUI;
import javax.websocket.Session;

import org.apache.catalina.connector.Request;
import org.hibernate.hql.ast.SqlASTFactory;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.omg.CORBA.BAD_TYPECODE;

import com.a.a.a.g.m.l;
import com.accusecase.model.*;
import com.casecandidate.model.*;
import com.emp.model.EmpService;
import com.emp.model.EmpVO;
import com.getmission.model.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.getmission.controller.MailService;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.missionimages.model.MissionImagesService;
import com.sun.corba.se.spi.orb.StringPair;
import com.sun.corba.se.spi.orbutil.fsm.Input;
import com.sun.org.apache.bcel.internal.generic.StackInstruction;
import com.tool.controller.TelMessage;

import sun.util.resources.cldr.aa.CalendarData_aa_ER;
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class GetMissionServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
		
				
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("");
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
		JSONObject obj = new JSONObject();

		if ("listmission_ByCompositeQuery".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			MemVO memVO = (MemVO) req.getSession().getAttribute("memVO");
			req.setAttribute("errorMsgs", errorMsgs);
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
			/************ 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("listmission_ByCompositeQuery", list);
			RequestDispatcher successView = null;
			if (memVO == null) {
				successView = req.getRequestDispatcher("/frontdesk/getmission/getMissionSearch.jsp"); // 成功轉交getMissionSearch.jsp
			} else {
				successView = req.getRequestDispatcher("/frontdesk/getmission/getMissionSearchlogin.jsp"); // 成功轉交getMissionSearchlogin.jsp
			}
			successView.forward(req, res);
		}

		if ("mission_Detail".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL");

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
				req.setAttribute("getMissionVO", getMissionVO);
				String url = null;
				if (memVO == null) {
					url = "/frontdesk/getmission/missionDetail.jsp";
				} else {
					url = "/frontdesk/getmission/missionDetaillogin.jsp";
				}

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ************************************/
			} catch (Exception e) {
				errorMsgs.add("資料取出時失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}

		if ("take_mission".equals(action)) { // 來自getmission.jsp或mission_Detail的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑:
																// 可能為【/getmission/getmission.jsp】
																// 或
																// 【/getmission/mission_Detail.jsp】
			/***************************
			 * 1.接收請求參數 - 輸入格式的錯誤處理
			 **********************/

			MemVO memVO = (MemVO) req.getSession().getAttribute("memVO");
			if (memVO == null) {
				errorMsgs.add("請登入再來喔");
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);

				return;
			} else if (memVO.getMem_State() == 0) {
				errorMsgs.add("請驗證再來喔");
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);

				return;
			}

			String mission_No = req.getParameter("mission_No").trim();
			GetMissionService getMissionSvc = new GetMissionService();
			GetMissionVO getMissionVO = new GetMissionVO();
			Integer mission_State = getMissionSvc.getOneMission(mission_No).getMission_State();

			CaseCandidateService CaseCandidateSvc = new CaseCandidateService();

			if (!getMissionSvc.getOneMission(mission_No).getIssuer_Mem_No().equals(memVO.getMem_No())) {
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
			// 發案人的MemVO
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

			String takecase_Mem_No = (String) req.getParameter("takecase_Mem_No").trim();
			String mission_No = (String) req.getParameter("mission_No").trim();
			GetMissionVO getMissionVO = new GetMissionVO();
			GetMissionService getMissionSvc = new GetMissionService();
			getMissionVO = getMissionSvc.getOneMission(mission_No);
			AccuseCaseService accuseCaseService = new AccuseCaseService();
			List<AccuseCaseVO> accuseCaseList = accuseCaseService.getCaseBymission(mission_No);
			
			
			/**
			 * @author Sander
			 * 送信功能加入，當發案人確認接案人之後傳送密碼給接案人。
			 * @param to 			對方email位置
			 * @param subject 		主題
			 * @param messageText	內容
			 * 驗證碼為任務編號 + 發案人編號
			 */
			
			MemService memService = new MemService();
			MemVO takeCase_MemVO = memService.getOneMem(takecase_Mem_No);
			MailService mailService = new MailService();
			// 接案人的email
			String to = takeCase_MemVO.getMem_Email();
			// 主旨:接案人姓名 + 任務編號
			String subject = String.format("恭喜%s! 您已成為任務編號:%s 之接案人!", takeCase_MemVO.getMem_Name(),
											mission_No);
			// 驗證碼
			String messageText = String.format("您的接案任務驗證碼為: %s%s", mission_No,takeCase_MemVO.getMem_No());
			mailService.sendMail(to, subject, messageText);
			
			/**
			 * @author Sander
			 * 簡訊功能加入，當發案人確認接案人之後傳送密碼給接案人。
			 * 
			 */
			String[] tel = {takeCase_MemVO.getMem_Pho()};
			TelMessage telMessage = new TelMessage();
			telMessage.sendMessage(tel, messageText);
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
			MissionSocket.pushMissionText(takecase_Mem_No,"checkmem"); //websocket
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
			}else if (memVO.getMem_State() == 0) {
					errorMsgs.add("請驗證再來喔");
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
			}else if (memVO.getMem_State() == 0) {
					errorMsgs.add("請驗證再來喔");
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
			}else if (memVO.getMem_State() == 0) {
					errorMsgs.add("請驗證再來喔");
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
			}else if (memVO.getMem_State() == 0) {
					errorMsgs.add("請驗證再來喔");
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
				
					MissionSocket.pushMissionText(takecase_Mem_No,"missionOk"); //websocket
					
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
			
			MemService memSvc = new MemService();
			GetMissionService getMissionSvc = new GetMissionService();
			String to = memVO.getMem_Email();
		      
		    String subject = "任務完成通知";//傳 mail
		      
		    String issuer_Name = memSvc.getOneMem(getMissionSvc.getOneMission(mission_No).getIssuer_Mem_No()).getMem_Id();
		    String takecase_Mem_No = memVO.getMem_Id();
		    String mission_Name = getMissionSvc.getOneMission(mission_No).getMission_Name();
		    String messageText = "Hello! " + issuer_Name + " 您所發的任務, ["+mission_Name +"]~ \n" +takecase_Mem_No+
		    					 " 已經完成囉~請快快去查驗吧~"; 
		    
		    System.out.println(messageText);
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
			MissionSocket.pushMissionText(getMissionSvc.getOneMission(mission_No).getIssuer_Mem_No(),"finishwork"); //websocket
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
			}else if (memVO.getMem_State() == 0) {
					errorMsgs.add("請驗證再來喔");
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
		
		if("getmissionmap".equals(action)){
			List<String> errorMsg = new LinkedList<>();
			req.setAttribute("errorMsg", errorMsg);
			System.out.println("getmission");
			Gson gson=  new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			String jsonStr = "";
			
			GetMissionService getMissionSvc = new GetMissionService();
			List<GetMissionVO> list = getMissionSvc.getAllValidMission();
			jsonStr = gson.toJson(list);
			String json = new Gson().toJson(list);
			
			System.out.println(jsonStr);
			try {
				
				obj.put("jsonStr", jsonStr);
			} catch (JSONException e) {
				e.printStackTrace();
			}
			res.getWriter().write(json);
			res.setContentType("Application/json");
			res.setCharacterEncoding("UTF-8");
//			out = res.getWriter();
			out.flush();
			out.close();
			
		}
		
		/**
		 * @author Sander 新增一般任務，積分五十點。
		 */
		// 任務類別
		if ("issue_Normal_Mission".equals(action)) {

			// Value Receiving Test
			System.out.println("got post from issuemission");

			// 錯誤處理
			List<String> errorMsgs = new LinkedList<>();
			req.setAttribute("errorMsgs", errorMsgs);
			GetMissionVO getMissionVO = new GetMissionVO();

			try {
				// 任務類別
				String mission_Category = req.getParameter("mission_Category");
				// 任務名稱
				String mission_Name = req.getParameter("mission_Name");
				// 任務敘述
				String mission_Des = req.getParameter("mission_Des");
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
				// 任務圖片
				Part pic = req.getPart("mission_images");

				/********** 驗證開始 **********/
				if (mission_Pay != 50.00) {
					errorMsgs.add("HTML的READONLY就是叫你不要改啦");
				}
				if (mission_Name == null || (mission_Name.trim()).length() == 0) {
					errorMsgs.add("安安請告知任務名稱喔");
				}
				if (mission_Des == null || (mission_Des.trim()).length() == 0) {
					errorMsgs.add("不給任務敘述是要我們怎麼幫你啊蛤");
				}
				// 錯誤訊息傳回
				if (!errorMsgs.isEmpty()) {
					for (String string : errorMsgs) {
						System.out.println(string);
					}
					req.setAttribute("getMissionVO", getMissionVO);
					RequestDispatcher inputError = req
							.getRequestDispatcher("/frontdesk/issuemission/issuemission_normalmission.jsp");
					inputError.forward(req, res);
					return;
				}

				/********** 儲值驗證，不夠就轉向積分不足頁面，再轉儲值或是發任務頁面 **********/
				MemService memService = new MemService();
				MemVO memVO = memService.getOneMem(issuer_Mem_No);
				if (memVO.getMem_Point() < mission_Pay) {
					RequestDispatcher NotEnoughPoint = req
							.getRequestDispatcher("/frontdesk/issuemission/issuemission_Failed_NotEnough.jsp");
					NotEnoughPoint.forward(req, res);
					return;
				}
				/********** 圖片驗證，沒有圖片就回傳NULL **********/
				byte[] byteArrPic = null;
				if (pic != null) {
					System.out.println("pic不為空值，開啟Input Stream");
					InputStream inputStream = pic.getInputStream();
					byteArrPic = new byte[inputStream.available()];
					System.out.println(byteArrPic.length);
					inputStream.read(byteArrPic);
					inputStream.close();
				} else {
					System.out.println("==============pic為空值，開啟Input Stream==============");
				}

				/********** 準備寫入與轉向 **********/
				// 任務截止時間加工
				// 開始後五天為截止，看起來DAO沒辦法改了。在此手動加五天
				Calendar calendar = Calendar.getInstance();
				// 以現在的時間點創建(任務建立時間點)
				calendar.setTimeInMillis(System.currentTimeMillis());
				// 加五天
				calendar.add(calendar.DAY_OF_MONTH, 5);
				// 第一次getTime()是Date, 第二次getTime()是Timestamp
				mission_Due_Time = new Timestamp(calendar.getTime().getTime());
				System.out.println(mission_Due_Time);

				GetMissionService getMissionService = new GetMissionService();
				String key = getMissionService.addMissionReturnKey(mission_Category, mission_Name, mission_Des,
						issuer_Mem_No, null, null, mission_Due_Time, null, null, 1, mission_Pattern, mission_Pay,
						mission_Gps_Lat, mission_Gps_Lng);

				MissionImagesService missionImagesService = new MissionImagesService();
				missionImagesService.addMissionImages(key, issuer_Mem_No, byteArrPic);
				memService.DecreaseMemPoint(issuer_Mem_No, mission_Pay.intValue());
				System.out.println("新增一般任務，會員: " + issuer_Mem_No);

				RequestDispatcher successView = req
						.getRequestDispatcher("/frontdesk/issuemission/issuemission_Success.jsp");
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				System.out.println(e.getMessage());
				RequestDispatcher inputError = req
						.getRequestDispatcher("/frontdesk/issuemission/issuemission_normalmission.jsp");
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
			List<String> errorMsgs = new LinkedList<>();
			req.setAttribute("errorMsgs", errorMsgs);
			GetMissionVO getMissionVO = new GetMissionVO();
			String key;
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
				// 任務圖片
				Part pic = req.getPart("mission_images");
				
				/**********驗證開始**********/
				if (mission_Pay < 100.00) {
					errorMsgs.add("安安積分太少了吧");
				}
				if (mission_Name==null || (mission_Name.trim()).length() == 0) {
					errorMsgs.add("安安請告知任務名稱喔");
				}
				if (mission_Des == null || (mission_Des.trim()).length() == 0) {
					errorMsgs.add("不給任務敘述是要我們怎麼幫你啊蛤");
				}
				
				// 錯誤訊息傳回
				if (!errorMsgs.isEmpty()) {
					for (String string : errorMsgs) {
						System.out.println(errorMsgs);
					}
					req.setAttribute("getMissionVO", getMissionVO);
					RequestDispatcher inputError = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_emergencymission.jsp");
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
				/**********圖片驗證**********/
				byte[] byteArrPic = null;
				if (pic != null) {
					InputStream inputStream = pic.getInputStream();
					byteArrPic = new byte[inputStream.available()];
					inputStream.read(byteArrPic);
					inputStream.close();
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
				key = getMissionService.addMissionReturnKey(mission_Category,mission_Name,mission_Des,issuer_Mem_No,null,null,mission_Due_Time, null, null,1,mission_Pattern,mission_Pay,mission_Gps_Lat,mission_Gps_Lng);
				MissionImagesService missionImagesService = new MissionImagesService();
				missionImagesService.addMissionImages(key, issuer_Mem_No, byteArrPic);
				memService.DecreaseMemPoint(issuer_Mem_No, mission_Pay.intValue());
				System.out.println("新增一般任務，會員: " + issuer_Mem_No);
				RequestDispatcher successView = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_Success.jsp");
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				System.out.println(e.getMessage());
				RequestDispatcher inputError = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_emergencymission.jsp");
				inputError.forward(req, res);
			}	
		}
		/**
		 * @author Sander
		 * @param issue_mission_to_takecase
		 * @param takecase_Mem_No
		 * 直接發任務給接案人
		 * 要注意新增接案候選人，值來自於jsp上調用得VO，多設定一個hidden傳過來
		 */
		// 任務類別
		if ("issue_mission_to_takecase".equals(action)) {
			
			// Value Receiving Test
			System.out.println("-----------直接發案開始-----------");
			System.out.println("got post from takecase");
			
			// 錯誤處理
			List<String> errorMsgs = new LinkedList<>();
			req.setAttribute("errorMsgs", errorMsgs);
			GetMissionVO getMissionVO = new GetMissionVO();
			String key = null;
			String takecase_Mem_No = req.getParameter("takecase_Mem_No");
			System.out.println("指定接案人: " + takecase_Mem_No);
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
				Part pic = req.getPart("mission_images");
				/**********驗證開始**********/
				if (mission_Pay < 100.00) {
					errorMsgs.add("安安積分太少了吧");
				}
				if (mission_Name==null || (mission_Name.trim()).length() == 0) {
					errorMsgs.add("安安請告知任務名稱喔");
				}
				if (mission_Des == null || (mission_Des.trim()).length() == 0) {
					errorMsgs.add("不給任務敘述是要我們怎麼幫你啊蛤");
				}

				// 錯誤訊息傳回
				if (!errorMsgs.isEmpty()) {
					for (String string : errorMsgs) {
						System.out.println(errorMsgs);
					}
					req.setAttribute("getMissionVO", getMissionVO);
					RequestDispatcher inputError = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_takecasemission.jsp");
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
				/**********圖片驗證**********/
				byte[] byteArrPic = null;
				if (pic != null) {
					InputStream inputStream = pic.getInputStream();
					byteArrPic = new byte[inputStream.available()];
					inputStream.read(byteArrPic);
					inputStream.close();
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

				// 調用取得自增主鍵的新增方法
				GetMissionService getMissionService = new GetMissionService();
				key = getMissionService.addMissionReturnKey(mission_Category,mission_Name,mission_Des,issuer_Mem_No,null,null,mission_Due_Time, null, null,1,mission_Pattern,mission_Pay,mission_Gps_Lat,mission_Gps_Lng);
				MissionImagesService missionImagesService = new MissionImagesService();
				missionImagesService.addMissionImages(key, issuer_Mem_No, byteArrPic);
				System.out.println(key);
				// 扣除積分
				memService.DecreaseMemPoint(issuer_Mem_No, mission_Pay.intValue());
				// 加入接案候選人，設定狀態(2) 發案人邀請接案
				CaseCandidateService caseCandidateService = new CaseCandidateService();
				caseCandidateService.addCaseCandidate(takecase_Mem_No, key, 2);
				
				System.out.println("直接發案，會員: " + issuer_Mem_No);
				RequestDispatcher successView = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_Success.jsp");
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				System.out.println(e.getMessage());
				RequestDispatcher inputError = req.getRequestDispatcher("/frontdesk/issuemission/issuemission_takecasemission.jsp");
				inputError.forward(req, res);
			}	
		}
		if("get_Location_Json".equals(action)) {
			System.out.println("get_Location_Json");
			String resJson = "";
			Gson tranformer = new Gson();
			MemService memService = new MemService();
			List<MemVO> listGetAllMem = memService.getAll();
			JSONObject jsonObject;
			JSONArray jsonarr = new JSONArray();
			for (MemVO memVO : listGetAllMem) {
				try {
					jsonObject = new JSONObject();
					String mem_No = memVO.getMem_No();
					System.out.println(mem_No);
					String mem_Id = memVO.getMem_Id();
					Double mem_GPS_LAT = memVO.getMem_Gps_Lat();
					Double mem_GPS_LNG = memVO.getMem_Gps_Lng();
					Double[] GPS = {mem_GPS_LAT,mem_GPS_LNG};
					jsonObject.put("mem_No", mem_No);
					jsonObject.put("mem_GPS_LAT", mem_GPS_LAT);
					jsonObject.put("mem_GPS_LNG", mem_GPS_LNG);
					jsonarr.put(jsonObject);
				} catch (JSONException e) {
					e.printStackTrace();
				}
				
			}
			System.out.println(jsonarr);
			resJson = tranformer.toJson(jsonarr);
			PrintWriter printer = res.getWriter();
			printer.println(jsonarr);
			System.out.println("寫出json成功");
		}
	}
}
