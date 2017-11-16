package com.proorder.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.mem.model.MemVO;
import com.pro.model.ProService;
import com.pro.model.ProVO;
import com.pro.shoppingcart.ProCartVO;
import com.proclass.model.ProClassService;
import com.proorder.model.ProOrderService;
import com.proorder.model.ProOrderVO;
import com.proordlist.model.ProOrdListService;



public class ProOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
   
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("insert".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************
				 * 1.接收請求參數 - 輸入格式的錯誤處理
				 *************************/
				HttpSession session = req.getSession();
				MemVO memVO = (MemVO)session.getAttribute("register_memVO");
//目前寫死M000001
//				String mem_No = memVO.getMem_no();
				String mem_No = "M000001";
				
				@SuppressWarnings("unchecked") // 清除警告提示
				List<ProCartVO> list = (Vector<ProCartVO>) session.getAttribute("shoppingcart");
				
System.out.println("取資料");
				
//				String newDate =  new SimpleDateFormat("yy-MM-dd").format(new Date());
				java.sql.Date ord_Date = new java.sql.Date(System.currentTimeMillis());
				Double	ord_Price = new Double(req.getParameter("ord_Price").trim());
				String ord_Consignee = new String(req.getParameter("ord_Consignee").trim());
				String ord_Address = new String(req.getParameter("ord_Address").trim());
				String ord_Phone = new String(req.getParameter("ord_Phone").trim());
				
//				String  ord_Shipinfo = new String(req.getParameter("ord_Shipinfo;").trim());
				String  ord_Shipinfo = new String("未出貨");
System.out.println("取完資料");				
				//判斷點數
//				int totalPrice =  new Integer(req.getParameter("ord_Price"));
//				int mem_point = memVO.getMem_point();

				//扣會員點數部分未完成				
//				if(mem_point<totalPrice){
//					errorMsgs.add("點數不足");
//				}else if(mem_point>=totalPrice){
//					int point = mem_point-totalPrice;
//				}
				ProOrderVO proOrderVO = new ProOrderVO();
				proOrderVO.setMem_No(mem_No);
				proOrderVO.setOrd_Date(ord_Date);
				proOrderVO.setOrd_Price(ord_Price);
				proOrderVO.setOrd_Consignee(ord_Consignee);;
				proOrderVO.setOrd_Address(ord_Address);
				proOrderVO.setOrd_Phone(ord_Phone);
				proOrderVO.setOrd_Shipinfo(ord_Shipinfo);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("proOrderVO", proOrderVO); 
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/ProOrder/addProOrder.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				ProOrderService proOrderSvc = new ProOrderService();
				proOrderSvc.addProOrd_OrdList(proOrderVO, list);
//				清除購物車內容
System.out.println("清購物車");				
				session.removeAttribute("shoppingcart");
				/***************************
				 * 3.新增完成,準備轉交
				 ***********/
System.out.println("轉交");				
				String url = "/frontdesk/pro/showProIndex.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/ProOrder/addProOrder.jsp");
				failureView.forward(req, res);
			}
		}

		
		if ("getListProOrder".equals(action)) {
System.out.println("查詢個人訂單");
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***************************
				 * 1.接收請求參數 
				 **********************/
				String mem_No = "M000001";
					
				/*************************** 2.開始查詢資料 *****************************************/
				ProOrderService proOrderSvc = new ProOrderService();
				
				 List<ProOrderVO> listProOrder = proOrderSvc.listProOrder(mem_No);
				

				/***************************
				 * 3.查詢完成,準備轉交(Send the Success view)
				 *************/
				req.setAttribute("listProOrder", listProOrder);
	System.out.println("訂單查完轉交");		              
				String url = "/frontdesk/proOrder/listProOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/proOrder/listProOrder.jsp");
				failureView.forward(req, res);
			}
		}
	
		if ("updateProOrderUp".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 ***************************************/
				String ord_No = req.getParameter("ord_No");
				String ord_Shipinfo = "已取消";
				java.sql.Date ord_Ship_Date = new java.sql.Date(System.currentTimeMillis());
System.out.println("訂單取消: "+ord_No);				
			
				
				/*************************** 2.開始修改資料 ***************************************/
				
				
				ProOrderService proOrderSvc = new ProOrderService();
				proOrderSvc.updateProOrderUp(ord_No, ord_Shipinfo, ord_Ship_Date);
System.out.println("修改完成");				
				/***************************
				 * 3.刪除完成,準備轉交(Send the Success view)
				 ***********/
				String url = "/pro/proOrderServlet.do?action=getListProOrder";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backdesk/proOrder/listProOrder.jsp");
				failureView.forward(req, res);
			}
		}

		
	}

}
