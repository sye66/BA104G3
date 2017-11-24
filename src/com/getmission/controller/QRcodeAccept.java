package com.getmission.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.getmission.model.GetMissionService;
import com.getmission.model.GetMissionVO;
import com.mchange.v2.async.StrandedTaskReporting;

import jdk.nashorn.internal.runtime.regexp.joni.EncodingHelper;

public class QRcodeAccept extends HttpServlet {
	
	/**
	 * @author Sander
	 * 當doGet收到來自QRcode或是手動輸入後
	 * 將任務類別改變。
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
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
			RequestDispatcher disqualify = request.getRequestDispatcher("/frontdesk/issuemission/issuemission_Disqualify.jsp");
			disqualify.forward(request, response);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
