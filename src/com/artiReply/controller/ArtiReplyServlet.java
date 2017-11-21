package com.artiReply.controller;

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

@MultipartConfig(fileSizeThreshold = 1024*1024, maxFileSize = 5*1024*1024, maxRequestSize = 5*5*1024*1024)
public class ArtiReplyServlet extends HttpServlet {
	
	public void doGet (HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException{
		doPost(req, res);
		}
	
	public void doPost (HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException{
			
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		/******[ 取出ㄧ個展示 ]******/
		if("getOneReply_For_Display".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("reply_No");
				if(str==null||(str.trim()).length()==0){
					errorMsgs.add(" 請輸入回覆文章編號 !!! ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReply/selectReply_page.jsp");
					failureView.forward(req, res);
					return;
				}

				String reply_No = null;
				try{
					reply_No = req.getParameter("reply_No");
				} catch (Exception e){
					errorMsgs.add(" 回覆文章編號格式不正確 ");
				}

				/***************************2.開始查詢資料*****************************************/
				ArtiReplyService artiReplySvc = new ArtiReplyService ();
				ArtiReplyVO artiReplyVO = artiReplySvc.getOneArtiReply(reply_No);
				if (artiReplyVO==null){
					errorMsgs.add(" 查無資料 ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm.jsp");
					failureView.forward(req, res);
					return;
				}

				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("artiReplyVO41", artiReplyVO);
				String url = "/frontdesk/artiReply/listOneArtiReply.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得資料 : "+ e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 後台取出ㄧ個展示 ]******/
		if("getOneReplyFMback_For_Display".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("reply_No");
				if(str==null||(str.trim()).length()==0){
					errorMsgs.add(" 請輸入回覆文章編號 !!! ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReply/selectReply_page.jsp");
					failureView.forward(req, res);
					return;
				}

				String reply_No = null;
				try{
					reply_No = req.getParameter("reply_No");
				} catch (Exception e){
					errorMsgs.add(" 回覆文章編號格式不正確 ");
				}

				/***************************2.開始查詢資料*****************************************/
				ArtiReplyService artiReplySvc = new ArtiReplyService ();
				ArtiReplyVO artiReplyVO = artiReplySvc.getOneArtiReply(reply_No);
				if (artiReplyVO==null){
					errorMsgs.add(" 查無資料 ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReply/selectReply_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("artiReplyVO41", artiReplyVO);
				String url = "/frontdesk/artiReply/listOneArtiReply.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得資料 : "+ e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReply/selectReply_page.jsp");
				failureView.forward(req, res);
			}
		}

		/******[ 依文章編號取出 ]******/
		if ("listReply_ByArtiNo".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數****************************************/
				HttpSession session = req.getSession();
				String arti_No = req.getParameter("arti_No");
				String arti_Cls_No = req.getParameter("arti_Cls_No");

				/***************************2.開始查詢資料****************************************/
				ArtiReplyService artiReplySvc = new ArtiReplyService();
				Set<ArtiReplyVO> artiReplyVO = artiReplySvc.findReplyByArtiNo(arti_No);

				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artiReplySet", artiReplyVO);
				session.setAttribute("arti_No", arti_No);
				session.setAttribute("arti_Cls_No", arti_Cls_No);
				String url = "/frontdesk/artiReply/listArtiReply_withSet.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReply/selectReply_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 依文章分類取出 ]******/
		if ("listReply_ByArtiClsNo".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數****************************************/
				HttpSession session = req.getSession();
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));

				/***************************2.開始查詢資料****************************************/
				ArtiReplyService artiReplySvc = new ArtiReplyService();
				Set<ArtiReplyVO> artiReplyVO = artiReplySvc.findReplyByArtiClsNo(arti_Cls_No);

				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artiReplySet", artiReplyVO);
				String url = "/frontdesk/artiReply/listArtiReply_withSet.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReply/selectReply_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 取出ㄧ個準備更新 ]******/
		if ("getOneReply_For_Update".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數****************************************/
				String reply_No = req.getParameter("reply_No");
				
				/***************************2.開始查詢資料****************************************/
				ArtiReplyService artiReplySvc = new ArtiReplyService();
				ArtiReplyVO artiReplyVO = artiReplySvc.getOneArtiReply(reply_No);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artiReplyVO41", artiReplyVO);
				String url = "/frontdesk/artiReply/update_ArtiReply_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 取出ㄧ個準備更新 ]******/
		if ("getOneReplyFMback_For_Update".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數****************************************/
				String reply_No = req.getParameter("reply_No");
				String arti_No =  (String) req.getSession().getAttribute("arti_No");

				/***************************2.開始查詢資料****************************************/
				ArtiReplyService artiReplySvc = new ArtiReplyService();
				ArtiReplyVO artiReplyVO = artiReplySvc.getOneArtiReply(reply_No);

				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artiReplyVO41", artiReplyVO);
				String url = "/frontdesk/artiReply/update_ArtiReply_input.jsp";
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOneReplyWithSet_For_Update".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數****************************************/
				HttpSession session = req.getSession();
//				String arti_No =  (String) req.getSession().getAttribute("arti_No");
				String arti_No = req.getParameter("arti_No");
				String reply_No = req.getParameter("reply_No");
				String mem_No = req.getParameter("mem_No");

				if(req.getSession().getAttribute("mem_No")==null){
					String contextPath = getServletContext().getContextPath();
					errorMsgs.add("@@ 要麻煩請你先登入喔~");
					RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
					failuewView.forward(req, res);
					return;
				}

				String user = (String)req.getSession().getAttribute("mem_No");

				if(!user.equals(mem_No)){
					String contextPath = getServletContext().getContextPath();
					errorMsgs.add(" = ___ = A 要本人才能修改喔~");
					RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_men.jsp");
					failuewView.forward(req, res);
					return;
				}

				/***************************2.開始查詢資料****************************************/
				ArtiReplyService artiReplySvc = new ArtiReplyService();
				ArtiReplyVO artiReplyVO = artiReplySvc.getOneArtiReply(reply_No);

				ArtiFormService artiFormSvc = new ArtiFormService ();
				ArtiFormVO artiFormVO = artiFormSvc.getOneArtiForm(arti_No);

				/***************************3.查詢完成,準備轉交(Send the Success view)************/

	            req.setAttribute("artiReplyVO41", artiReplyVO);
	            req.setAttribute("artiFormVO", artiFormVO);
	            session.setAttribute("arti_No", arti_No);
	            session.setAttribute("mem_No", mem_No);
	            String url = "/frontdesk/artiReply/update_ArtiReply_input.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);


				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 更新 ]******/
		if("updateReply".equals(action)){

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String reqestURL = req.getParameter("reqestURL");

			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
            HttpSession session = req.getSession();
			String reply_No = req.getParameter("reply_No");
			
			String mem_No = req.getParameter("mem_No");
			if(req.getSession().getAttribute("mem_No")==null){
				String contextPath = getServletContext().getContextPath();
				errorMsgs.add("@@ 要麻煩請你先登入喔~");
				RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiReply/listArtiReply_withSet_test.jsp");
				failuewView.forward(req, res);
				return;
			}
			
			String user = (String) req.getSession().getAttribute("mem_No");
			if(!user.equals(mem_No)){
				String contextPath = getServletContext().getContextPath();
				errorMsgs.add(" = ___ = A 要本人才能更新喔~");
				RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiReply/listArtiReply_withSet_test.jsp");
				failuewView.forward(req, res);
				return;
			}
			
			String arti_No = req.getParameter("arti_No");
			String reply_Desc = req.getParameter("reply_Desc");

			if (reply_Desc == null||reply_Desc.trim().length()==0){
				errorMsgs.add(" 回覆內容敘述請勿空白 ");
			}

			Timestamp nowTime = new Timestamp(System.currentTimeMillis());
			Timestamp reply_Time = nowTime;

			Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));
			
			ArtiReplyVO artiReplyVO = new ArtiReplyVO();

			artiReplyVO.setReply_No(reply_No);
			artiReplyVO.setMem_No(mem_No);
			artiReplyVO.setArti_No(arti_No);
			artiReplyVO.setReply_Desc (reply_Desc );
			artiReplyVO.setReply_Time(reply_Time);
			artiReplyVO.setArti_Cls_No(arti_Cls_No);

			if (!errorMsgs.isEmpty()){
				req.setAttribute("artiReplyVO41",artiReplyVO);
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiReply/update_ArtiReply_input.jsp");
				failureView.forward(req, res);
				return;
			}
			
			/***************************2.開始修改資料*****************************************/
			ArtiReplyService artiReplySvc = new ArtiReplyService();
			artiReplyVO = artiReplySvc.updateArtiReply(reply_No,mem_No,arti_No,reply_Desc,reply_Time,arti_Cls_No);
			
			ArtiFormService artiFormSvc = new ArtiFormService ();
			ArtiFormVO artiFormVO = artiFormSvc.getOneArtiForm(arti_No);

			/***************************3.查詢完成,準備轉交(Send the Success view)************/
            Set<ArtiReplyVO> artiReplyVO1 =  artiReplySvc.findReplyByArtiNo(arti_No);
            
            req.setAttribute("artiReplyVO41", artiReplyVO);
            req.setAttribute("artiFormVO", artiFormVO);
            session.setAttribute("arti_No", arti_No);
            session.setAttribute("mem_No", mem_No);
            String url = "/frontdesk/artiForm/listOneArtiForm.jsp";
            
			RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
			successView.forward(req, res);

			/***************************其他可能的錯誤處理**********************************/

		}
		
		if("updateReplyFMSet".equals(action)){

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String reqestURL = req.getParameter("reqestURL");

			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
            HttpSession session = req.getSession();
			String reply_No = req.getParameter("reply_No");
			String mem_No = req.getParameter("mem_No");
			
			if(req.getSession().getAttribute("mem_No")==null){
				String contextPath = getServletContext().getContextPath();
				errorMsgs.add("@@ 要麻煩請你先登入喔~");
				RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiReply/listArtiReply_withSet_test.jsp");
				failuewView.forward(req, res);
				return;
			}
			
			String user = (String) req.getSession().getAttribute("mem_No");
			if(!user.equals(mem_No)){
				String contextPath = getServletContext().getContextPath();
				errorMsgs.add(" = ___ = A 要本人才能更新喔~");
				RequestDispatcher failuewView = req.getRequestDispatcher("/rontdesk/artiReply/listArtiReply_withSet_test.jsp");
				failuewView.forward(req, res);
				return;
			}
			
			String arti_No = req.getParameter("arti_No");
			String reply_Desc = req.getParameter("reply_Desc");

			if (reply_Desc == null||reply_Desc.trim().length()==0){
				errorMsgs.add(" 回覆內容敘述請勿空白 ");
			}

			Timestamp nowTime = new Timestamp(System.currentTimeMillis());
			Timestamp reply_Time = nowTime;

			Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));
			
			ArtiReplyVO artiReplyVO = new ArtiReplyVO();
	
			artiReplyVO.setReply_No(reply_No);
			artiReplyVO.setMem_No(mem_No);
			artiReplyVO.setArti_No(arti_No);
			artiReplyVO.setReply_Desc (reply_Desc );
			artiReplyVO.setReply_Time(reply_Time);
			artiReplyVO.setArti_Cls_No(arti_Cls_No);

			if (!errorMsgs.isEmpty()){
				req.setAttribute("artiReplyVO41",artiReplyVO);
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiReply/update_ArtiReply_input.jsp");
				failureView.forward(req, res);
				return;
			}

			/***************************2.開始修改資料*****************************************/
			ArtiReplyService artiReplySvc = new ArtiReplyService();
			artiReplyVO = artiReplySvc.updateArtiReply(reply_No,mem_No,arti_No,reply_Desc,reply_Time,arti_Cls_No);

			/***************************3.修改完成,準備轉交(Send the Success view)*************/
			req.setAttribute("artiReplyVO41",artiReplyVO);
			
			String url = "/frontdesk/artiReply/listOneArtiReply.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);

		}

		
		if ("insertReply".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			String requestURL = req.getParameter("requestURL");

			try{
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/	
				HttpSession session = req.getSession();

				String mem_No = req.getParameter("mem_No").trim();
				System.out.println(session.getAttribute("mem_No"));
				if(req.getSession().getAttribute("mem_No")==null){
				System.out.println("inserReply");
					String contextPath = getServletContext().getContextPath();
					errorMsgs.add("@@ 要麻煩請你先登入喔~");
					RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
					failuewView.forward(req, res);
					return;
				}
//				Integer arti_Cls_No =  Integer.valueOf(req.getParameter("arti_Cls_No"));
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));
				String arti_No = req.getParameter("arti_No").trim();
				String reply_Desc = req.getParameter("reply_Desc").trim();

				if (reply_Desc ==null||reply_Desc.trim().length()==0){
					errorMsgs.add(" 回覆內容敘述請勿空白 ");
				}

				Timestamp nowTime = new Timestamp(System.currentTimeMillis());
				Timestamp reply_Time = nowTime;

				ArtiReplyVO artiReplyVO = new ArtiReplyVO();
				artiReplyVO.setMem_No(mem_No);
				artiReplyVO.setArti_No(arti_No);
				artiReplyVO.setReply_Desc(reply_Desc);
				artiReplyVO.setReply_Time(reply_Time);
				artiReplyVO.setArti_Cls_No(arti_Cls_No);
		
				if (!errorMsgs.isEmpty()){
					req.setAttribute("artiReplyVO", artiReplyVO);

					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
					failureView.forward(req, res);
					return;
				}

				/***************************2.開始新增資料***************************************/
				ArtiReplyService artiReplySvc = new ArtiReplyService();
				artiReplyVO = artiReplySvc.addArtiReply(mem_No, arti_No,reply_Desc,reply_Time,arti_Cls_No);
				
				ArtiFormService artiFormSvc = new ArtiFormService ();
				ArtiFormVO artiFormVO = artiFormSvc.getOneArtiForm(arti_No);

				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("artiReplyVO41", artiReplyVO);
				req.setAttribute("artiFormVO", artiFormVO);
				req.getSession().setAttribute("arti_No", arti_No);
				req.getSession().setAttribute("mem_No", mem_No);
				String url = "/frontdesk/artiForm/listOneArtiForm.jsp";

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
		if ("deleteReply".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數***************************************/
				HttpSession session = req.getSession();
				String arti_No = (String) req.getSession().getAttribute("arti_No");
				String reply_No = req.getParameter("reply_No");
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));
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
				ArtiReplyService artiReplySvc = new ArtiReplyService();
				artiReplySvc.deleteArtiReply(reply_No, mem_No);
				
				ArtiFormService artiFormSvc = new ArtiFormService ();
				ArtiFormVO artiFormVO = artiFormSvc.getOneArtiForm(arti_No);

				/***************************3.刪除完成,準備轉交(Send the Success view)***********/	
				ArtiReplyVO artiReplyVO = new ArtiReplyVO();
	            Set<ArtiReplyVO> artiReplyVO1 =  artiReplySvc.findReplyByArtiNo(arti_No);
	            
	            req.setAttribute("artiReplyVO41", artiReplyVO);
	            req.setAttribute("artiFormVO", artiFormVO);
	            session.setAttribute("arti_No", arti_No);
	            session.setAttribute("mem_No", mem_No);
	            String url = "/frontdesk/artiForm/listOneArtiForm.jsp";
	            
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 刪除回覆資料失敗 : " + e.getMessage());
				RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
				failuewView.forward(req, res);
			}
		}
		
		/******[ 後台刪除 ]******/
		if ("deleteReplyFMBack".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數***************************************/
				HttpSession session = req.getSession();
				String reply_No = req.getParameter("reply_No");
				String mem_No = req.getParameter("mem_No");

				/***************************2.開始刪除資料***************************************/
				ArtiReplyService artiReplySvc = new ArtiReplyService();
				artiReplySvc.deleteArtiReply(reply_No, mem_No);

				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/backdesk/artiReply/listAllArtiReply.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 刪除回覆資料失敗 : " + e.getMessage());
				RequestDispatcher failuewView = req.getRequestDispatcher("/backdesk/artiReply/selectReply_page.jsp");
				failuewView.forward(req, res);
			}
		}
	}
}
