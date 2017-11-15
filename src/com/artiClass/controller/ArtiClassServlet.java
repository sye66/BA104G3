package com.artiClass.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.artiClass.model.ArtiClassService;
import com.artiForm.model.ArtiFormVO;

public class ArtiClassServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=utf-8");
//		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");

		    // 來自select_page.jsp的請求                                  // 來自 artiClass/listAllClass.jsp的請求     // 來自 artiReply/selectReply.jsp的請求
		if ("listArti_ByClass_No_A".equals(action) || "listArti_ByClass_No_B".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));

				/*************************** 2.開始查詢資料 ****************************************/
				ArtiClassService artiClassSvc = new ArtiClassService();
				Set<ArtiFormVO> set = artiClassSvc.getArti_NoByArti_Cls_No(arti_Cls_No);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listArti_ByClassNo", set);    // 資料庫取出的set物件,存入request

				String url = null;
				if ("listArti_ByClass_No_A".equals(action))
					url = "/backdesk/artiClass/listArti_ByClassNo.jsp";        // 成功轉交 artiClass/listArti_ByClassNo.jsp
				else if ("listArti_ByClass_No_B".equals(action))
					url = "/backdesk/artiClass/listAllClass.jsp";              // 成功轉交 artiClass/listAllClass.jsp
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		
		if ("delete_artiClass".equals(action)) { // 來自/dept/listAllDept.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));
				
				/***************************2.開始刪除資料***************************************/
				ArtiClassService artiClassSvc = new ArtiClassService();
				artiClassSvc.deleteArti_Cls_No(arti_Cls_No);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				String url = "/backdesk/artiClass/listAllClass.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後, 成功轉交 回到 /dept/listAllDept.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理***********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/backdesk/artiClass/listAllClass.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listArtiReply_ByClass_No".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));

				/*************************** 2.開始查詢資料 ****************************************/
				ArtiClassService artiClassSvc = new ArtiClassService();
				Set<ArtiFormVO> set = artiClassSvc.getArti_NoByArti_Cls_No(arti_Cls_No);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listArtiReply_ByClassNo", set);               // 資料庫取出的set物件,存入request
				String url = "/backdesk/artiReply/listAllArtiReply.jsp";    // 成功轉交 artiReply/listAllArtiReply.jsp

//				String url = null;
//				if ("listArtiReply_ByClass_No".equals(action))
//					url = "/backdesk/artiReply/listAllArtiReply.jsp";        // 成功轉交 artiReply/listAllArtiReply.jsp
//				else if ("listArti_ByClass_No_B".equals(action))
//					url = "/frontdesk/artiClass/listAllClass.jsp";              // 成功轉交 artiClass/listAllClass.jsp
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
	}
}
