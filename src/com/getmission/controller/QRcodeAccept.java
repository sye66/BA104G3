package com.getmission.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.mail.Message;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.getmission.model.GetMissionService;
import com.getmission.model.GetMissionVO;
import com.mchange.v2.async.StrandedTaskReporting;
import com.mem.model.MemVO;
import com.sun.org.apache.bcel.internal.generic.StackInstruction;

import jdk.nashorn.internal.runtime.regexp.joni.EncodingHelper;

public class QRcodeAccept extends HttpServlet {
	
	/**
	 * @author Sander
	 * 當doGet收到來自QRcode或是手動輸入後
	 * 將任務類別改變。
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		System.out.println(action);
		if ("input_By_QRcode".equals(action)) {
			List<String> errorMsgs = new LinkedList<>();
			request.setAttribute("errorMsgs", errorMsgs);
			// 接收傳來的name
			String decoding = request.getParameter("encodingmsg");
			System.out.println(decoding);
			
			// 接收對方傳來的任務與接案人參數
			String mission_No = null;
			String takecase_Mem_No = null;
			
			GetMissionService getMissionService = new GetMissionService();
			GetMissionVO getMissionVO = getMissionService.getOneMission(mission_No);
			
			// 驗證此接案人與資料庫任務內紀錄的接案人是否一致
			if (takecase_Mem_No.equals(getMissionVO.getTakecase_Mem_No())) {
				getMissionService.updateOneMissionStatus(mission_No, 4);
			} else {
				errorMsgs.add("與資料庫不一致");
				RequestDispatcher disqualify = request.getRequestDispatcher("/frontdesk/issuemission/issuemission_Pending.jsp");
				disqualify.forward(request, response);
				return;
			}			
		}
		if ("input_By_Type".equals(action)) {
			String validation = request.getParameter("validation");
			List<String> errorMsgs = new LinkedList<>();
			request.setAttribute("errorMsgs", errorMsgs);
			if (validation.length() != 23) {
				errorMsgs.add("驗證碼長度錯誤");
				System.out.println("驗證碼長度錯誤");
				RequestDispatcher disqualify = request.getRequestDispatcher("/frontdesk/issuemission/issuemission_Pending.jsp");
				disqualify.forward(request, response);
				return;
			}
			// mission_No 取前15字母
			String mission_No = (validation.trim()).substring(0, 16);
			// mem_No 取後16個字母
			String takecase_mem_No = (validation.trim()).substring(16, 23);
			// 測試mission_No是否有MISSION, 以防按到官方任務
			System.out.println(validation);
			System.out.println(mission_No);
			System.out.println(takecase_mem_No);
			
			if (mission_No.contains("MISSION")) {
				try {
					// 取出資料庫內的接案人
					GetMissionService getMissionService = new GetMissionService();
					GetMissionVO getMissionVO= getMissionService.getOneMission(mission_No);
					String db_takecase_Mem_No = getMissionVO.getTakecase_Mem_No();
					// 確定網頁傳來的接案人與資料庫內的接案人一致
					System.out.println(takecase_mem_No.equals(db_takecase_Mem_No));
					if (takecase_mem_No.equals(db_takecase_Mem_No)) {
						getMissionService.updateOneMissionStatus(mission_No, 4);
						RequestDispatcher confirmed = request.getRequestDispatcher("/frontdesk/mission/issuerfinalstep.jsp");
						confirmed.forward(request, response);
					} else { //與資料庫不一致
						errorMsgs.add("與資料庫不一致");
						System.out.println("與資料庫不一致");
						RequestDispatcher disqualify = request.getRequestDispatcher("/frontdesk/issuemission/issuemission_Pending.jsp");
						disqualify.forward(request, response);
						return;
					}
				} catch (Exception e) {
					errorMsgs.add("錯誤發生");
					System.out.println("錯誤發生");
					System.out.println(e.getMessage());
					RequestDispatcher disqualify = request.getRequestDispatcher("/frontdesk/issuemission/issuemission_Pending.jsp");
					disqualify.forward(request, response);
					return;
				}
			} else { // 非任務
				errorMsgs.add("非任務編號");
				System.out.println("非任務編號");
				RequestDispatcher disqualify = request.getRequestDispatcher("/frontdesk/issuemission/issuemission_Pending.jsp");
				disqualify.forward(request, response);
				return;
			}
		}
			
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
