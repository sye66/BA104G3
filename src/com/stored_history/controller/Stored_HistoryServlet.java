package com.stored_history.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mem.model.MemService;
import com.mem.model.MemVO;
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
				String url = "/frontdesk/stored_history/stored_historyReview.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e){
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView =req.getRequestDispatcher("/stored_history/select_page.jsp");
				failureView.forward(req, res);
			}
		} //getOne_For_Display end
		
		
		
			if ("getAll_For_Display".equals(action)){
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
//			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_No = req.getParameter("mem_No");
				
				String stored_No = req.getParameter("stored_No");
				
				/***************************2.開始查詢資料*****************************************/
				StoredService storedSvc = new StoredService();
				List<StoredVO> storedVO = storedSvc.getAll(mem_No);
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				
				req.setAttribute("storedVO", storedVO);
				String url = "/frontdesk/stored_history/stored_historyReview.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e){
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView =req.getRequestDispatcher("/stored_history/select_page.jsp");
//				failureView.forward(req, res);
//			}
		} //getOne_For_Display end
		
		
		
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
				String url = "/stored_history/stored_historyReview.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/listAllStored.jsp");
				failureView.forward(req, res);
			}
		} //getOne_For_Update end
		
		
		
		
		
		
		
		if ("update".equals(action)){// 來自update_stored_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String stored_no = new String(req.getParameter("stored_no").trim());
				
				String mem_No = new String(req.getParameter("mem_No").trim());
				String mem_No_reg = "^M(0-9){6}$";
				if (mem_No == null || mem_No.trim().length() == 0){
					errorMsgs.add("會員編號請勿空白");
				} else if(!mem_No.trim().matches(mem_No_reg)){
					errorMsgs.add("會員編號 : 為 MXXXXXX");
				}
				
				Timestamp stored_Date = new Timestamp(System.currentTimeMillis());
					
				
				Integer stored_Type;
				try{
					stored_Type = new Integer(req.getParameter("stored_Type").trim());
//					String stored_Type_reg = "^(1-3){1}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請修改正確付款方式  (1.點數卡 ;2.信用卡 ;3.線上第三方支付");
					stored_Type = null;
				}
				
				Integer stored_Cost = null;
				try{
					stored_Cost = new Integer(req.getParameter("stored_Cost").trim());
				} catch(NumberFormatException e){
					errorMsgs.add("請輸入正確的金額");
				}
				
				StoredVO storedVO = new StoredVO();
				
				storedVO.setStored_No(stored_no);
				storedVO.setMem_No(mem_No);
				storedVO.setStored_Date(stored_Date);
				storedVO.setStored_Type(stored_Type);
				storedVO.setStored_Cost(stored_Cost);
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("storedVO", storedVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/update_stored_input.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				StoredService storedSvc = new StoredService();
				storedVO = storedSvc.updateStored(stored_no,mem_No,stored_Date,stored_Type,stored_Cost);
				
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
		} //update end
		
		if ("insert".equals(action)){// 來自addStored.jsp的請求
			System.out.println("stored_Date2 :"  );
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			System.out.println("stored_Date0 :"  );		
//			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				String stored_no = new String(req.getParameter("stored_no").trim());
				System.out.println("stored_Date2 :"  );
				String mem_No = new String(req.getParameter("mem_No").trim());
				if (mem_No == null || mem_No.trim().length() ==0 ){
					errorMsgs.add("請輸入會員編號");
				}
				System.out.println("stored_Date3 :"  );
				
				
				Timestamp stored_Date = new Timestamp(System.currentTimeMillis());
				
				System.out.println("stored_Date3 :" +stored_Date );
				
				Integer stored_Type;
				try{
					stored_Type = new Integer(req.getParameter("stored_Type").trim());
//					String stored_Type_reg = "^(1-3){1}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請修改正確付款方式  (1.點數卡 ;2.信用卡 ;3.線上第三方支付");
					stored_Type = null;
				}
				
				Integer stored_Cost = new Integer(req.getParameter("stored_Cost").trim());
				
				StoredVO storedVO = new StoredVO();
				
				
				Integer mem_Point = null;
				
				
//				storedVO.setStored_No(stored_no);
				storedVO.setMem_No(mem_No);
				storedVO.setStored_Date(stored_Date);
				storedVO.setStored_Type(stored_Type);
				storedVO.setStored_Cost(stored_Cost);
				
				MemService memSvc = new MemService();
				
				MemVO memVO =memSvc.getOneMem(mem_No);
				
				
				Integer mem_Point_old = memVO.getMem_Point();
				
				mem_Point = mem_Point_old + stored_Cost;
				
				memVO.setMem_Point(mem_Point);
				String cn = req.getParameter("card_number");
				String fn = req.getParameter("full_name");
				String my = req.getParameter("mmyy");
				
				
				
				
				System.out.println("mem_Point "+mem_Point);
				
				System.out.println("mem_No " + mem_No);
				System.out.println("mem_pw " + memVO.getMem_Address());
				System.out.println("stored_Date " + stored_Date);
				System.out.println("stored_Type " + stored_Type);
				System.out.println("stored_Cost " + stored_Cost);
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("card_number", cn);
					req.setAttribute("full_name", fn);
					req.setAttribute("mmyy", my);
					req.setAttribute("storedVO", storedVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/stored_history/stored_historyRecharge.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				StoredService storedSvc = new StoredService();
				storedVO = storedSvc.addStored(storedVO);
				
				System.out.println("storedVO.getStored_Date() " +storedVO.getStored_Date());
				
				System.out.println("storedVO " + storedVO);
				
				
				
				System.out.println("memSvc " + memVO.getMem_Point());
				
				memVO= memSvc.recharge(memVO);
				
				System.out.println("memVO " + memVO);
				
				req.setAttribute("card_number", cn);
				req.setAttribute("full_name", fn);
				req.setAttribute("mmyy", my);
				
				
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.getSession().setAttribute("memVO", memVO);
				req.getSession().setAttribute("storedVO", storedVO);
//				String url = "/frontdesk/stored_history/stored_historyRecharge.jsp";
				String location = req.getParameter("reuestURL");
				String success ="ok";
				req.setAttribute("success", success);
				RequestDispatcher successView = req.getRequestDispatcher(location);
				successView.forward(req, res); 
				
				
				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e){
//				errorMsgs.add("修改資料失敗 :" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/stored_history/stored_historyRecharge.jsp");
//				failureView.forward(req, res);
//			}
		} //insert end
		
		if("delete".equals(action)){
			List<String> errorMsgs =new LinkedList<String>();
			System.out.println("======");
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
		}// delete end\
		System.out.println("==========end");
	}
	
}