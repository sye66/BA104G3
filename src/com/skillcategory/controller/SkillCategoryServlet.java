package com.skillcategory.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.skillcategory.model.SkillCategoryService;
import com.skillcategory.model.SkillCategoryVO;

public class SkillCategoryServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("GET, Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("POST, Served at: ").append(request.getContextPath());
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		
		if ("get_one_skill_category".equals(action)) {
			List<String> errorMsgs = new LinkedList<>();
			request.setAttribute("errorMsgs", errorMsgs);
			try {
				String str = request.getParameter("SKILL_CATE_NO");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("No input");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failView = request.getRequestDispatcher("/skillcategory/Index.jsp");
					failView.forward(request, response);
					return;
				}
				
				SkillCategoryService SKService = new SkillCategoryService();
				SkillCategoryVO SKVO = SKService.getOneSkillCate(str);
				if (SKVO == null) {
					errorMsgs.add("No Data");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failView = request.getRequestDispatcher("/skillcategory/Index.jsp");
					failView.forward(request, response);
					return;
				}
				request.setAttribute("Skill_Category_VO", SKVO);
				RequestDispatcher successView = request.getRequestDispatcher("skillcategory/get_one.jsp");
				successView.forward(request, response);
			} catch (Exception e) {
				errorMsgs.add("Can't get data from DB, Error Messege: " + e.getMessage());
				RequestDispatcher failView = request.getRequestDispatcher("/skillcategory/Index.jsp");
				failView.forward(request, response);
			}
		}
	}

}
