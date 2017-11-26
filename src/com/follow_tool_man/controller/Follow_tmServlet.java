package com.follow_tool_man.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.follow_tool_man.model.Follow_tmService;
import com.follow_tool_man.model.Follow_tmVO;
import com.relation.model.RelationService;
import com.relation.model.RelationVO;

public class Follow_tmServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert_New".equals(action)){// 來自addStored.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
//			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_No =req.getParameter("mem_No").trim();
				String follower_Mem_No = req.getParameter("follower_Mem_No").trim();
				
				String followed_Mem_No = req.getParameter("followed_Mem_No").trim();
				
				Integer follow_Status = new Integer(req.getParameter("follow_Status").trim());
				
				
				Follow_tmVO follow_tmVO = new Follow_tmVO();
				
				followed_Mem_No = mem_No;
				System.out.println("mem_No + " +mem_No);
				
				follow_tmVO.setFollower_Mem_No(follower_Mem_No);
				follow_tmVO.setFollowed_Mem_No(followed_Mem_No);
				follow_tmVO.setFollow_Status(follow_Status);
				
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("follow_tmVO", follow_tmVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/follow_tm/followTm.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				Follow_tmService follow_tmSvc = new Follow_tmService();
				follow_tmVO = follow_tmSvc.addFollow_tmVO(followed_Mem_No, "M000018", 0);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.getSession().setAttribute("follow_tmVO", follow_tmVO);
				
				String location = req.getParameter("reuestURL");
				
				String url = "/frontdesk/follow_tm/followTm.jsp";
				String success ="ok";
				req.setAttribute("success", success);
				RequestDispatcher successView = req.getRequestDispatcher(url);  //讓使用者登入後停留在原頁面
			    successView.forward(req, res);
				
				
				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e){
//				errorMsgs.add("修改資料失敗 :" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/follow_tm/followTm.jsp");
//				failureView.forward(req, res);
//			}
		} //insert end
			
		if("delete".equals(action)){
			List<String> errorMsgs =new LinkedList<String>();
			System.out.println("======");
			req.setAttribute("errorMsgs", errorMsgs);
			
//			try{
				/***************************1.接收請求參數***************************************/
				String follower_Mem_No = req.getParameter("follower_Mem_No");
				System.out.println("follower_Mem_No + +" +follower_Mem_No);
				String followed_Mem_No = req.getParameter("followed_Mem_No");
				System.out.println("followed_Mem_No + +" +followed_Mem_No);
				Follow_tmService follow_tmSvc = new Follow_tmService();		
				follow_tmSvc.deleteFollow_tmVO(follower_Mem_No, followed_Mem_No);
				follow_tmSvc.deleteFollow_tmVO(followed_Mem_No, follower_Mem_No);
				
				/***************************2.開始刪除資料***************************************/
				
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				String url = "/frontdesk/follow_tm/followTmList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
//				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.add("刪除資料失敗 : "+e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/follow_tm/followTmList.jsp");
//				failureView.forward(req, res);
//			}
		}// delete end\
		System.out.println("==========end");
	
		
		
		
	}
}
