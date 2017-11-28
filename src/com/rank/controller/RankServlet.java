package com.rank.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rank.model.RankService;
import com.rank.model.RankVO;
import com.mem.model.*;


@WebServlet("/RankServlet")
public class RankServlet extends HttpServlet {

	

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("payReward".equals(action)){
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
		try{
			//list是要給的點數 
			List<Integer> list = new ArrayList<>();
			List<String> mem_No = new ArrayList<>();
			
			String[] str = req.getParameterValues("rewarda");
			for(String c : str){
				Integer givePoint = Integer.parseInt(c);
				list.add(givePoint);
			}

//			前10名
			RankService rankSvc = new RankService();
			List<RankVO> rankVO = rankSvc.getWNRank();
			MemService memSvc = new MemService();
			
			for(RankVO b : rankVO){
				String str1 = b.getMem_No();
				mem_No.add(str1);
			}
			
			for(int i = 0; i<10;i++){
				memSvc.IncreaseMemPoint(mem_No.get(i), list.get(i));
			}
			errorMsgs.add("新增成功!");
			
			String url = "/backdesk/schedule/Schedule.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); 
			successView.forward(req, res);
			
		}catch (Exception e) {
			errorMsgs.add("新增資料不成功:" + e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("/backdesk/schedule/Schedule.jsp");
			failureView.forward(req, res);
		}
	}
		
if("payReward2".equals(action)){

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

		try{
			//list是要給的點數 
			List<Integer> list = new ArrayList<>();
			List<String> mem_No = new ArrayList<>();

			String[] str = req.getParameterValues("rewardb");

			for(String c : str){
				Integer givePoint = Integer.parseInt(c);
				list.add(givePoint);
			}
		
			System.out.println(list);

//			前10名
			RankService rankSvc = new RankService();
			List<RankVO> rankVO = rankSvc.getMNRank();
			MemService memSvc = new MemService();
			
			for(RankVO b : rankVO){
				String str1 = b.getMem_No();
				mem_No.add(str1);
			}
		
			for(int i = 0; i<10;i++){
				memSvc.IncreaseMemPoint(mem_No.get(i), list.get(i));
			}
			errorMsgs.add("新增成功!");
			
			String url = "/backdesk/schedule/Schedule.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); 
			successView.forward(req, res);
			
			
		}catch (Exception e) {
			errorMsgs.add("新增資料不成功:" + e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("/backdesk/schedule/Schedule.jsp");
			failureView.forward(req, res);
		}
	}
if("payReward3".equals(action)){
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	
try{
	//list是要給的點數 
	List<Integer> list = new ArrayList<>();
	List<String> mem_No = new ArrayList<>();
	
	String[] str = req.getParameterValues("rewardc");
	for(String c : str){
		Integer givePoint = Integer.parseInt(c);
		list.add(givePoint);
	}

//	前10名
	RankService rankSvc = new RankService();
	List<RankVO> rankVO = rankSvc.getSNRank();
	MemService memSvc = new MemService();
	
	for(RankVO b : rankVO){
		String str1 = b.getMem_No();
		mem_No.add(str1);
	}
	
	for(int i = 0; i<10;i++){
		memSvc.IncreaseMemPoint(mem_No.get(i), list.get(i));
	}
	errorMsgs.add("新增成功!");
	
	String url = "/backdesk/schedule/Schedule.jsp";
	RequestDispatcher successView = req.getRequestDispatcher(url); 
	successView.forward(req, res);
	
	
}catch (Exception e) {
	errorMsgs.add("新增資料不成功:" + e.getMessage());
	RequestDispatcher failureView = req
			.getRequestDispatcher("/backdesk/schedule/Schedule.jsp");
	failureView.forward(req, res);
}
}

if("payReward4".equals(action)){
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	
try{
	//list是要給的點數 
	List<Integer> list = new ArrayList<>();
	List<String> mem_No = new ArrayList<>();
	
	String[] str = req.getParameterValues("rewardd");
	for(String c : str){
		Integer givePoint = Integer.parseInt(c);
		list.add(givePoint);
	}

//	前10名
	RankService rankSvc = new RankService();
	List<RankVO> rankVO = rankSvc.getWCRank();
	MemService memSvc = new MemService();
	
	for(RankVO b : rankVO){
		String str1 = b.getMem_No();
		mem_No.add(str1);
	}
	
	for(int i = 0; i<10;i++){
		memSvc.IncreaseMemPoint(mem_No.get(i), list.get(i));
	}
	errorMsgs.add("新增成功!");
	
	String url = "/backdesk/schedule/Schedule.jsp";
	RequestDispatcher successView = req.getRequestDispatcher(url); 
	successView.forward(req, res);
	
	
}catch (Exception e) {
	errorMsgs.add("新增資料不成功:" + e.getMessage());
	RequestDispatcher failureView = req
			.getRequestDispatcher("/backdesk/schedule/Schedule.jsp");
	failureView.forward(req, res);
}
}

if("payReward5".equals(action)){
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	
try{
	//list是要給的點數 
	List<Integer> list = new ArrayList<>();
	List<String> mem_No = new ArrayList<>();
	
	String[] str = req.getParameterValues("rewarde");
	for(String c : str){
		Integer givePoint = Integer.parseInt(c);
		list.add(givePoint);
	}

//	前10名
	RankService rankSvc = new RankService();
	List<RankVO> rankVO = rankSvc.getMCRank();
	MemService memSvc = new MemService();
	
	for(RankVO b : rankVO){
		String str1 = b.getMem_No();
		mem_No.add(str1);
	}
	
	for(int i = 0; i<10;i++){
		memSvc.IncreaseMemPoint(mem_No.get(i), list.get(i));
	}
	errorMsgs.add("新增成功!");
	
	String url = "/backdesk/schedule/Schedule.jsp";
	RequestDispatcher successView = req.getRequestDispatcher(url); 
	successView.forward(req, res);
	
	
}catch (Exception e) {
	errorMsgs.add("新增資料不成功:" + e.getMessage());
	RequestDispatcher failureView = req
			.getRequestDispatcher("/backdesk/schedule/Schedule.jsp");
	failureView.forward(req, res);
}
}

if("payReward6".equals(action)){
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	
try{
	//list是要給的點數 
	List<Integer> list = new ArrayList<>();
	List<String> mem_No = new ArrayList<>();
	
	String[] str = req.getParameterValues("rewardf");
	for(String c : str){
		Integer givePoint = Integer.parseInt(c);
		list.add(givePoint);
	}

//	前10名
	RankService rankSvc = new RankService();
	List<RankVO> rankVO = rankSvc.getSCRank();
	MemService memSvc = new MemService();
	
	for(RankVO b : rankVO){
		String str1 = b.getMem_No();
		mem_No.add(str1);
	}
	
	for(int i = 0; i<10;i++){
		memSvc.IncreaseMemPoint(mem_No.get(i), list.get(i));
	}
	errorMsgs.add("新增成功!");
	
	String url = "/backdesk/schedule/Schedule.jsp";
	RequestDispatcher successView = req.getRequestDispatcher(url); 
	successView.forward(req, res);
	
	
}catch (Exception e) {
	errorMsgs.add("新增資料不成功:" + e.getMessage());
	RequestDispatcher failureView = req
			.getRequestDispatcher("/backdesk/schedule/Schedule.jsp");
	failureView.forward(req, res);
}
}
		
}
}

