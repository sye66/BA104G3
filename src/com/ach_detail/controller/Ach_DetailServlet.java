package com.ach_detail.controller;

import java.io.IOException;
import java.util.ArrayList;
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

import com.ach_detail.model.Ach_DetailService;
import com.ach_detail.model.Ach_DetailVO;
import com.achieve.model.AchieveService;
import com.achieve.model.AchieveVO;
import com.mem.model.MemVO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
@WebServlet("/Ach_DetailServlet")
public class Ach_DetailServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
//		HttpSession session = req.getSession();
//		session.getAttribute("mem_No");
		if ("getOne_For_Display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("mem_No");

//				session.setAttribute("mem_No", str);
				
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/ach_detail/selectAch_Detail_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String mem_No = null;
				try {
					mem_No = new String(str);
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/ach_detail/selectAch_Detail_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料*****************************************/

				Ach_DetailService ach_DetailSvc = new Ach_DetailService();
				List<Ach_DetailVO> list = ach_DetailSvc.getPersonal(mem_No);
				
//				Ach_DetailService ach_DetailSvc = new Ach_DetailService();
//				Ach_DetailVO ach_detailVO = ach_DetailSvc.getOneAch_Detail(mem_No);	
		

				if (list == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/ach_detail/selectAch_Detail_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/

				req.setAttribute("list", list);			
				String url = "/frontdesk/ach_detail/listOneAch_Detail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/ach_detail/selectAch_Detail_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getAchieve".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("getAchieve");
				
				
				
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/ach_detail/selectAch_Detail_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String mem_No = null;
				try {
					mem_No = new String(str);
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/ach_detail/selectAch_Detail_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料*****************************************/
				Ach_DetailService ach_DetailSvc = new Ach_DetailService();
				Ach_DetailVO ach_DetailVO = ach_DetailSvc.getOneAch_Detail(mem_No);
				if (ach_DetailVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontdesk/ach_detail/selectAch_Detail_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ach_DetailVO", ach_DetailVO); 
				String url = "/frontdesk/ach_detail/listOneAch_Detail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontdesk/ach_detail/selectAch_Detail_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("achieve_Detail".equals(action)){
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
 			try{
 				List<AchieveVO> achieveVO = new LinkedList<AchieveVO>();
 				MemVO memVO = (MemVO) req.getSession().getAttribute("memVO");
 				String mem_No = memVO.getMem_No();
 				Ach_DetailService achdSvc = new Ach_DetailService();
 				List<Ach_DetailVO> ach_detailVO = achdSvc.getPersonal(mem_No);

 				
 				AchieveService achieveSvc = new AchieveService();
 				for(int i =0;i < ach_detailVO.size();i++){
 					achieveVO.add(achieveSvc.getOneAchieve(ach_detailVO.get(i).getAch_No()));
 				}
 				
 				req.setAttribute("achieveVO", achieveVO);
 				req.setAttribute("ach_detailVO", ach_detailVO);
 System.out.println(achieveVO+"++++++++++++++++++");
 				String url = "/frontdesk/personal/personalAchieve.jsp";
 				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
 
 				
 			}catch (Exception e) {
				String url = "/frontdesk/personal/PersonalPage.jsp";
				RequestDispatcher failureView = req.getRequestDispatcher(url);
				failureView.forward(req, res);
			}
		}
	}
}
