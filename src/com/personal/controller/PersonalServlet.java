package com.personal.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.achieve.model.AchieveService;
import com.achieve.model.AchieveVO;
import com.mem.model.*;
import com.getmission.model.*;
import com.ach_detail.model.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
@WebServlet("/PersonalServlet")
public class PersonalServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("onlyGetPic".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try{
				String str = req.getParameter("mem_No");
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/selectPersonalPage.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String mem_No = null;
				try{
					mem_No = new String(str);
				}catch (Exception e){
					errorMsgs.add("員工編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/selectPersonalPage.jsp");
					failureView.forward(req, res);
					return;
				}
				
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.getOneMem(mem_No);
				String mem_Pw = memVO.getMem_Pw();
System.out.println(mem_Pw);
				
System.out.println(mem_No);
System.out.println(memVO);
				
				if (memVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/selectPersonalPage.jsp");
					failureView.forward(req, res);
					return;
				}
				
				HttpSession session = req.getSession();
				session.setAttribute("memVO", memVO);
				String url = "/frontdesk/personal/PersonalPage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
				
			}catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/selectPersonalPage.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("personalMissionHistory".equals(action)) {
			System.out.println("121111111111111111111111");
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
System.out.println("121111111111111111111111");
			try{
				HttpSession session = req.getSession();
				MemVO memVO = (MemVO) session.getAttribute("memVO");
				String mem_No = memVO.getMem_No();
System.out.println(mem_No);
System.out.println("22222222222222222222");

				if (memVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/selectPersonalPage.jsp");
					failureView.forward(req, res);
					return;
				}
				
				session.setAttribute("memVO", memVO);
				String url = "/frontdesk/personal/PersonalMissionHistory.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
				
		
				}catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/selectPersonalPage.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if("personalachieve".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try{
				HttpSession session = req.getSession();
				MemVO memVO = (MemVO) session.getAttribute("memVO");
				String mem_No = memVO.getMem_No();
				Ach_DetailService ach_detailSvc = new Ach_DetailService();
				ach_detailSvc.getOneAch_Detail(mem_No).getAch_No();
				Ach_DetailVO ach_detailVO = new Ach_DetailVO();
				
				
				
			}catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/selectPersonalPage.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
