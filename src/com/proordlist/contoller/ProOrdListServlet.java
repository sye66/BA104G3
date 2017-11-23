package com.proordlist.contoller;

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
import javax.servlet.http.HttpSession;

import com.pro.model.ProService;
import com.pro.model.ProVO;
import com.proordlist.model.ProOrdListService;
import com.proordlist.model.ProOrdListVO;

//@WebServlet("/ProOrdListServlet.do")
public class ProOrdListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProOrdListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
			
		if ("getOneOrdList".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
//			String requestURL = req.getParameter("requestURL");
			
			try {
				/***************************
				 * 1.接收請求參數 - 輸入格式的錯誤處理
				 **********************/
				String ord_No =req.getParameter("ord_No");
				String requestURL = req.getParameter("requestURL");
				String whichPage = req.getParameter("whichPage");
			
System.out.println("查詢清單 訂單編號: "+ord_No);
System.out.println("requestURL: "+requestURL);
System.out.println("whichPage: "+whichPage);
					if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/selectPage.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
					ProOrdListService proOrdListSvc = new ProOrdListService();
					List<ProOrdListVO> oneOrdList = new ArrayList<ProOrdListVO>();
					oneOrdList = (List<ProOrdListVO>) proOrdListSvc.getOneProOrdListVO(ord_No);
					for(ProOrdListVO p :oneOrdList){
						System.out.println(p.getOrd_No()+" "+p.getPro_No()
						+" "+p.getOrdPro_Count()+" "+p.getOrdPro_Price());
					}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/selectPage.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/***************************
				 * 3.查詢完成,準備轉交(Send the Success view)
				 *************/
				String	url = null;
//				HttpSession session = req.getSession(); 
				req.setAttribute("oneOrdList", oneOrdList);
				if(requestURL.equals("/BA104G3/backdesk/proOrder/listProOrder_B.jsp")){
					url  = "/backdesk/proOrder/listProOrder_B.jsp";
				}else if(requestURL.equals("/BA104G3/backdesk/proOrder/listProOrder_B2.jsp")){
					url  = "/backdesk/proOrder/listProOrder_B2.jsp";
				}else{
					url  = "/frontdesk/proOrder/listProOrder.jsp";
				}
				 
				System.out.println("url: "+url);
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/pro/showProIndex.jsp");
				failureView.forward(req, res);
			}
		}

		
		
		
	
	
	}

}
