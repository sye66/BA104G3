package com.artiReport.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.rowset.serial.SerialBlob;

import com.artiForm.model.ArtiFormService;
import com.artiForm.model.ArtiFormVO;
import com.artiReply.model.ArtiReplyService;
import com.artiReply.model.ArtiReplyVO;
import com.artiReport.model.ArtiReportService;
import com.artiReport.model.ArtiReportVO;

@MultipartConfig(fileSizeThreshold = 1024*1024, maxFileSize = 5*1024*1024, maxRequestSize = 5*5*1024*1024)
public class ArtiReportServlet extends HttpServlet {
	
	public void doGet (HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException{
		doPost(req, res);
		}
	
	public void doPost (HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException{
			
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		/******[ 取出ㄧ個展示 ]******/
		if("getOneReport_For_Display".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

//			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("report_No");
				if(str==null||(str.trim()).length()==0){
					errorMsgs.add(" 請輸入回覆文章編號 !!! ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReport/selectReport_page.jsp");
					failureView.forward(req, res);
					return;
				}

				String report_No = null;
				try{
					report_No = req.getParameter("report_No");
				} catch (Exception e){
					errorMsgs.add(" 回覆文章編號格式不正確 ");
				}

				/***************************2.開始查詢資料*****************************************/
				ArtiReportService artiReportSvc = new ArtiReportService ();
				ArtiReportVO artiReportVO = artiReportSvc.getOneArtiReport(report_No);

				if (artiReportVO==null){
					errorMsgs.add(" 查無資料 ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReport/selectReport_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("artiReportSet", artiReportVO);
				String url = "/backdesk/artiReport/listOneArtiReport_withSet.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e){
//				errorMsgs.add(" 無法取得資料 : "+ e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReport/selectReport_page.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		
		/******[ 後台取出ㄧ個展示 ]******/
		if("getOneReportFMback_For_Display".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String report_No = req.getParameter("report_No");
				if(report_No==null||(report_No.trim()).length()==0){
					errorMsgs.add(" 請輸入回覆文章編號 !!! ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReply/selectReport_page.jsp");
					failureView.forward(req, res);
					return;
				}

				String reply_No = null;
				try{
					reply_No = req.getParameter("report_No");
				} catch (Exception e){
					errorMsgs.add(" 回覆文章編號格式不正確 ");
				}

				/***************************2.開始查詢資料*****************************************/
				ArtiReportService artiReportSvc = new ArtiReportService ();
				ArtiReportVO artiReportVO = artiReportSvc.getOneArtiReport(report_No);
				if (artiReportVO==null){
					errorMsgs.add(" 查無資料 ");
				}
 
				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReply/selectReport_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("artiReportSet", artiReportVO);
				String url = "/backdesk/artiReport/listOneArtiReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得資料 : "+ e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReport/selectReport_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		/******[ 依文章編號取出 ]******/
		if ("listReport_ByArtiNo".equals(action)){

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數****************************************/
				HttpSession session = req.getSession();
				String arti_No = req.getParameter("arti_No");

				/***************************2.開始查詢資料****************************************/
				ArtiReportService artiReportSvc = new ArtiReportService();
				Set<ArtiReportVO> artiReportVO = artiReportSvc.findReportByArtiNo(arti_No);

				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artiReportSet", artiReportVO);
				String url = "/backdesk/artiReport/listOneArtiReport_withSet.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReport/selectReport_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 依文章分類取出 ]******/
		if ("listReport_ByArtiClsNo".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數****************************************/
				HttpSession session = req.getSession();
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));

				/***************************2.開始查詢資料****************************************/
				ArtiReportService artiReportSvc = new ArtiReportService();
				Set<ArtiReportVO> artiReportVO = artiReportSvc.findReportByArtiClsNo(arti_Cls_No);

				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artiReportSet", artiReportVO);
				String url = "/backdesk/artiReport/listOneArtiReport.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReport/selectReport_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 取出ㄧ個準備更新 ]******/
		if ("getOneReport_For_Update".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數****************************************/
				String report_No = req.getParameter("report_No");
				
				/***************************2.開始查詢資料****************************************/
				ArtiReportService artiReportSvc = new ArtiReportService();
				ArtiReportVO artiReportVO = artiReportSvc.getOneArtiReport(report_No);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artiReportSet", artiReportVO);
				String url = "/frontdesk/artiReport/update_ArtiReport_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReport/listAllArtiReport.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 更新 ]******/
		if("updateReport".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String reqestURL = req.getParameter("reqestURL");
			
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String report_No = req.getParameter("report_No");
			String mem_No = req.getParameter("mem_No");
			String arti_No = req.getParameter("arti_No");
			String report_Desc = req.getParameter("report_Desc");
			
			if (report_Desc == null||report_Desc.trim().length()==0){
				errorMsgs.add(" 回覆內容敘述請勿空白 ");
			}
			
			Timestamp nowTime = new Timestamp(System.currentTimeMillis());
			Timestamp report_Time = nowTime;
			
			Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));
			String report_Status = req.getParameter("report_Status");
			
			ArtiReportVO artiReportVO = new ArtiReportVO();
			
			artiReportVO.setReport_No(report_No);
			artiReportVO.setMem_No(mem_No);
			artiReportVO.setArti_No(arti_No);
			artiReportVO.setReport_Desc (report_Desc );
			artiReportVO.setReport_Time(report_Time);
			artiReportVO.setArti_Cls_No(arti_Cls_No);
			artiReportVO.setReport_Status(report_Status);
			
			if (!errorMsgs.isEmpty()){
				req.setAttribute("artiReportVO",artiReportVO);
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiReport/update_ArtiReport_input.jsp");

				failureView.forward(req, res);
				return;
			}
			
			/***************************2.開始修改資料*****************************************/
			ArtiReportService artiReportSvc = new ArtiReportService();
			artiReportVO = artiReportSvc.updateArtiReport(report_No,mem_No,arti_No,report_Desc,report_Time,arti_Cls_No,report_Status);

			/***************************3.修改完成,準備轉交(Send the Success view)*************/
			req.setAttribute("artiReportVO",artiReportVO);
			String url = "/backdesk/artiReport/listOneArtiReport.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);
		}
		
		if ("insertReport".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			String requestURL = req.getParameter("requestURL");
System.out.println("Report-server-111");
			try{
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/	
				HttpSession session = req.getSession();
System.out.println("Report-server-222");
				String mem_No = req.getParameter("mem_No").trim();
System.out.println(mem_No);
System.out.println(req.getSession().getAttribute("mem_No"));
System.out.println(req.getSession().getAttribute("arti_No"));
				if(req.getSession().getAttribute("mem_No")==null){
System.out.println(mem_No);
					String contextPath = getServletContext().getContextPath();
					errorMsgs.add("@@ 要麻煩請你先登入喔~");
					RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
					failuewView.forward(req, res);
					return;
				}
				
System.out.println("Report-server-333");
				String user = (String) req.getSession().getAttribute("mem_No");
System.out.println(user);

				if(!user.equals(mem_No)){
					String contextPath = getServletContext().getContextPath();
					errorMsgs.add(" = ___ = A 要本人才能刪除喔~");
					RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_men.jsp");
					failuewView.forward(req, res);
					return;
				}
System.out.println("Report-server-444");
				String arti_No = req.getParameter("arti_No").trim();			
				String report_Desc = req.getParameter("report_Desc").trim();
				
				if (report_Desc ==null||report_Desc.trim().length()==0){
					errorMsgs.add(" 回覆內容敘述請勿空白 ");
				}
				
				Timestamp nowTime = new Timestamp(System.currentTimeMillis());
				Timestamp report_Time = nowTime;
				
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));
				String report_Status = req.getParameter("report_Status");
				
				ArtiReportVO artiReportVO = new ArtiReportVO();
				
				artiReportVO.setMem_No(mem_No);
				artiReportVO.setArti_No(arti_No);
				artiReportVO.setReport_Desc (report_Desc );
				artiReportVO.setReport_Time(report_Time);
				artiReportVO.setArti_Cls_No(arti_Cls_No);
				artiReportVO.setReport_Status(report_Status);
System.out.println("Report-server-555");
				if (!errorMsgs.isEmpty()){
					req.setAttribute("artiReportVO", artiReportVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
					failureView.forward(req, res);
					return;
				}
System.out.println("Report-server-666");
				/***************************2.開始新增資料***************************************/
				ArtiReportService artiReportSvc = new ArtiReportService();
				artiReportVO = artiReportSvc.addArtiReport(mem_No, arti_No,report_Desc,report_Time,arti_Cls_No,report_Status);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("artiReportVo", artiReportVO);
				String url = "/backdesk/artiReport/listAllArtiReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
System.out.println("Report-server-777");
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(e.getMessage());
System.out.println("Report-server-888");
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("insertReport_4Reply".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			String requestURL = req.getParameter("requestURL");
			
			try{
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/	
				HttpSession session = req.getSession();

				String mem_No = (String) req.getSession().getAttribute("mem_No");
				String arti_No = req.getParameter("arti_No").trim();			
				String report_Desc = req.getParameter("report_Desc").trim();
				
				if (report_Desc ==null||report_Desc.trim().length()==0){
					errorMsgs.add(" 回覆內容敘述請勿空白 ");
				}
				
				Timestamp nowTime = new Timestamp(System.currentTimeMillis());
				Timestamp report_Time = nowTime;
				
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));
				String report_Status = req.getParameter("report_Status");
				
				ArtiReportVO artiReportVO = new ArtiReportVO();
				
				artiReportVO.setMem_No(mem_No);
				artiReportVO.setArti_No(arti_No);
				artiReportVO.setReport_Desc (report_Desc );
				artiReportVO.setReport_Time(report_Time);
				artiReportVO.setArti_Cls_No(arti_Cls_No);
				artiReportVO.setReport_Status(report_Status);
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("artiReportVO", artiReportVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ArtiReportService artiReportSvc = new ArtiReportService();
				artiReportVO = artiReportSvc.addArtiReport(mem_No, arti_No,report_Desc,report_Time,arti_Cls_No,report_Status);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("artiReportVo", artiReportVO);
				String url = "/backdesk/artiReport/listAllArtiReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 刪除 ]******/
		if ("deleteReport".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數***************************************/
				String report_No = req.getParameter("report_No");
				String mem_No = req.getParameter("mem_No");
				
				if(req.getSession().getAttribute("mem_No")==null){
					String contextPath = getServletContext().getContextPath();
					errorMsgs.add("@@ 要麻煩請你先登入喔~");
					RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
					failuewView.forward(req, res);
					return;
				}
				
				String user = (String) req.getSession().getAttribute("mem_No");
				if(!user.equals(mem_No)){
					String contextPath = getServletContext().getContextPath();
					errorMsgs.add(" = ___ = A 要本人才能刪除喔~");
					RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_men.jsp");
					failuewView.forward(req, res);
					return;
				}
			
				/***************************2.開始刪除資料***************************************/
				ArtiReportService artiReportSvc = new ArtiReportService();
				artiReportSvc.deleteArtiReport(report_No);

				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/backdesk/artiReport/listAllArtiReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 刪除回覆資料失敗 : " + e.getMessage());
				RequestDispatcher failuewView = req.getRequestDispatcher("/backdesk/artiReport/selectReport_page.jsp");
				failuewView.forward(req, res);
			}
		}
		
		
	}
}
