package com.proorder.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.pro.shoppingcart.ProCartVO;
import com.proorder.model.ProOrderService;
import com.proorder.model.ProOrderVO;
import com.tool.controller.ProOrderEmail;
import com.tool.controller.TelMessage;



public class ProOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
   
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
System.out.println("訂單 action: "+action);		
		
		if ("insert".equals(action)) { 
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************
				 * 1.接收請求參數 - 輸入格式的錯誤處理
				 *************************/
				HttpSession session = req.getSession();
				@SuppressWarnings("unchecked") // 清除警告提示
				List<ProCartVO> list = (Vector<ProCartVO>) session.getAttribute("shoppingcart");
				for(ProCartVO p:list){
					System.out.println(p.getProCar_No()); 
				}
				

				String mem_No = req.getParameter("mem_No").trim();
System.out.println("建立訂單 會員編號: "+mem_No);

				String ord_Consignee = new String(req.getParameter("ord_Consignee").trim());
				Integer	ord_Price = new Integer(req.getParameter("ord_Price"));
				
//				String mem_Tel = new String(req.getParameter("mem_Tel").trim());
//				String mem_Pho = new String(req.getParameter("mem_Pho").trim());
//				
//				//家用電話+手機
//				String ord_Phone = mem_Tel+","+mem_Pho; 
				String ord_Phone = new String(req.getParameter("mem_Pho").trim());
				String ord_Address = new String(req.getParameter("ord_Address").trim());
				java.sql.Date ord_Date = new java.sql.Date(System.currentTimeMillis());
				String  ord_Shipinfo = new String("未出貨");
				java.sql.Date ord_Ship_Date	= null;	
				
				
				ProOrderVO proOrderVO = new ProOrderVO();
				proOrderVO.setMem_No(mem_No);
				proOrderVO.setOrd_Consignee(ord_Consignee);
				proOrderVO.setOrd_Price(ord_Price);
				proOrderVO.setOrd_Phone(ord_Phone);
				proOrderVO.setOrd_Address(ord_Address);
				proOrderVO.setOrd_Date(ord_Date);
				proOrderVO.setOrd_Shipinfo(ord_Shipinfo);
				proOrderVO.setOrd_Ship_Date(ord_Ship_Date);
System.out.println("set完資料 "
				+proOrderVO.getMem_No()+" "
				+proOrderVO.getOrd_Consignee()+" "
		        +proOrderVO.getOrd_Price()+" "
		        +proOrderVO.getOrd_Phone()+" "
		        +proOrderVO.getOrd_Address()+" "
				+proOrderVO.getOrd_Date()+" "
		        +proOrderVO.getOrd_Shipinfo()+" "
		        +proOrderVO.getOrd_Ship_Date());				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("proOrderVO", proOrderVO); 
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/ProOrder/addProOrder.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
System.out.println("開始新增訂單+明細");				
				ProOrderService proOrderSvc = new ProOrderService();
				proOrderSvc.addProOrd_OrdList(proOrderVO, list);
				Integer sum = 0;
				String proEmailText ="";
				for(ProCartVO p :list){
					sum+= (p.getProCar_Price())*(p.getProCar_Quantity());
					proEmailText +="商品:"+p.getProCar_Name()+"  單價:"+p.getProCar_Price()
					+"  數量:"+p.getProCar_Quantity()+"  小計:"+p.getProCar_Price()*p.getProCar_Quantity()
					+"\n";
							
				}
				
System.out.println("扣除會員點數: "+sum);				
				MemService memSvc = new MemService();
				MemVO memVO=memSvc.getOneMem(mem_No);
				Integer mem_Point =memVO.getMem_Point();
System.out.println("會員點數: "+mem_Point);
				mem_Point = mem_Point-sum;
System.out.println("扣完後會員點數: "+mem_Point);
				memSvc.updateMemPoint(mem_No, mem_Point);
				 memVO =(MemVO)memSvc.getOneMem(mem_No);
				session.setAttribute("memVO",memVO);
				
System.out.println("發送Email: ");
				ProOrderEmail email = new ProOrderEmail();	
				String to = memVO.getMem_Email();
//				String to = "eatkaikai@gmail.com";
				String subject = "工具人商城消費通知";
				
				String messageText = memVO.getMem_Name()+"先生/小姐 您好!"+"\n"+"您於工具人商城購買"+"\n"
						+proEmailText+"\n"+"總消費為: "+sum+" 積分";
				email.sendMail(to, subject, messageText);
				
System.out.println("發送電話簡訊: ");
				String t = 	(memVO.getMem_Pho()).replaceAll("-","");
				String[] tel = {t};
System.out.println(tel[0]);				
				TelMessage telMessage = new TelMessage();
				telMessage.sendMessage(tel, messageText);
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
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/pro/showProIndex.jsp");
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
				HttpSession session = req.getSession();
				MemVO memVO = (MemVO) session.getAttribute("memVO");
				String mem_No =(String) memVO.getMem_No();
System.out.println("session取得的會員編號 "+mem_No);
					
				/*************************** 2.開始查詢資料 *****************************************/
				ProOrderService proOrderSvc = new ProOrderService();
				
				 List<ProOrderVO> proOrderlist = proOrderSvc.listProOrder(mem_No);
				

				/***************************
				 * 3.查詢完成,準備轉交(Send the Success view)
				 *************/
				 session.removeAttribute("proOrderlist");
				 session.setAttribute("proOrderlist", proOrderlist);
//				req.setAttribute("list", list);
	System.out.println("訂單查完轉交");	
	for(ProOrderVO pvo2:proOrderlist){
		System.out.println(pvo2.getOrd_No()
		+" "+pvo2.getOrd_Date()+" "+pvo2.getMem_No()
		+" "+pvo2.getOrd_Price()+" "+pvo2.getOrd_Consignee()
		+" "+pvo2.getOrd_Address()+" "+pvo2.getOrd_Phone()
		+" "+pvo2.getOrd_Shipinfo()+" "+pvo2.getOrd_Ship_Date());
	}
	
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
				String ord_Shipinfo = req.getParameter("ord_Shipinfo");
				String ord_No = req.getParameter("ord_No");
				String requestURL = req.getParameter("requestURL");
				
				 
				java.sql.Date ord_Ship_Date = new java.sql.Date(System.currentTimeMillis());
System.out.println("UP訂單: "+ord_No);				
System.out.println("ord_Shipinfo: "+ord_Shipinfo);				
System.out.println("ord_Ship_Date: "+ord_Ship_Date);				
			
				
				/*************************** 2.開始修改資料 ***************************************/
				
				
				ProOrderService proOrderSvc = new ProOrderService();
				proOrderSvc.updateProOrderUp(ord_No, ord_Shipinfo, ord_Ship_Date);
System.out.println("修改完成");				
				/***************************
				 * 3.刪除完成,準備轉交(Send the Success view)
				 ***********/

				String url = null;
				 if(requestURL.equals("/BA104G3/backdesk/proOrder/listProOrder_B2.jsp")){
					url  = "/backdesk/proOrder/listProOrder_B2.jsp";
				}else{
					url  = "/pro/proOrderServlet.do?action=getListProOrder";
				}
System.out.println("修改完返回 URL: " + url);
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
