package com.protrack.contoller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.model.ProService;
import com.protrack.model.*;

//@WebServlet("/ProTrackServlet")
public class ProTrackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProTrackServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insertProTrack".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
System.out.println("加入追蹤");
			try {
				/***********************
				 * 1.接收請求參數 - 輸入格式的錯誤處理
				 *************************/
//				HttpSession session = req.getSession();
//				MemVO memVO = (MemVO)session.getAttribute("register_memVO");
//目前寫死M000001
//				String mem_No = memVO.getMem_no();
				String mem_No = "M000001";
				
				String pro_No = req.getParameter("pro_No").trim();
				String requestURL = req.getParameter("requestURL");
				ProTrackVO proTrackVO = new ProTrackVO();
System.out.println("requestURL"+requestURL);
				proTrackVO.setMem_No(mem_No);
				proTrackVO.setPro_No(pro_No);
				
				
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("proTrackVO", proTrackVO); // 含有輸入格式錯誤的proVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/pro/addPro.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				ProTrackService proTrackSvc = new ProTrackService();
				 proTrackSvc.addProTrack(mem_No,pro_No);

				/***************************
				 * 3.新增完成,準備轉交
				 ***********/
//				String url = "/frontdesk/pro/showProIndex.jsp";
				String url = "/pro/pro.do?action=getOne_For_Display_F&pro_No="+pro_No;
				
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
			//路徑還要更改
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/pro/showProIndex.jsp");
				failureView.forward(req, res);
			}
		}
		if ("deleteProTrack".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 ***************************************/
				String pro_No = req.getParameter("pro_No");
				String mem_No = req.getParameter("mem_No");
				String requestURL = req.getParameter("requestURL");
	
				/*************************** 2.開始刪除資料 ***************************************/
				ProTrackService proTrackSvc = new ProTrackService();
				proTrackSvc.deleteProTrack(mem_No,pro_No);
				/***************************
				 * 3.刪除完成,準備轉交(Send the Success view)
				 ***********/
System.out.println("清單控制器收到路徑: "+requestURL);	
				String url= null;
				if(requestURL.equals("/frontdesk/pro/cart.jsp")||requestURL.equals("/frontdesk/proTrack/listProTrack.jsp")){
					url = "/frontdesk/pro/cart.jsp";
				}else {
					url = "/pro/pro.do?action=getOne_For_Display_F&pro_No="+pro_No;
				}
				
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/pro/listProTrack.jsp");
				failureView.forward(req, res);
			}
		}
	
	
	}

}
