package com.comp.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comp.model.CompService;
import com.emp.model.EmpService;
import com.emp.model.EmpVO;


@WebServlet("/CompServlet")
public class CompServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String str = req.getParameter("emp_No");
				String[] list = req.getParameterValues("auth_No");
				
				String emp_No = new String(str);
	
				CompService compSvc = new CompService();
	
//				for(int i =0; i<list.length; i++)
	
					for(String auth_No : list){
					compSvc.addEmpComp(emp_No, auth_No);	
					}
	
	String url = "/backdesk/emp/select_page.jsp";
	RequestDispatcher successView = req.getRequestDispatcher(url);
	successView.forward(req, res);	
				
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/select_page.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
