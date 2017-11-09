package com.userskill.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.userskill.model.UserSkillService;
import com.userskill.model.UserSkillVO;

public class UserSkillServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		// TODO 查詢一筆資料(用戶輸入)
		/******************** 1.驗證資料 ********************/
		if ("get_skill".equals(action)) {
			List<String> errorMsgs = new LinkedList<>();
			request.setAttribute("errorMsgs", errorMsgs);
			
			try {				
				String strMEM = request.getParameter("MEM_NO");
				if (strMEM == null || (strMEM.trim()).length() == 0) {
					errorMsgs.add("No input");
				}
				if (!errorMsgs.isEmpty()) {
					// TODO 這裡要修改
					RequestDispatcher failView = request.getRequestDispatcher("/userskill/Index.jsp");
					failView.forward(request, response);
					return;
				}
				String strSkill = request.getParameter("SKILL_NO");
				if (strSkill == null || (strSkill.trim()).length() == 0) {
					errorMsgs.add("No input");
				}
				if (!errorMsgs.isEmpty()) {
					// TODO 這裡要修改
					RequestDispatcher failView = request.getRequestDispatcher("/userskill/Index.jsp");
					failView.forward(request, response);
					return;
				}
				/******************** 2.資料查詢 ********************/
				UserSkillService userSkillService = new UserSkillService();
				UserSkillVO userSkillVO = userSkillService.getOneSkill(strMEM, strSkill);
				if (userSkillVO == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					// TODO 這裡要修改
					RequestDispatcher failView = request.getRequestDispatcher("/userskill/Index.jsp");
					failView.forward(request, response);
					return;
				}
				
				/******************** 3.完成，轉交 ********************/
				request.setAttribute("userSkillVO", userSkillVO);
				RequestDispatcher successView = request.getRequestDispatcher("/userskill/Get_Skill.jsp");
				successView.forward(request, response);
				/******************** 4.其他錯誤處理 ********************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料，錯誤訊息：" + e.getMessage());
				// TODO 這裡要修改
				RequestDispatcher failView = request.getRequestDispatcher("/userskill/Index.jsp");
				failView.forward(request, response);
			}
		}
		

		// TODO 查詢所有資料
		// TODO 查詢後更新
		// TODO 查詢後刪除
		// TODO 直接更新
		// TODO 新增一筆資料
		
	}


}
