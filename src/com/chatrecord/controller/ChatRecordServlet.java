package com.chatrecord.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chatrecord.model.ChatRecordService;
import com.chatrecord.model.ChatRecordVO;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.stored_history.model.StoredService;
import com.stored_history.model.StoredVO;

/**
 * Servlet implementation class ChatRecordServlet
 */
@WebServlet("/ChatRecordServlet")
public class ChatRecordServlet extends HttpServlet {
       
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
if ("insert".equals(action)){// 來自addStored.jsp的請求
			
			//防止按F5重新送出
//			HttpSession session = req.getSession();
//			String finish =(String) session.getAttribute("finish");
//			System.out.println(finish);
//			if(finish == null){
//				String url = "/frontdesk/stored_history/stored_historyReview.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);
//				return;
//			}
				
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				ChatRecordService crSvc = new ChatRecordService();
				String chat_Content =req.getParameter("chatContent");
				Timestamp chat_Datetime =Timestamp.valueOf(req.getParameter("chat_Datetime"));
				System.out.println("chat_Datetime +" + chat_Datetime);
				String sender_Mem_No = req.getParameter("Sender_Mem_No");
				String receiver_Mem_No= req.getParameter("Receiver_Mem_No");
				if(req.getParameter("src") != null){
				chat_Content = req.getParameter("src") + chat_Content ;
				}
				
				crSvc.addChatRecord(sender_Mem_No, receiver_Mem_No, chat_Datetime, chat_Content);
				
//				crSvc.addChatRecord(sender_Mem_No, receiver_Mem_No, chat_Datetime, chat_Content);
				 
			
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/lib/publicfile/include/file/webSocket.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				
				
				
			
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				
				String url = "/lib/publicfile/include/file/webSocket.jsp";
//				String location = req.getParameter("reuestURL");
//				String success = req.getParameter("success");
//				req.setAttribute("success", success);
				RequestDispatcher successView = req.getRequestDispatcher(url);
//				req.removeAttribute(success);	//不需要加也可以消除sweetalert , 因為前面"finish"就先擋下來了
				successView.forward(req, res); 
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add("輸入資料失敗 :" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/lib/publicfile/include/file/webSocket.jsp");
				failureView.forward(req, res);
			}
		} 
		//insert end
	}
}
