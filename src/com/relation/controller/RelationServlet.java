package com.relation.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.relation.model.RelationService;
import com.relation.model.RelationVO;
import com.stored_history.model.StoredService;
import com.stored_history.model.StoredVO;

public class RelationServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		
		if ("get_Who_Addme".equals(action)){
			System.out.println("relationVO" );
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
//			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_No = req.getParameter("mem_No");
				String related_Mem_No = req.getParameter("related_Mem_No");
				
				
				Integer relation_Status = 0;
				/***************************2.開始查詢資料****************************************/
				RelationService relationSvc = new RelationService();
				List<RelationVO> relationVO = relationSvc.getWhoAddme(related_Mem_No);
				
				
				
				System.out.println("relationVO1" );
				
				
				System.out.println("relationVO3" );
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				
				req.getSession().setAttribute("relationVO", relationVO);
				
				System.out.println("relationVO : " + relationVO.size());
				String location = req.getParameter("reuestURL");
				
//				String url = "/frontdesk/relation/addRelationship.jsp";
				String success ="ok";
				req.setAttribute("success", success);
				RequestDispatcher successView = req.getRequestDispatcher(location);  //讓使用者登入後停留在原頁面
			    successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e){
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView =req.getRequestDispatcher("/stored_history/select_page.jsp");
//				failureView.forward(req, res);
//			}
		} //getOne_For_Display end 
		
		
		
		
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
				if (storedVO == null) {
					errorMsgs.add("查無資料");
				}
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				System.out.println("storedVO" +storedVO.size());
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
			
			System.out.println("3333333333331");
			
//			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_No = req.getParameter("mem_No").trim();
				
				String related_Mem_No = req.getParameter("related_Mem_No").trim();
				
				Integer relation_Status = 1;
				
				
				RelationVO relationVO = new RelationVO();
				
				relationVO.setMem_No(mem_No);
				relationVO.setRelated_Mem_No(related_Mem_No);
				relationVO.setRelation_Status(relation_Status);
				
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("relationVO", relationVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/relation/beAppliedRelationship.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				RelationService relationSvc = new RelationService();
				relationVO = relationSvc.updaterelationVO(mem_No, related_Mem_No, relation_Status);
				
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.getSession().setAttribute("relationVO", relationVO);
				
				String location = req.getParameter("reuestURL");
				
				String url = "/frontdesk/relation/beAppliedRelationship.jsp";
				String success ="ok";
				req.setAttribute("success", success);
				
				
				/***************************4.原本為A +B好友 且 B按同意(狀態改為1), 下列為新增一筆 B+A好友並直接確認(狀態改為1)***********/
				String temp = mem_No;
				mem_No = related_Mem_No;
				related_Mem_No = temp;
				
				relationVO = relationSvc.addRelationVO(mem_No, related_Mem_No, 1);
				
				req.getSession().setAttribute("relationVO", relationVO);
				
				
				
				/***************************5.將A的mem_No轉換成mem_Name(呼叫memSvc的getAll方法)***********/
				
				MemService memSvc = new MemService();
				System.out.println("related_Mem_No " + related_Mem_No);
				System.out.println("mem_No " +mem_No);
				MemVO memVO1 = memSvc.getOneMem(related_Mem_No);
				System.out.println("memVO1.getMem_Name()" +memVO1.getMem_Name());
				memVO1.setMem_Name(mem_No);
				
				System.out.println("1111memVO1.getMem_Name()" +memVO1.getMem_Name());
				
				req.getSession().setAttribute("memVO1", memVO1);
				
				RequestDispatcher successView = req.getRequestDispatcher(location);  //讓使用者登入後停留在原頁面
			    successView.forward(req, res);
				
				
				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e){
//				errorMsgs.add("修改資料失敗 :" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/stored_history/update_stored_input.jsp");
//				failureView.forward(req, res);
//			}
		} //update end
		
		if ("insert".equals(action)){// 來自addStored.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
//			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				String stored_no = new String(req.getParameter("stored_no").trim());
				String mem_No = req.getParameter("mem_No").trim();
				
				String related_Mem_No = req.getParameter("related_Mem_No").trim();
				
				Integer relation_Status = new Integer(req.getParameter("relation_Status").trim());
				
				
				RelationVO relationVO = new RelationVO();
				
				relationVO.setMem_No(mem_No);
				relationVO.setRelated_Mem_No(related_Mem_No);
				relationVO.setRelation_Status(relation_Status);
				
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("relationVO", relationVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/relation/addRelationship.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				RelationService relationSvc = new RelationService();
				relationVO = relationSvc.addRelationVO(mem_No, related_Mem_No, relation_Status);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.getSession().setAttribute("relationVO", relationVO);
				
				String location = req.getParameter("reuestURL");
				
//				String url = "/frontdesk/relation/addRelationship.jsp";
				String success ="ok";
				req.setAttribute("success", success);
				RequestDispatcher successView = req.getRequestDispatcher(location);  //讓使用者登入後停留在原頁面
			    successView.forward(req, res);
				
				
				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e){
//				errorMsgs.add("修改資料失敗 :" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/relation/addRelationship.jsp");
//				failureView.forward(req, res);
//			}
		} //insert end
		
		
		if ("insert_New".equals(action)){// 來自addStored.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
//			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_No = req.getParameter("mem_No").trim();
				String related_Mem_No = req.getParameter("related_Mem_No").trim();
				Integer relation_Status = new Integer(req.getParameter("relation_Status").trim());
				
				RelationVO relationVO = new RelationVO();
				
				relationVO.setMem_No(mem_No);
				relationVO.setRelated_Mem_No(related_Mem_No);
				relationVO.setRelation_Status(relation_Status);
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("relationVO", relationVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/personal/PersonalPage.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				RelationService relationSvc = new RelationService();
				relationVO = relationSvc.addRelationVO(mem_No, related_Mem_No, relation_Status);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String responseJSONObject="";
				Gson gson = new Gson();
				responseJSONObject = gson.toJson(relationVO);
				PrintWriter out = res.getWriter();
				out.println(responseJSONObject);
				
				/***************************其他可能的錯誤處理**********************************/
		} //insert end
		
		if("delete".equals(action)){
			List<String> errorMsgs =new LinkedList<String>();
			System.out.println("======");
			req.setAttribute("errorMsgs", errorMsgs);
			
				/***************************1.接收請求參數***************************************/
				String mem_No = req.getParameter("mem_No");
				String related_Mem_No = req.getParameter("related_Mem_No");
				Integer relation_Status = new Integer(req.getParameter("relation_Status").trim());
				
				RelationService relationSvc = new RelationService();				
				RelationVO relationVO = relationSvc.getOneRelationVO(mem_No, related_Mem_No);
				
				
				/***************************2.開始刪除資料***************************************/
				relationSvc.deleteRelationVO(mem_No, related_Mem_No);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				String responseJSONObject="";
				Gson gson = new Gson();
				responseJSONObject = gson.toJson(relationVO);
				PrintWriter out = res.getWriter();
				out.println(responseJSONObject);
				
				/***************************其他可能的錯誤處理**********************************/
		}// delete end\
	}
}