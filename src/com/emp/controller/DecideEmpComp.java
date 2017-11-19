package com.emp.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp.model.EmpVO;
import com.comp.model.*;


@WebServlet("/DecideEmpComp")
public class DecideEmpComp extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert".equals(action)){
		
		HttpSession session = req.getSession();
		EmpVO empVO = (EmpVO) session.getAttribute("empVO");
		String emp_No = empVO.getEmp_No();
		CompService compSvc = new CompService();
		List<CompVO> list = compSvc.getAllAuthNo(emp_No);
		for(CompVO compVO : list){
			System.out.println(compVO.getAuth_No());
		}
		}
	}
	
}
