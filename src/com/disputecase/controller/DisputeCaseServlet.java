package com.disputecase.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.disputecase.model.DisputeCaseService;
import com.disputecase.model.DisputeCaseVO;


@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)

public class DisputeCaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		
		/*
		 * 處理申訴內容非空值即可，圖片可以為空值 
		 */		
		if ("issue_Dispute_Case".equals(action)) {
			
			List<String> errorMsg = new LinkedList<>();
			request.setAttribute("errorMsg", errorMsg);
			
			try {
				
				String disputeContent = request.getParameter("dispute_Content");
				System.out.println("Get Request from dispute case page: " + disputeContent);
				
				Part pic = request.getPart("dispute_Attachment");
				InputStream inputStream = pic.getInputStream();
				byte[] byteArrPic = new byte[inputStream.available()];
				System.out.println(byteArrPic.length);
				inputStream.read(byteArrPic);
				inputStream.close();
				
				if (disputeContent == null && (disputeContent.trim()).length() == 0) {
					errorMsg.add("輸入錯誤");
					System.out.println("輸入錯誤");
				}
				if (!errorMsg.isEmpty()) {
					RequestDispatcher failureView = request.getRequestDispatcher("/frontdesk/disputeCase/issueDisputeCase.jsp");
					failureView.forward(request, response);
					System.out.println("轉向");
					return; // Program interrupt.
				}
				
				DisputeCaseVO disputeCaseVO = new DisputeCaseVO();
				
				disputeCaseVO.setDispute_Case_Status(1);
				disputeCaseVO.setDispute_Content(disputeContent);
				disputeCaseVO.setDispute_Attachment(byteArrPic);
				
				Date date = new Date();
				Timestamp timestamp = new Timestamp(date.getTime());
				DisputeCaseService disputeCaseService = new DisputeCaseService();
				disputeCaseService.addDisputeCase(null, "MISSION000000027", "M000007", null, timestamp, null, 1);
				System.out.println("新增爭議案件");
			} catch (Exception e) {
				errorMsg.add("無法取得資料" + e.getMessage());
				RequestDispatcher failureView = request.getRequestDispatcher("/frontdesk/disputeCase/issueDisputeCase.jsp");
				failureView.forward(request, response);
				System.out.println("轉向" + e.getMessage());
			}
		}
	}
}