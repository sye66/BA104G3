package com.artiForm.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.rowset.serial.SerialBlob;

import com.artiClass.model.ArtiClassService;
import com.artiForm.model.ArtiFormDAO;
import com.artiForm.model.ArtiFormService;
import com.artiForm.model.ArtiFormVO;
import com.artiReply.model.ArtiReplyService;
import com.artiReply.model.ArtiReplyVO;

@MultipartConfig(fileSizeThreshold = 1024*1024, maxFileSize = 5*1024*1024, maxRequestSize = 5*5*1024*1024)
public class ArtiFormServlet extends HttpServlet {
	
	public void doGet (HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException{
		doPost(req, res);
		}
	
	public void doPost (HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException{
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		/******[ 前台取出ㄧ個展示 ]******/
		if("jumpOne_For_Display".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				HttpSession session = req.getSession();
				String mem_No =req.getParameter("mem_No");
				
				String str = req.getParameter("arti_No");
				if(str==null||(str.trim()).length()==0){
					errorMsgs.add(" 請輸入主題文章編號 !!! ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listAllArtiForm.jsp");
					failureView.forward(req, res);
					return;
				}

				String arti_No = null;
				try{
					arti_No = req.getParameter("arti_No");
				} catch (Exception e){
					errorMsgs.add(" 主題文章編號格式不正確 ");
				}
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No"));
				String reply_No = null;

				/***************************2.開始查詢資料*****************************************/
				ArtiFormService artiFormSvc = new ArtiFormService ();
				ArtiFormVO artiFormVO = artiFormSvc.getOneArtiForm(arti_No);
				
//				ArtiReplyService artiReplySvc = new ArtiReplyService ();
//				ArtiReplyVO artiReplyVO = artiReplySvc.getOneArtiReply(reply_No);

				if (artiFormVO==null){
					errorMsgs.add(" 查無資料 ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listAllArtiForm.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
//				session.setAttribute("artiReplyVO", artiReplyVO);
				req.getSession().setAttribute("artiFormVO", artiFormVO);
				req.setAttribute("arti_No", arti_No);
//				req.setAttribute("mem_No", mem_No);
//	            req.getSession().setAttribute("arti_No", arti_No);
				req.getSession().setAttribute("mem_No", mem_No);

				String url = "/frontdesk/artiForm/listOneArtiForm.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
                return;
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得資料 : "+ e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listAllArtiForm.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 後台取出ㄧ個展示 ]******/
		if("getOneArti_For_Back".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				HttpSession session = req.getSession();
				String str = req.getParameter("arti_No");
				if(str==null||(str.trim()).length()==0){
					errorMsgs.add(" 請輸入主題文章編號 !!! ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiForm/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				String arti_No = null;
				try{
					arti_No = req.getParameter("arti_No");
				} catch (Exception e){
					errorMsgs.add(" 主題文章編號格式不正確 ");
				}
				

				/***************************2.開始查詢資料*****************************************/
				ArtiFormService artiFormSvc = new ArtiFormService ();
				ArtiFormVO artiFormVO = artiFormSvc.getOneArtiForm(arti_No);
				
				if (artiFormVO==null){
					errorMsgs.add(" 查無資料 ");
				}

				if(!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiForm/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("artiFormVO", artiFormVO);
				req.setAttribute("arti_No", arti_No);

				String url = "/backdesk/artiForm/listOneArtiForm_back.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得資料 : "+ e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiForm/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 依文章編號取出 ]******/
		if ("listArti_BySearch".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數****************************************/
				HttpSession session = req.getSession();
				String describe = req.getParameter("describe");

				if(describe==null||(describe.trim()).length()==0){
					errorMsgs.add(" 沒有輸入沒辦法幫你尋找喔~~~ ");
				}

				/***************************2.開始查詢資料****************************************/
				ArtiFormService artiFormSvc = new ArtiFormService();
				Set<ArtiFormVO> artiFormVO = artiFormSvc.getAllArti4Serach(describe);

				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artiFormSet", artiFormVO);
//				session.setAttribute("describe", describe);
				String url = "/frontdesk/artiForm/listArti_withSet.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/artiReply/selectReply_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 依會員編號取出 ]******/
		if ("listArti_ByMemNo".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數****************************************/
				HttpSession session = req.getSession();
				String mem_No = req.getParameter("mem_No");

				if(mem_No==null||(mem_No.trim()).length()==0){
					errorMsgs.add(" 你還沒有登入喔~~~ ");
				}

				/***************************2.開始查詢資料****************************************/
				ArtiFormService artiFormSvc = new ArtiFormService();
				Set<ArtiFormVO> artiFormVO = artiFormSvc.findArtiByMemNo(mem_No);

				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artiFormSet", artiFormVO);
//				session.setAttribute("describe", describe);
				String url = "/frontdesk/artiForm/listArti_withSet.jsp";

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
		if ("getOneArti_For_Update".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數****************************************/
				HttpSession session = req.getSession();
				String arti_No = req.getParameter("arti_No");
				
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
					errorMsgs.add(" = ___ = A 要本人才能修改喔~");
					RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_men.jsp");
					failuewView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料****************************************/
				ArtiFormService artiFormSvc = new ArtiFormService();
				ArtiFormVO artiFormVO = artiFormSvc.getOneArtiForm(arti_No);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artiFormVO", artiFormVO);
				String url = "/frontdesk/artiForm/update_ArtiForm_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 無法取得要修改的資料 : " +e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 更新 ]******/
		if("updateArti".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String reqestURL = req.getParameter("reqestURL");
			
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			HttpSession session = req.getSession();
			String arti_No = req.getParameter("arti_No");
			String mem_No = req.getParameter("mem_No");
			String arti_Title = req.getParameter("arti_Title");
			Integer arti_Like = new Integer(req.getParameter("arti_Like"));
			String describe = req.getParameter("describe");
			
			if (describe == null||describe.trim().length()==0){
				errorMsgs.add(" 內容敘述請勿空白 ");
			}
			
			Timestamp nowTime = new Timestamp(System.currentTimeMillis());
			Timestamp arti_Time = nowTime;

			byte[] arti_Pic = null;
			try{
				Part photo = req.getPart("arti_Pic");
				InputStream in = photo.getInputStream();
				arti_Pic = new byte[in.available()];
				in.read(arti_Pic);
				in.close();
			} catch (FileNotFoundException fe){
				fe.printStackTrace();
			}

			Integer arti_Cls_No = new Integer (req.getParameter("arti_Cls_No").trim());
			String arti_Status = req.getParameter("arti_Status");
			
			if (arti_Status == null||arti_Status.trim().length()==0){
				errorMsgs.add(" 狀態請勿空白 ");
			}
			
			ArtiFormVO artiFormVO = new ArtiFormVO();
			
			artiFormVO.setArti_No(arti_No);
			artiFormVO.setMem_No(mem_No);
			artiFormVO.setArti_Title(arti_Title);
			artiFormVO.setArti_Like(arti_Like);
			artiFormVO.setDescribe(describe);
			artiFormVO.setArti_Time(arti_Time);
			artiFormVO.setArti_Pic(arti_Pic);
			artiFormVO.setArti_Cls_No(arti_Cls_No);
			artiFormVO.setArti_Status(arti_Status);

			if (!errorMsgs.isEmpty()){
				req.setAttribute("artiFormVO",artiFormVO);

				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/update_ArtiForm_input.jsp");
				failureView.forward(req, res);
				return;
			}
			
			/***************************2.開始修改資料*****************************************/
			ArtiFormService artiFormSvc = new ArtiFormService();
			artiFormVO = artiFormSvc.updateArtiForm(arti_No, mem_No, arti_Title, arti_Like, describe, arti_Time, arti_Pic, arti_Cls_No, arti_Status);

			/***************************3.修改完成,準備轉交(Send the Success view)*************/
			req.setAttribute("artiFormVO",artiFormVO);
			String url = "/frontdesk/artiForm/listOneArtiForm.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);
		}
		
		/******[ 更新 ]******/
		if("giveOneLike".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String reqestURL = req.getParameter("reqestURL");
			
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			HttpSession session = req.getSession();
			session.setMaxInactiveInterval(300*60*60*24);
			
			String arti_No = req.getParameter("arti_No");
			String mem_No = req.getParameter("mem_No_A");
			String mem_No_M = req.getParameter("mem_No_M");
			
			if(req.getSession().getAttribute("mem_No")==null){
				String contextPath = getServletContext().getContextPath();
				errorMsgs.add("@@ 要麻煩請你先登入喔~");
				RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
				failuewView.forward(req, res);
				return;
			}
			
			if(mem_No.equals(mem_No_M)){
				String contextPath = getServletContext().getContextPath();
				errorMsgs.add(" = ___ = A 本網站對這麼厚臉皮的行為......@@ 只有私底下默許，實行窒礙難行喔~~");
				RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_Like.jsp");
				failuewView.forward(req, res);
				return;
			}

			String arti_Title = req.getParameter("arti_Title");
			Integer arti_Like = (new Integer(req.getParameter("arti_Like"))+1);
			String describe = req.getParameter("describe");
			
			if (describe == null||describe.trim().length()==0){
				errorMsgs.add(" 內容敘述請勿空白 ");
			}
			
			Timestamp nowTime = new Timestamp(System.currentTimeMillis());
			Timestamp arti_Time = nowTime;

			byte[] arti_Pic = null;
			try{
				Part photo = req.getPart("arti_Pic");
				InputStream in = photo.getInputStream();
				arti_Pic = new byte[in.available()];
				in.read(arti_Pic);
				in.close();
			} catch (FileNotFoundException fe){
				fe.printStackTrace();
			}

			Integer arti_Cls_No = new Integer (req.getParameter("arti_Cls_No").trim());
			String arti_Status = "有讚喔";
			
			if (arti_Status == null||arti_Status.trim().length()==0){
				errorMsgs.add(" 狀態請勿空白 ");
			}
			
			ArtiFormVO artiFormVO = new ArtiFormVO();
			
			artiFormVO.setArti_No(arti_No);
			artiFormVO.setMem_No(mem_No);
			artiFormVO.setArti_Title(arti_Title);
			artiFormVO.setArti_Like(arti_Like);
			artiFormVO.setDescribe(describe);
			artiFormVO.setArti_Time(arti_Time);
			artiFormVO.setArti_Pic(arti_Pic);
			artiFormVO.setArti_Cls_No(arti_Cls_No);
			artiFormVO.setArti_Status(arti_Status);

			if (!errorMsgs.isEmpty()){
				req.setAttribute("artiFormVO",artiFormVO);

				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/update_ArtiForm_input.jsp");
				failureView.forward(req, res);
				return;
			}
			
			/***************************2.開始修改資料*****************************************/
			ArtiFormService artiFormSvc = new ArtiFormService();
			artiFormVO = artiFormSvc.updateArtiForm(arti_No, mem_No, arti_Title, arti_Like, describe, arti_Time, arti_Pic, arti_Cls_No, arti_Status);

			/***************************3.修改完成,準備轉交(Send the Success view)*************/
			req.setAttribute("artiFormVO",artiFormVO);
			String url = "/frontdesk/artiForm/listOneArtiForm.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);
		}
		
		if ("insertArti".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			String requestURL = req.getParameter("requestURL");
			
			try{
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/	
				HttpSession session = req.getSession();
				String arti_No = req.getParameter("arti_No").trim();
				String mem_No = req.getParameter("mem_No").trim();
				String arti_Title = req.getParameter("arti_Title").trim();
				Integer arti_Like = new Integer (req.getParameter("arti_Like"));
				
				String describe = req.getParameter("describe").trim();
				if (describe ==null||describe.trim().length()==0){
					errorMsgs.add(" 內容敘述請勿空白 ");
				}
				
				Timestamp nowTime = new Timestamp(System.currentTimeMillis());
				Timestamp arti_Time = nowTime;
				
				byte[] arti_Pic = null;
				try{
					Part photo = req.getPart("arti_Pic");
					InputStream in = photo.getInputStream();
					arti_Pic = new byte[in.available()];
					in.read(arti_Pic);
					in.close();
				} catch (FileNotFoundException fe){
					fe.printStackTrace(System.err);
				}
				
				Integer arti_Cls_No = new Integer(req.getParameter("arti_Cls_No").trim());
				String arti_Status = req.getParameter("arti_Status").trim();
				
				if (arti_Status == null || arti_Status.trim().length() == 0) {
					errorMsgs.add("狀態請勿空白");
				}
				
				ArtiFormVO artiFormVO = new ArtiFormVO();
				artiFormVO.setArti_No(arti_No);
				artiFormVO.setMem_No(mem_No);
				artiFormVO.setArti_Title(arti_Title);
				artiFormVO.setArti_Like(arti_Like);
				artiFormVO.setDescribe(describe);
				artiFormVO.setArti_Time(arti_Time);
				artiFormVO.setArti_Pic(arti_Pic);
				artiFormVO.setArti_Cls_No(arti_Cls_No);
				artiFormVO.setArti_Status(arti_Status);
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("artiFormVO", artiFormVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/addArtiForm.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ArtiFormService artiFormSvc = new ArtiFormService();
				artiFormVO = artiFormSvc.addArtiForm(arti_No, mem_No, arti_Title, arti_Like, describe, arti_Time, arti_Pic, arti_Cls_No, arti_Status);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("artiFormVo", artiFormVO);
				String url = "/frontdesk/artiForm/listAllArtiForm.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/artiForm/addArtiForm.jsp");
				failureView.forward(req, res);
			}
		}
		
		/******[ 刪除 ]******/
		if ("deleteArti".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數***************************************/
				HttpSession session = req.getSession();
				String arti_No = req.getParameter("arti_No");
				
				String mem_No = req.getParameter("mem_No");
				if(req.getSession().getAttribute("mem_No")==null){
					String contextPath = getServletContext().getContextPath();
					errorMsgs.add("@@ 要麻煩請你先登入喔~");
					RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
					failuewView.forward(req, res);
					return;
				}
				
				String user = (String) req.getSession().getAttribute("mem_No");
				if(user!=mem_No){
					String contextPath = getServletContext().getContextPath();
					errorMsgs.add(" = ___ = A 要本人才能刪除喔~");
					RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_men.jsp");
					failuewView.forward(req, res);
					return;
				}

				/***************************2.開始刪除資料***************************************/
				ArtiFormService artiFormSvc = new ArtiFormService();
				artiFormSvc.deleteArtiForm(arti_No);

				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/frontdesk/artiForm/listAllArtiForm.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 刪除資料失敗 : " + e.getMessage());
				RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listOneArtiForm_error_log.jsp");
				failuewView.forward(req, res);
			}
		}

		
		/******[ 後台刪除 ]******/
		if ("deleteArtiFMBack".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數***************************************/
				HttpSession session = req.getSession();
				String arti_No = req.getParameter("arti_No");
				
				/***************************2.開始刪除資料***************************************/
				ArtiFormService artiFormSvc = new ArtiFormService();
				artiFormSvc.deleteArtiForm(arti_No);

				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/backdesk/artiForm/listAllArtiForm_back.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(" 刪除資料失敗 : " + e.getMessage());
				RequestDispatcher failuewView = req.getRequestDispatcher("/frontdesk/artiForm/listAllArtiForm.jsp");
				failuewView.forward(req, res);
			}
		}

		
	}
}
