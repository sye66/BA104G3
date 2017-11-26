package com.rank.controller;

import java.io.IOException;
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
			
			
			

//			前10名
			RankService rankSvc = new RankService();
			List<RankVO> rankVO = rankSvc.getWNRank();
			MemService memSvc = new MemService();
			
			
			
		}catch (Exception e) {
			errorMsgs.add("無法取得資料:" + e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("/backdesk/schedule/Schedule.jsp");
			failureView.forward(req, res);
		}
	}
}
}

