package com.stored_history.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mem.model.MemService;
import com.stored_history.model.StoredService;
import com.stored_history.model.StoredVO;

public class Stored_HistoryServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)){
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("stored_no");
				if(str == null || (str.trim()).length() == 0){
					errorMsgs.add("請輸入儲值記錄編號");
				}
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String stored_no = null;
				try{
					stored_no = new String(str);
				} catch (Exception e) {
					errorMsgs.add("儲值記錄編號格式不正確");
				}
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始查詢資料*****************************************/
				StoredService storedSvc = new StoredService();
				StoredVO storedVO = storedSvc.getOneStored(stored_no);
				if (storedVO == null) {
					errorMsgs.add("查無資料");
				}
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				
				req.setAttribute("storedVO", storedVO);
				String url = "/stored_history/listOneStored.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e){
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView =req.getRequestDispatcher("/stored_history/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)){// 來自listAllStored.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數****************************************/
				
				String stored_no = new String(req.getParameter("stored_no"));
				
				/***************************2.開始查詢資料****************************************/
				
				StoredService storedSvc = new StoredService();
				StoredVO storedVO = storedSvc.getOneStored(stored_no);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				
				req.setAttribute("storedVO", storedVO);
				String url = "/stored_history/update_stored_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/listAllStored.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)){// 來自update_stored_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String stored_no = new String(req.getParameter("stored_no").trim());
				
				String mem_no = new String(req.getParameter("mem_no").trim());
				String mem_no_reg = "^M(0-9){6}$";
				if (mem_no == null || mem_no.trim().length() == 0){
					errorMsgs.add("會員編號請勿空白");
				} else if(!mem_no.trim().matches(mem_no_reg)){
					errorMsgs.add("會員編號 : 為 MXXXXXX");
				}
				
				Date stored_date =null;
				try{
					stored_date = Date.valueOf(req.getParameter("stored_date").trim());
					
				} catch(IllegalArgumentException e){
					stored_date = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入正確日期 !");
				}
				
				Integer stored_type;
				try{
					stored_type = new Integer(req.getParameter("stored_type").trim());
//					String stored_type_reg = "^(1-3){1}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請修改正確付款方式  (1.點數卡 ;2.信用卡 ;3.線上第三方支付");
					stored_type = null;
				}
				
				Double stored_cost = null;
				try{
					stored_cost = new Double(req.getParameter("stored_cost").trim());
				} catch(NumberFormatException e){
					errorMsgs.add("請輸入正確的金額");
				}
				
				StoredVO storedVO = new StoredVO();
				
				storedVO.setStored_no(stored_no);
				storedVO.setMem_no(mem_no);
				storedVO.setStored_date(stored_date);
				storedVO.setStored_type(stored_type);
				storedVO.setStored_cost(stored_cost);
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("storedVO", storedVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/update_stored_input.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				StoredService storedSvc = new StoredService();
				storedVO = storedSvc.updateStored(stored_no,mem_no,stored_date,stored_type,stored_cost);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("storedVO", storedVO);
				String url = "/stored_history/listOneStored.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add("修改資料失敗 :" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/update_stored_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)){// 來自addStored.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				String stored_no = new String(req.getParameter("stored_no").trim());
				
				String mem_no = new String(req.getParameter("mem_no").trim());
				if (mem_no == null || mem_no.trim().length() ==0 ){
					errorMsgs.add("請輸入會員編號");
				}
				
				Date stored_date =null;
				try{
					stored_date = Date.valueOf(req.getParameter("stored_date").trim());
					
				} catch(IllegalArgumentException e){
					stored_date = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入正確日期 !");
				}
				
				Integer stored_type;
				try{
					stored_type = new Integer(req.getParameter("stored_type").trim());
//					String stored_type_reg = "^(1-3){1}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請修改正確付款方式  (1.點數卡 ;2.信用卡 ;3.線上第三方支付");
					stored_type = null;
				}
				
				Double stored_cost = null;
				try{
					stored_cost = new Double(req.getParameter("stored_cost").trim());
				} catch(NumberFormatException e){
					errorMsgs.add("請輸入正確的金額");
				}
				
				StoredVO storedVO = new StoredVO();
				
//				storedVO.setStored_no(stored_no);
				storedVO.setMem_no(mem_no);
				storedVO.setStored_date(stored_date);
				storedVO.setStored_type(stored_type);
				storedVO.setStored_cost(stored_cost);
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("storedVO", storedVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/update_stored_input.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				StoredService storedSvc = new StoredService();
				storedVO = storedSvc.addStored(mem_no,stored_date,stored_type,stored_cost);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("storedVO", storedVO);
				String url = "/stored_history/listAllStored.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add("修改資料失敗 :" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/addStored.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("delete".equals(action)){
			List<String> errorMsgs =new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數***************************************/
				String stored_no = req.getParameter("stored_no");
				
				/***************************2.開始刪除資料***************************************/
				StoredService storedSvc = new StoredService();
				storedSvc.deleteStored(stored_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				String url = "/stored_history/listAllStored.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗 : "+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/listAllStored.jsp");
				failureView.forward(req, res);
			}
			}
	}
}