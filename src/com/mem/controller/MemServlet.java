package com.mem.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.mem.controller.MailService;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MemServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("loginServlet".equals(action)){
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_Email = req.getParameter("mem_Email");
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.loginMem(mem_Email);
				
//System.out.println("mem_No :" + memVO.getMem_No());
//				System.out.println("Email :" + mem_Email);
				String mem_Email_reg = "^[a-zA-Z0-9_]{3,15}@[a-zA-Z]{2,7}.[a-zA-Z.]{3,7}$";
				if (mem_Email ==null || mem_Email.trim().length() ==0){
					errorMsgs.add("E-mail請勿空白");
				} else if (!mem_Email.trim().matches(mem_Email_reg)){
				errorMsgs.add("請正確輸入E-mail");
				} else if (memVO == null){
					errorMsgs.add("查無此E-mail");
					
				}
				
				String mem_Pw = req.getParameter("mem_Pw").trim();
				
//				System.out.println("mem_Pw :" + mem_Pw);
//				System.out.println("使用者輸入 :" + memVO.getMem_Email());
//				System.out.println("資料庫 :" + mem_Pw);
//				System.out.println("使用者輸入 :" + memVO.getMem_Pw());
				
				if (mem_Pw == null || mem_Pw.trim().length() == 0){
					errorMsgs.add("密碼請勿空白");
				} else if(!(memVO.getMem_Pw().equals(mem_Pw))){
					errorMsgs.add("密碼錯誤");
				}
				
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mem/errorPage.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料*****************************************/
				req.getSession().setAttribute("memVO", memVO);
				
				
				String location = req.getParameter("reuestURL");
			    
			    System.out.println("location" + location);
			    String url = "/lib/publicfile/include/file/index.jsp";
			    String url_reg= "/frontdesk/mem/register.jsp";
			     if(location.equals(url_reg)){
			     RequestDispatcher successView = req.getRequestDispatcher(url);	//判斷使用者是否在註冊頁面  登入帳號,如果是就跳轉主頁
			     successView.forward(req, res);
			    }else if(location != null){
			     RequestDispatcher successView = req.getRequestDispatcher(location);  //讓使用者登入後停留在原頁面
			     successView.forward(req, res);
			    }
			 /***************************其他可能的錯誤處理*************************************/
			
		} catch (Exception e){
			errorMsgs.add("無法取得資料:" + e.getMessage());
			RequestDispatcher failureView =req.getRequestDispatcher("/frontdesk/mem/errorPage.jsp");
			failureView.forward(req, res);
		}
	}
	
		
		if ("logoutServlet".equals(action)){
			req.getSession().invalidate();
			
			String url = "/lib/publicfile/include/file/index.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			
		}
		
		
		if ("register".equals(action)){
			req.getSession().invalidate();
			
			String url = "/frontdesk/mem/register.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}


		
		
		
		
		
		if ("registerNew".equals(action)){// 來自addMem.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				String mem_No = new String(req.getParameter("mem_No").trim());
				
				String mem_Pw = req.getParameter("mem_Pw").trim();
				if (mem_Pw == null || mem_Pw.trim().length() == 0){
					errorMsgs.add("密碼請勿空白");
				}
				
				String mem_Name = req.getParameter("mem_Name");
				String mem_Name_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (mem_Name == null || mem_Name.trim().length() == 0){
					errorMsgs.add("員工姓名: 請勿空白");
				}else if(!mem_Name.trim().matches(mem_Name_reg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員姓名: 只能是中、英文字母、數字和_ , 且長度必須在2到10之間");					
				}
				
				String mem_Id = req.getParameter("mem_Id").trim();
				if (mem_Id == null || mem_Id.trim().length() == 0){
					errorMsgs.add("暱稱請勿空白");
				}
				
				Date mem_Bday =null;
				try{
					mem_Bday = Date.valueOf(req.getParameter("mem_Bday").trim());
				} catch (IllegalArgumentException e) {
					mem_Bday = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期 ! ");
				}
				
				String mem_Tel = req.getParameter("mem_Tel");
				String mem_Tel_reg = "^[0-9+-]{9,12}$";
				if (mem_Tel == null || mem_Tel.trim().length() == 0){
					errorMsgs.add("市話號碼: 請勿空白");
				}else if(!mem_Tel.trim().matches(mem_Tel_reg)) { 
				errorMsgs.add("市話號碼: 只能是數字和-+ , 且長度必須在9到10之間 ，EX:06-3345678");
				}
				
				String mem_Pho = req.getParameter("mem_Pho");
				String mem_Pho_reg = "^09[0-9]{2}-[0-9]{6}$";
				if (mem_Pho == null || mem_Pho.trim().length() == 0){
					errorMsgs.add("手機號碼: 請勿空白");
				}else if(!mem_Pho.trim().matches(mem_Pho_reg)) {
				errorMsgs.add("手機號碼: 只能是數字和- , 且長度必須在10碼 ，EX:0988-988988");
				}
				
				
				Integer mem_Gend;
				try{
				mem_Gend = new Integer(req.getParameter("mem_Gend").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入性別 !");
					mem_Gend = null;
					errorMsgs.add("性別: 只能1 或 2 或 3  (1.男; 2.女 ; 3.其他");
				}
				
				
				
				
				String mem_Email = req.getParameter("mem_Email");
				String mem_Email_reg = "^[a-zA-Z0-9_]{3,15}@[a-zA-Z]{2,7}.[a-zA-Z.]{3,7}$";
				if (mem_Email ==null || mem_Email.trim().length() ==0){
					errorMsgs.add("E-mail請勿空白");
				}else if (!mem_Email.trim().matches(mem_Email_reg)){
				errorMsgs.add("請正確輸入E-mail");
				}
				
				
				
				
				
				String mem_Intro = req.getParameter("mem_Intro");
				if (mem_Intro == null || mem_Intro.trim().length() ==0){
					errorMsgs.add("自我介紹請勿空白");
				}else if (mem_Intro == null || mem_Intro.trim().length() <10){
					errorMsgs.add("自我介少請超過10個字");
				}
				
//				Integer mem_Code = null;
//				try{
//					mem_Code = new Integer(req.getParameter("mem_Code").trim());
//				} catch (NumberFormatException e){
//					errorMsgs.add("請正確輸入驗證碼 ! ");
//				}
				
				//後端調整狀態用
				Integer mem_State = 0;
//				System.out.println(mem_State);
				
//				try{
//					mem_State = new Integer(req.getParameter("mem_State").trim());
//				} catch (NumberFormatException e){
//					errorMsgs.add("請輸入 0 或 1 或 2 (0.未驗證會員 ; 1.普通會員 ; 2.黃金會員");
//				}
				
				
//				Double mem_Gps_Lat = null;
//				try{
//				mem_Gps_Lat = new Double (req.getParameter("mem_Gps_Lat").trim());
////				Double mem_Gps_Lat_reg =  "^[0-9]{2,3}.[0-9]{6}$";
//				} catch (NumberFormatException e){
//					errorMsgs.add("請輸入正確格式的經度");
//				}
			 
//				Double mem_Gps_Lng = null;
//				try{
//				mem_Gps_Lng = new Double (req.getParameter("mem_Gps_Lng").trim());
//	//			Double mem_Gps_Lat_reg =  "^[0-9]{2,3}.[0-9]{6}$";
//				} catch (NumberFormatException e){
//					errorMsgs.add("請輸入正確格式的緯度");
//				}
				
				
				String ip = req.getRemoteAddr();		//本機端查詢到IP是0.0.0.0.0.1 ，
				String mem_Ip = ip;
				String mem_Ip_reg =  "^[0-9].{4,15}$";
				if (!mem_Ip.trim().matches(mem_Ip_reg)){
					errorMsgs.add("請輸入正確ip位置");
				}
				
				
				java.util.Date utilDate = new java.util.Date();    //获取当前时间
				java.sql.Date mem_Date = new java.sql.Date(utilDate.getTime());
				
//					System.out.println("mem_date : " +mem_Date);
					
				
//				Integer mission_Count = null;
//				try{
//					mission_Count = new Integer(req.getParameter("mission_Count").trim());
//				} catch (NumberFormatException e){
//					errorMsgs.add("請輸入正確任務次數數字 ! ");
//				}
				
				
				String City = req.getParameter("City2");
				String Area = req.getParameter("Area2");
				String ZIP = req.getParameter("ZIP");
				String mem_Address = req.getParameter("mem_Address");
				String mem_Address1 = mem_Address;
				String real_mem_Address = ZIP +City + Area + mem_Address;
//				System.out.println("real_mem_Address :" +real_mem_Address);
				mem_Address = real_mem_Address;
				
				String mem_Address_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{12,30}$";
				if (mem_Address == null || mem_Address.trim().length() == 0){
					errorMsgs.add("請輸入地址 ! ");
				} else if(!mem_Address.trim().matches(mem_Address_reg)){
					errorMsgs.add("請正確輸入地址格式 !  ");
				}
				
				Integer mem_Search = null;
				try{
					mem_Search = new Integer(req.getParameter("mem_Search").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確數字 (0.不願意被搜尋 , 1.可以被搜尋");
				}
				
//				Integer mem_Point = null;
//				try{
//					mem_Point = new Integer(req.getParameter("mem_Point").trim());
//				} catch (NumberFormatException e){
//					errorMsgs.add("請輸入積分數字");
//				}
				
				
				MemVO memVO = new MemVO();
				Part part = req.getPart("mem_Pic");
				InputStream is = part.getInputStream();
				byte[] buffer = new byte[is.available()];
				is.read(buffer);
				
				
				/***************************mail區塊 1***************************************/
				
				String to = "kiz7386@gmail.com";
			      
			    String subject = "密碼通知";
			      
			    String ch_name = memVO.getMem_Id();
			    String passRandom = "111";
			    String messageText = "Hello! " + ch_name + " 請謹記此密碼: " + passRandom + "\n" +
			    					 " (已經啟用) , 請至會員中心 http://10.120.25.29:8081/BA104G3/frontdesk/mem/memAuthentication.jsp 驗證,謝謝您"; 
			    
			    Integer mem_Code = Integer.valueOf(passRandom);
			    
				/***************************mail區塊 1***************************************/
				
				
				

				memVO.setMem_Pw(mem_Pw);
				memVO.setMem_Name(mem_Name);
				memVO.setMem_Id(mem_Id);
				memVO.setMem_Bday(mem_Bday);
				memVO.setMem_Tel(mem_Tel);
				memVO.setMem_Pho(mem_Pho);
				memVO.setMem_Gend(mem_Gend);
				memVO.setMem_Email(mem_Email);
				memVO.setMem_Pic(buffer);
				memVO.setMem_Intro(mem_Intro);
				memVO.setMem_Code(mem_Code);//亂數寫入驗證碼存到資料庫 ，後續再請惠原點連結至會員中心驗證
//				memVO.setMem_Code(mem_Code);//
				memVO.setMem_State(mem_State);
//				memVO.setMem_Gps_Lat(mem_Gps_Lat);//
//				memVO.setMem_Gps_Lng(mem_Gps_Lng);//
				memVO.setMem_Ip(ip);//
				memVO.setMem_Date(mem_Date);
//				memVO.setMission_Count(mission_Count);//
				memVO.setMem_Address(real_mem_Address);
				memVO.setMem_Search(mem_Search);
//				memVO.setMem_Point(mem_Point);//
				req.setAttribute("City2", City);
				req.setAttribute("Area2", Area);
				req.setAttribute("ZIP", ZIP);
				req.setAttribute("mem_Address", mem_Address1);
				
				
				
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("memVO", memVO);
//					req.setAttribute("City", City);
//					req.setAttribute("register_memVO", memVO);
//					req.setAttribute("register_memVO", memVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mem/register.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				/***************************2.開始新增資料***************************************/
				MemService memSvc = new MemService();
				memVO = memSvc.registerMem(mem_Pw, mem_Name, mem_Id, mem_Bday, mem_Tel, mem_Pho, mem_Gend, mem_Email, buffer, mem_Intro,  mem_State,  mem_Ip, mem_Date,  mem_Address,mem_Search, mem_Code);
				String mem_No = memVO.getMem_No();
				
//3,再把mem_No放到memVO即可 取得自增主鍵
				
				System.out.println(memVO.getMem_No());
				
			
				/***************************3.新增完成,準備轉交(Send the Success view & send e-mail)***********/
				
				req.getSession().setAttribute("memVO", memVO);
				String url = "/frontdesk/mem/register_success.jsp";
				
				
				System.out.println( "字串:"+mem_Pw+ mem_Name+ mem_Id+ mem_Bday+ mem_Tel+ mem_Pho+ mem_Gend+ mem_Email+  mem_Intro+mem_Code+ mem_State+   mem_Ip+ mem_Date+  mem_Address+mem_Search);
				
			    
				/***************************mail區塊 2***************************************/
			    
			    
			    MailService mailService = new MailService();
			    mailService.sendMail(to, subject, messageText);
				
				/***************************mail區塊 2***************************************/
			    
			    
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				
				
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mem/register.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		if("memAuthentication".equals(action)){
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				MemVO memVO =(MemVO)req.getSession().getAttribute("memVO");
				
//				String mem_No = new String(req.getParameter("mem_No").trim());
				String mem_Id = memVO.getMem_Id();
				String mem_Email = memVO.getMem_Email();
				System.out.println(memVO.getMem_Email());
				System.out.println(memVO.getMem_Code());
				
				
//				System.out.println("memVO.mem_No :"+ memVO.getMem_No());
				
						
						
				Integer mem_UserCode = new Integer(req.getParameter("mem_UserCode").trim());
						
				if (memVO.getMem_Code().equals(mem_UserCode)){
							
						memVO.setMem_State(1);
						memVO.setMem_Id(mem_Id);
//						memVO.setMem_No(mem_No);
						memVO.setMem_Email(mem_Email);
							System.out.println("----------------123:"+mem_Id);
							
						MemService memSvc = new MemService();
						
						memVO = memSvc.memAuthentication(memVO);
							
						System.out.println("----------------456:"+mem_Id);
						System.out.println("----------------456:"+memVO.getMem_Code());
						
//						System.out.println("----------------memVO1 :"+memVO1.getMem_No());
//						System.out.println("----------------memVO1 :"+memVO1.getMem_Email());
//						System.out.println("----------------memVO1 :"+memVO1.getMem_Date());
//						System.out.println("----------------memVO1 :"+memVO1.getMem_Id());
			
						String url = "/frontdesk/mem/register_success.jsp";
						
						
						req.getSession().setAttribute("memVO", memVO);
							
						RequestDispatcher successView = req.getRequestDispatcher(url);
						successView.forward(req, res);
					} else {
							
							errorMsgs.add("您的會員驗證碼有誤，請重新輸入");
							RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mem/memAuthentication.jsp");
							failureView.forward(req, res);
							
						}
						
			
				} catch (Exception e){
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mem/memAuthentication.jsp");
					failureView.forward(req, res);
				}
			}
		
		
		
		
		
		if ("updateByMem".equals(action)){// 來自update_emp_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_No = new String(req.getParameter("mem_No").trim());
				System.out.println(mem_No);
				
				
				String mem_Pw = req.getParameter("mem_Pw").trim();
				if (mem_Pw == null || mem_Pw.trim().length() == 0){
					errorMsgs.add("密碼請勿空白");
				}
				
				String mem_Name = req.getParameter("mem_Name");
				String mem_Name_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (mem_Name == null || mem_Name.trim().length() == 0){
					errorMsgs.add("會員姓名: 請勿空白");
				}else if(!mem_Name.trim().matches(mem_Name_reg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員姓名: 只能是中、英文字母、數字和_ , 且長度必須在2到10之間");					
				}
				
				String mem_Id = req.getParameter("mem_Id").trim();
				if (mem_Id == null || mem_Id.trim().length() == 0){
					errorMsgs.add("暱稱請勿空白");
				}
				
				Date mem_Bday =null;
				try{
					mem_Bday = Date.valueOf(req.getParameter("mem_Bday").trim());
//System.out.println("BDAY");					
					
				} catch (IllegalArgumentException e) {
//System.out.println("CATCH_DAY");	
					mem_Bday = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期 ! ");
				}
				
				String mem_Tel = req.getParameter("mem_Tel");
				String mem_Tel_reg = "^[0-9+-]{9,12}$";
				if (mem_Tel == null || mem_Tel.trim().length() == 0){
					errorMsgs.add("市話號碼: 請勿空白");
				}else if(!mem_Tel.trim().matches(mem_Tel_reg)) { 
				errorMsgs.add("市話號碼: 只能是數字和-+ , 且長度必須在9到10之間 ，EX:06-3345678");
				}
				
				String mem_Pho = req.getParameter("mem_Pho");
				String mem_Pho_reg = "^09[0-9]{2}-[0-9]{6}$";
				if (mem_Pho == null || mem_Pho.trim().length() == 0){
					errorMsgs.add("手機號碼: 請勿空白");
				}else if(!mem_Pho.trim().matches(mem_Pho_reg)) {
				errorMsgs.add("手機號碼: 只能是數字和- , 且長度必須在10碼 ，EX:0988-988988");
				}
				
				
				Integer mem_Gend;
				try{
				mem_Gend = new Integer(req.getParameter("mem_Gend").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入性別 !");
					mem_Gend = null;
					errorMsgs.add("性別: 只能1 或 2 或 3  (1.男; 2.女 ; 3.其他");
				}
				
				String mem_Email = req.getParameter("mem_Email");
				String mem_Email_reg = "^[a-zA-Z0-9_]{3,15}@[a-zA-Z]{2,7}.[a-zA-Z.]{3,7}$";
				if (mem_Email ==null || mem_Email.trim().length() ==0){
					errorMsgs.add("E-mail請勿空白");
				}else if (!mem_Email.trim().matches(mem_Email_reg)){
				errorMsgs.add("請正確輸入E-mail");
				}
				
				
//				res.setContentType("image/*");
//				ServletOutputStream out = res.getOutputStream();
//				String action1 = req.getParameter("action1");
//				
//				byte mem_Pic = req.getParameter(mem_Pic);
				
				String mem_Intro = req.getParameter("mem_Intro");
				if (mem_Intro == null || mem_Intro.trim().length() ==0){
					errorMsgs.add("自我介紹請勿空白");
				}else if (mem_Intro == null || mem_Intro.trim().length() <10){
					errorMsgs.add("自我介少請超過10個字");
				}
				
				
				String City = req.getParameter("City2");
				String Area = req.getParameter("Area2");
				String ZIP = req.getParameter("ZIP");
				String mem_Address = req.getParameter("mem_Address");
				String real_mem_Address = ZIP +City + Area + mem_Address;
//				System.out.println("real_mem_Address :" +real_mem_Address);
				
				String mem_Address_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{10,30}$";
				if (real_mem_Address == null || real_mem_Address.trim().length() == 0){
					errorMsgs.add("請輸入地址 ! ");
				} else if(!real_mem_Address.trim().matches(mem_Address_reg)){
					errorMsgs.add("請正確輸入地址格式 ! ");
				}
				
				Integer mem_Search = null;
				try{
					mem_Search = new Integer(req.getParameter("mem_Search").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確數字 (0.不願意被搜尋 , 1.可以被搜尋");
				}
				
				
				
				
				MemVO memVO = new MemVO();
				
				Part part = req.getPart("mem_Pic");
				InputStream is = part.getInputStream();
				byte[] buffer_update = new byte[is.available()];
				
				if (buffer_update.length ==0){
				MemService memSvc = new MemService();
				MemVO memVO1 = memSvc.getOneMem(mem_No);
				buffer_update = memVO1.getMem_Pic();
				}
				is.read(buffer_update);
				is.close();
//System.out.println(buffer_update);
				
				memVO.setMem_No(mem_No);
				memVO.setMem_Pw(mem_Pw);
				memVO.setMem_Name(mem_Name);
				memVO.setMem_Id(mem_Id);
				memVO.setMem_Bday(mem_Bday);
				memVO.setMem_Tel(mem_Tel);
				memVO.setMem_Pho(mem_Pho);
				memVO.setMem_Gend(mem_Gend);
				memVO.setMem_Email(mem_Email);
				memVO.setMem_Pic(buffer_update);
				memVO.setMem_Intro(mem_Intro);
//				memVO.setMem_Code(mem_Code);
//				memVO.setMem_State(mem_State);
//				memVO.setMem_Gps_Lat(mem_Gps_Lat);
//				memVO.setMem_Gps_Lng(mem_Gps_Lng);
//				memVO.setMem_Ip(mem_Ip);
//				memVO.setMem_Date(mem_Date);
//				memVO.setMission_Count(mission_Count);
				memVO.setMem_Address(mem_Address);
				memVO.setMem_Search(mem_Search);
//				memVO.setMem_Point(mem_Point);
				req.setAttribute("City2", City);
				req.setAttribute("Area2", Area);
				req.setAttribute("ZIP", ZIP);
//				req.setAttribute("mem_Address", mem_Address);
				System.out.println("City2 + " +City);
				System.out.println("Area2 + " +Area);
				
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("memVO", memVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mem/memUpdateFile.jsp");
					failureView.forward(req, res);
					return;
				}
				
System.out.println("STEP1");				
				/***************************2.開始新增資料***************************************/
				MemService memSvc = new MemService();
				memVO = memSvc.updateByMem(mem_No,mem_Pw, mem_Name, mem_Id, mem_Bday, mem_Tel, mem_Pho, mem_Gend, mem_Email, buffer_update, mem_Intro, real_mem_Address,mem_Search);
				
System.out.println("STEP2");				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.getSession().setAttribute("memVO", memVO);
				String updateSuccess = "ok";
				req.setAttribute("updateSuccess", updateSuccess);
				String url = "/frontdesk/mem/memUpdateFile.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
System.out.println("STEP3");
				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				e.printStackTrace();
				errorMsgs.add("修改資料失敗 :" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mem/memUpdateFile.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		if ("getOne_For_Display".equals(action)){
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("mem_No");
				if(str == null || (str.trim()).length() == 0){
					errorMsgs.add("請輸入會員編號");
				}
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/mem/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String mem_No = null;
				try{
					mem_No = new String(str);
				} catch (Exception e) {
					errorMsgs.add("會員號碼格式不正確");
				}
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/mem/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料*****************************************/
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.getOneMem(mem_No);
				if (memVO == null) {
					errorMsgs.add("查無資料");
				}
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/mem/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				
				req.setAttribute("memVO", memVO);
				String url = "/mem/listOneMem.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
				
			} catch (Exception e){
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView =req.getRequestDispatcher("/mem/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)){// 來自listAllEmp.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數****************************************/
				
				String mem_No = new String(req.getParameter("mem_No"));
				
				/***************************2.開始查詢資料****************************************/
				
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.getOneMem(mem_No);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				
				req.setAttribute("memVO", memVO);
				String url = "/mem/update_mem_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
				
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/mem/listAllMem.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)){// 來自update_emp_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_No = new String(req.getParameter("mem_No").trim());
				
				String mem_Pw = req.getParameter("mem_Pw").trim();
				if (mem_Pw == null || mem_Pw.trim().length() == 0){
					errorMsgs.add("密碼請勿空白");
				}
				
				String mem_Name = req.getParameter("mem_Name");
				String mem_Name_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (mem_Name == null || mem_Name.trim().length() == 0){
					errorMsgs.add("會員姓名: 請勿空白");
				}else if(!mem_Name.trim().matches(mem_Name_reg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員姓名: 只能是中、英文字母、數字和_ , 且長度必須在2到10之間");					
				}
				
				String mem_Id = req.getParameter("mem_Id").trim();
				if (mem_Id == null || mem_Id.trim().length() == 0){
					errorMsgs.add("暱稱請勿空白");
				}
				
				Date mem_Bday =null;
				try{
					mem_Bday = Date.valueOf(req.getParameter("mem_Bday").trim());
//System.out.println("BDAY");					
					
				} catch (IllegalArgumentException e) {
//System.out.println("CATCH_DAY");	
					mem_Bday = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期 ! ");
				}
				
				String mem_Tel = req.getParameter("mem_Tel");
				String mem_Tel_reg = "^[0-9+-]{9,12}$";
				if (mem_Tel == null || mem_Tel.trim().length() == 0){
					errorMsgs.add("市話號碼: 請勿空白");
				}else if(!mem_Tel.trim().matches(mem_Tel_reg)) { 
				errorMsgs.add("市話號碼: 只能是數字和-+ , 且長度必須在9到10之間 ，EX:06-3345678");
				}
				
				String mem_Pho = req.getParameter("mem_Pho");
				String mem_Pho_reg = "^09[0-9]{2}-[0-9]{6}$";
				if (mem_Pho == null || mem_Pho.trim().length() == 0){
					errorMsgs.add("手機號碼: 請勿空白");
				}else if(!mem_Pho.trim().matches(mem_Pho_reg)) {
				errorMsgs.add("手機號碼: 只能是數字和- , 且長度必須在10碼 ，EX:0988-988988");
				}
				
				
				Integer mem_Gend;
				try{
				mem_Gend = new Integer(req.getParameter("mem_Gend").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入性別 !");
					mem_Gend = null;
					errorMsgs.add("性別: 只能1 或 2 或 3  (1.男; 2.女 ; 3.其他");
				}
				
				String mem_Email = req.getParameter("mem_Email");
				String mem_Email_reg = "^[a-zA-Z0-9_]{3,15}@[a-zA-Z]{2,7}.[a-zA-Z.]{3,7}$";
				if (mem_Email ==null || mem_Email.trim().length() ==0){
					errorMsgs.add("E-mail請勿空白");
				}else if (!mem_Email.trim().matches(mem_Email_reg)){
				errorMsgs.add("請正確輸入E-mail");
				}
				
				
//				res.setContentType("image/*");
//				ServletOutputStream out = res.getOutputStream();
//				String action1 = req.getParameter("action1");
//				
//				byte mem_Pic = req.getParameter(mem_Pic);
				
				String mem_Intro = req.getParameter("mem_Intro");
				if (mem_Intro == null || mem_Intro.trim().length() ==0){
					errorMsgs.add("自我介紹請勿空白");
				}else if (mem_Intro == null || mem_Intro.trim().length() <10){
					errorMsgs.add("自我介少請超過10個字");
				}
				
				Integer mem_Code = null;
				try{
					mem_Code = new Integer(req.getParameter("mem_Code").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請正確輸入驗證碼 ! ");
				}
				
				//後端調整狀態用
				Integer mem_State = null;
				try{
					mem_State = new Integer(req.getParameter("mem_State").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入 0 或 1 或 2 (0.未驗證會員 ; 1.普通會員 ; 2.黃金會員");
				}
				
				Double mem_Gps_Lat = null;
				try{
				mem_Gps_Lat = new Double (req.getParameter("mem_Gps_Lat").trim());
//				Double mem_Gps_Lat_reg =  "^[0-9]{2,3}.[0-9]{6}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確格式的經度");
				}
			 
				Double mem_Gps_Lng = null;
				try{
				mem_Gps_Lng = new Double (req.getParameter("mem_Gps_Lng").trim());
	//			Double mem_Gps_Lat_reg =  "^[0-9]{2,3}.[0-9]{6}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確格式的緯度");
				}
				
				String mem_Ip = req.getParameter("mem_Ip");
				String mem_Ip_reg =  "^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$";
				if (!mem_Ip.trim().matches(mem_Ip_reg)){
					errorMsgs.add("請輸入正確ip位置");
				}
				
				Date mem_Date;
				try{
					mem_Date = Date.valueOf(req.getParameter("mem_Date").trim());
					
				} catch (IllegalArgumentException e) {
					mem_Date = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期 ! ");
				}
				
				Integer mission_Count = null;
				try{
					mission_Count = new Integer(req.getParameter("mission_Count").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確任務次數數字 ! ");
				}
				
				String mem_Address = req.getParameter("mem_Address");
				String mem_Address_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{15,30}$";
				if (mem_Address == null || mem_Address.trim().length() == 0){
					errorMsgs.add("請輸入地址 ! ");
				} else if(!mem_Address.trim().matches(mem_Address_reg)){
					errorMsgs.add("請正確輸入地址格式 ! ");
				}
				
				Integer mem_Search = null;
				try{
					mem_Search = new Integer(req.getParameter("mem_Search").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確數字 (0.不願意被搜尋 , 1.可以被搜尋");
				}
				
				Integer mem_Point = null;
				try{
					mem_Point = new Integer(req.getParameter("mem_Point").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入積分數字");
				}
				
				
				MemVO memVO = new MemVO();
				
				Part part = req.getPart("mem_Pic");
				InputStream is = part.getInputStream();
				byte[] buffer_update = new byte[is.available()];
				is.read(buffer_update);
				
//System.out.println(buffer_update);
				
				memVO.setMem_No(mem_No);
				memVO.setMem_Pw(mem_Pw);
				memVO.setMem_Name(mem_Name);
				memVO.setMem_Id(mem_Id);
				memVO.setMem_Bday(mem_Bday);
				memVO.setMem_Tel(mem_Tel);
				memVO.setMem_Pho(mem_Pho);
				memVO.setMem_Gend(mem_Gend);
				memVO.setMem_Email(mem_Email);
				memVO.setMem_Pic(buffer_update);
				memVO.setMem_Intro(mem_Intro);
				memVO.setMem_Code(mem_Code);
				memVO.setMem_State(mem_State);
				memVO.setMem_Gps_Lat(mem_Gps_Lat);
				memVO.setMem_Gps_Lng(mem_Gps_Lng);
				memVO.setMem_Ip(mem_Ip);
				memVO.setMem_Date(mem_Date);
				memVO.setMission_Count(mission_Count);
				memVO.setMem_Address(mem_Address);
				memVO.setMem_Search(mem_Search);
				memVO.setMem_Point(mem_Point);
				
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("memVO", memVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mem/memUpdateFile.jsp");
					failureView.forward(req, res);
					return;
				}
				
System.out.println("STEP1");				
				/***************************2.開始新增資料***************************************/
				MemService memSvc = new MemService();
				memVO = memSvc.updateMem(mem_No,mem_Pw, mem_Name, mem_Id, mem_Bday, mem_Tel, mem_Pho, mem_Gend, mem_Email, buffer_update, mem_Intro, mem_Code, mem_State, mem_Gps_Lat, mem_Gps_Lng, mem_Ip, mem_Date, mission_Count, mem_Address,mem_Search,mem_Point);
System.out.println("STEP2");				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("memVO", memVO);
				String url = "/frontdesk/mem/memUpdateFile.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
System.out.println("STEP3");
				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				e.printStackTrace();
				errorMsgs.add("修改資料失敗 :" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/mem/update_mem_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		
		
		
		
		if ("insert".equals(action)){// 來自addMem.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				String mem_No = new String(req.getParameter("mem_No").trim());
				
				String mem_Pw = req.getParameter("mem_Pw").trim();
				if (mem_Pw == null || mem_Pw.trim().length() == 0){
					errorMsgs.add("密碼請勿空白");
				}
				
				String mem_Name = req.getParameter("mem_Name");
				String mem_Name_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (mem_Name == null || mem_Name.trim().length() == 0){
					errorMsgs.add("員工姓名: 請勿空白");
				}else if(!mem_Name.trim().matches(mem_Name_reg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員姓名: 只能是中、英文字母、數字和_ , 且長度必須在2到10之間");					
				}
				
				String mem_Id = req.getParameter("mem_Id").trim();
				if (mem_Id == null || mem_Id.trim().length() == 0){
					errorMsgs.add("暱稱請勿空白");
				}
				
				Date mem_Bday =null;
				try{
					mem_Bday = Date.valueOf(req.getParameter("mem_Bday").trim());
				} catch (IllegalArgumentException e) {
					mem_Bday = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期 ! ");
				}
				
				String mem_Tel = req.getParameter("mem_Tel");
				String mem_Tel_reg = "^[0-9+-]{9,12}$";
				if (mem_Tel == null || mem_Tel.trim().length() == 0){
					errorMsgs.add("市話號碼: 請勿空白");
				}else if(!mem_Tel.trim().matches(mem_Tel_reg)) { 
				errorMsgs.add("市話號碼: 只能是數字和-+ , 且長度必須在9到10之間 ，EX:06-3345678");
				}
				
				
				String mem_Pho = req.getParameter("mem_Pho");
				String mem_Pho_reg = "^09[0-9]{2}-[0-9]{6}$";
				if (mem_Pho == null || mem_Pho.trim().length() == 0){
					errorMsgs.add("手機號碼: 請勿空白");
				}else if(!mem_Pho.trim().matches(mem_Pho_reg)) {
				errorMsgs.add("手機號碼: 只能是數字和- , 且長度必須在10碼 ，EX:0988-988988");
				}
				
				
				Integer mem_Gend;
				try{
				mem_Gend = new Integer(req.getParameter("mem_Gend").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入性別 !");
					mem_Gend = null;
					errorMsgs.add("性別: 只能1 或 2 或 3  (1.男; 2.女 ; 3.其他");
				}
				
				String mem_Email = req.getParameter("mem_Email");
				String mem_Email_reg = "^[a-zA-Z0-9_]{3,15}@[a-zA-Z]{2,7}.[a-zA-Z.]{3,7}$";
				if (mem_Email ==null || mem_Email.trim().length() ==0){
					errorMsgs.add("E-mail請勿空白");
				}else if (!mem_Email.trim().matches(mem_Email_reg)){
				errorMsgs.add("請正確輸入E-mail");
				}
				
				
//				res.setContentType("image/*");
//				ServletOutputStream out = res.getOutputStream();
//				String action1 = req.getParameter("action1");
//				
				
				
				
				String mem_Intro = req.getParameter("mem_Intro");
				if (mem_Intro == null || mem_Intro.trim().length() ==0){
					errorMsgs.add("自我介紹請勿空白");
				}else if (mem_Intro == null || mem_Intro.trim().length() <10){
					errorMsgs.add("自我介少請超過10個字");
				}
				
				Integer mem_Code = null;
				try{
					mem_Code = new Integer(req.getParameter("mem_Code").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請正確輸入驗證碼 ! ");
				}
				
				//後端調整狀態用
				Integer mem_State = null;
				try{
					mem_State = new Integer(req.getParameter("mem_State").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入 0 或 1 或 2 (0.未驗證會員 ; 1.普通會員 ; 2.黃金會員");
				}
				
				
				Double mem_Gps_Lat = null;
				try{
				mem_Gps_Lat = new Double (req.getParameter("mem_Gps_Lat").trim());
//				Double mem_Gps_Lat_reg =  "^[0-9]{2,3}.[0-9]{6}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確格式的經度");
				}
			 
				Double mem_Gps_Lng = null;
				try{
				mem_Gps_Lng = new Double (req.getParameter("mem_Gps_Lng").trim());
	//			Double mem_Gps_Lat_reg =  "^[0-9]{2,3}.[0-9]{6}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確格式的緯度");
				}
				
				String mem_Ip = req.getParameter("mem_Ip");
				String mem_Ip_reg =  "^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$";
				if (!mem_Ip.trim().matches(mem_Ip_reg)){
					errorMsgs.add("請輸入正確ip位置");
				}
				
				Date mem_Date;
				try{
					mem_Date = Date.valueOf(req.getParameter("mem_Date").trim());
					
				} catch (IllegalArgumentException e) {
					mem_Date = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期 ! ");
				}
				
				Integer mission_Count = null;
				try{
					mission_Count = new Integer(req.getParameter("mission_Count").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確任務次數數字 ! ");
				}
				
				String mem_Address = req.getParameter("mem_Address");
				String mem_Address_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{15,30}$";
				if (mem_Address == null || mem_Address.trim().length() == 0){
					errorMsgs.add("請輸入地址 ! ");
				} else if(!mem_Address.trim().matches(mem_Address_reg)){
					errorMsgs.add("請正確輸入地址格式 !  ");
				}
				
				Integer mem_Search = null;
				try{
					mem_Search = new Integer(req.getParameter("mem_Search").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確數字 (0.不願意被搜尋 , 1.可以被搜尋");
				}
				
				Integer mem_Point = null;
				try{
					mem_Point = new Integer(req.getParameter("mem_Point").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入積分數字");
				}
				
				
				MemVO memVO = new MemVO();
				Part part = req.getPart("mem_Pic");
				InputStream is = part.getInputStream();
				byte[] buffer = new byte[is.available()];
				is.read(buffer);
				

				memVO.setMem_Pw(mem_Pw);
				memVO.setMem_Name(mem_Name);
				memVO.setMem_Id(mem_Id);
				memVO.setMem_Bday(mem_Bday);
				memVO.setMem_Tel(mem_Tel);
				memVO.setMem_Pho(mem_Pho);
				memVO.setMem_Gend(mem_Gend);
				memVO.setMem_Email(mem_Email);
				memVO.setMem_Pic(buffer);
				memVO.setMem_Intro(mem_Intro);
				memVO.setMem_Code(mem_Code);
				memVO.setMem_State(mem_State);
				memVO.setMem_Gps_Lat(mem_Gps_Lat);
				memVO.setMem_Gps_Lng(mem_Gps_Lng);
				memVO.setMem_Ip(mem_Ip);
				memVO.setMem_Date(mem_Date);
				memVO.setMission_Count(mission_Count);
				memVO.setMem_Address(mem_Address);
				memVO.setMem_Search(mem_Search);
				memVO.setMem_Point(mem_Point);
				
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("memVO", memVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/mem/addMem.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				/***************************2.開始新增資料***************************************/
				MemService memSvc = new MemService();
				memVO = memSvc.addMem(mem_Pw, mem_Name, mem_Id, mem_Bday, mem_Tel, mem_Pho, mem_Gend, mem_Email, buffer, mem_Intro, mem_Code, mem_State, mem_Gps_Lat, mem_Gps_Lng, mem_Ip, mem_Date, mission_Count, mem_Address,mem_Search,mem_Point);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				req.setAttribute("memVO", memVO);
				String url = "/mem/listAllMem.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/mem/addMem.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		
		if("delete".equals(action)){
			List<String> errorMsgs =new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數***************************************/
				String mem_No = req.getParameter("mem_No");
				
				/***************************2.開始刪除資料***************************************/
				MemService memSvc = new MemService();
				memSvc.deleteMem(mem_No);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				String url = "/mem/listAllMem.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗 : "+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/mem/listAllMem.jsp");
				failureView.forward(req, res);
			}
		}
	}	
}
