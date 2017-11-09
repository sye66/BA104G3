package com.mem.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Date;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.mem.model.MemDAO;
import com.mem.model.MemJDBCDAO;
import com.mem.model.MemService;
import com.mem.model.MemVO;

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
				String mem_email = req.getParameter("mem_email");
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.loginMem(mem_email);
				
				String mem_email_reg = "^[a-zA-Z0-9_]{3,15}@[a-zA-Z]{2,7}.[a-zA-Z.]{3,7}$";
				if (mem_email ==null || mem_email.trim().length() ==0){
					errorMsgs.add("E-mail請勿空白");
				} else if (!mem_email.trim().matches(mem_email_reg)){
				errorMsgs.add("請正確輸入E-mail");
				} else if (memVO == null){
					errorMsgs.add("查無此E-mail");
					
				}
				
				String mem_pw = req.getParameter("mem_pw").trim();
				
//				System.out.println("資料庫 :" + mem_pw);
//				System.out.println("使用者輸入 :" + memVO.getMem_pw());
				
				if (mem_pw == null || mem_pw.trim().length() == 0){
					errorMsgs.add("密碼請勿空白");
				} else if(!(memVO.getMem_pw().equals(mem_pw))){
					errorMsgs.add("密碼錯誤");
				}
				
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/mem/errorPage.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料*****************************************/
				req.getSession().setAttribute("login_memVO", memVO);
				
				
				
				String url = "/mem/index.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			 /***************************其他可能的錯誤處理*************************************/
			
		} catch (Exception e){
			errorMsgs.add("無法取得資料:" + e.getMessage());
			RequestDispatcher failureView =req.getRequestDispatcher("/frontdesk/mem/errorPage.jsp");
			failureView.forward(req, res);
		}
	}
	
		
		if ("logoutServlet".equals(action)){
			req.getSession().invalidate();
			
			String url = "/mem/index.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			
		}


				
		
		
		if ("getOne_For_Display".equals(action)){
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("mem_no");
				if(str == null || (str.trim()).length() == 0){
					errorMsgs.add("請輸入會員編號");
				}
				
				if (!errorMsgs.isEmpty()){
					RequestDispatcher failureView = req.getRequestDispatcher("/mem/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String mem_no = null;
				try{
					mem_no = new String(str);
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
				MemVO memVO = memSvc.getOneMem(mem_no);
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
				
				String mem_no = new String(req.getParameter("mem_no"));
				
				/***************************2.開始查詢資料****************************************/
				
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.getOneMem(mem_no);
				
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
				String mem_no = new String(req.getParameter("mem_no").trim());
				
				String mem_pw = req.getParameter("mem_pw").trim();
				if (mem_pw == null || mem_pw.trim().length() == 0){
					errorMsgs.add("密碼請勿空白");
				}
				
				String mem_name = req.getParameter("mem_name");
				String mem_name_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (mem_name == null || mem_name.trim().length() == 0){
					errorMsgs.add("會員姓名: 請勿空白");
				}else if(!mem_name.trim().matches(mem_name_reg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員姓名: 只能是中、英文字母、數字和_ , 且長度必須在2到10之間");					
				}
				
				String mem_id = req.getParameter("mem_id").trim();
				if (mem_id == null || mem_id.trim().length() == 0){
					errorMsgs.add("暱稱請勿空白");
				}
				
				Date mem_bday =null;
				try{
					mem_bday = Date.valueOf(req.getParameter("mem_bday").trim());
					
				} catch (IllegalArgumentException e) {
					mem_bday = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期 ! ");
				}
				
				String mem_tel = req.getParameter("mem_tel");
				String mem_tel_reg = "^0[0-9]{1}-[0-9]{7,8}$";
				if (mem_tel == null || mem_tel.trim().length() == 0){
					errorMsgs.add("市話號碼: 請勿空白");
				}else if(!mem_tel.trim().matches(mem_tel_reg)) { 
				errorMsgs.add("市話號碼: 只能是數字和- , 且長度必須在9到10之間 ，EX:06-3345678");
				}
				
				String mem_pho = req.getParameter("mem_pho");
				String mem_pho_reg = "^09[0-9]{2}-[0-9]{6}$";
				if (mem_pho == null || mem_pho.trim().length() == 0){
					errorMsgs.add("手機號碼: 請勿空白");
				}else if(!mem_pho.trim().matches(mem_pho_reg)) {
				errorMsgs.add("手機號碼: 只能是數字和- , 且長度必須在10碼 ，EX:0988-988988");
				}
				
				
				Integer mem_gend;
				try{
				mem_gend = new Integer(req.getParameter("mem_gend").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入性別 !");
					mem_gend = null;
					errorMsgs.add("性別: 只能1 或 2 或 3  (1.男; 2.女 ; 3.其他");
				}
				
				String mem_email = req.getParameter("mem_email");
				String mem_email_reg = "^[a-zA-Z0-9_]{3,15}@[a-zA-Z]{2,7}.[a-zA-Z.]{3,7}$";
				if (mem_email ==null || mem_email.trim().length() ==0){
					errorMsgs.add("E-mail請勿空白");
				}else if (!mem_email.trim().matches(mem_email_reg)){
				errorMsgs.add("請正確輸入E-mail");
				}
				
				
//				res.setContentType("image/*");
//				ServletOutputStream out = res.getOutputStream();
//				String action1 = req.getParameter("action1");
//				
//				byte mem_pic = req.getParameter(mem_pic);
				
				String mem_intro = req.getParameter("mem_intro");
				if (mem_intro == null || mem_intro.trim().length() ==0){
					errorMsgs.add("自我介紹請勿空白");
				}else if (mem_intro == null || mem_intro.trim().length() <10){
					errorMsgs.add("自我介少請超過10個字");
				}
				
				Integer mem_code = null;
				try{
					mem_code = new Integer(req.getParameter("mem_code").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請正確輸入驗證碼 ! ");
				}
				
				//後端調整狀態用
				Integer mem_state = null;
				try{
					mem_state = new Integer(req.getParameter("mem_state").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入 0 或 1 或 2 (0.未驗證會員 ; 1.普通會員 ; 2.黃金會員");
				}
				
				Double mem_gps_lat = null;
				try{
				mem_gps_lat = new Double (req.getParameter("mem_gps_lat").trim());
//				Double mem_gps_lat_reg =  "^[0-9]{2,3}.[0-9]{6}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確格式的經度");
				}
			 
				Double mem_gps_lng = null;
				try{
				mem_gps_lng = new Double (req.getParameter("mem_gps_lng").trim());
	//			Double mem_gps_lat_reg =  "^[0-9]{2,3}.[0-9]{6}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確格式的緯度");
				}
				
				String mem_ip = req.getParameter("mem_ip");
				String mem_ip_reg =  "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$";
				if (!mem_ip.trim().matches(mem_ip_reg)){
					errorMsgs.add("請輸入正確ip位置");
				}
				
				Date mem_date;
				try{
					mem_date = Date.valueOf(req.getParameter("mem_date").trim());
					
				} catch (IllegalArgumentException e) {
					mem_date = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期 ! ");
				}
				
				Integer mission_count = null;
				try{
					mission_count = new Integer(req.getParameter("mission_count").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確任務次數數字 ! ");
				}
				
				String mem_address = req.getParameter("mem_address");
				String mem_address_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{15,30}$";
				if (mem_address == null || mem_address.trim().length() == 0){
					errorMsgs.add("請輸入地址 ! ");
				} else if(!mem_address.trim().matches(mem_address_reg)){
					errorMsgs.add("請正確輸入地址格式 ! ");
				}
				
				Integer mem_search = null;
				try{
					mem_search = new Integer(req.getParameter("mem_search").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確數字 (0.不願意被搜尋 , 1.可以被搜尋");
				}
				
				Integer mem_point = null;
				try{
					mem_point = new Integer(req.getParameter("mem_point").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入積分數字");
				}
				
				
				MemVO memVO = new MemVO();
				
				Part part = req.getPart("mem_pic");
				InputStream is = part.getInputStream();
				byte[] buffer_update = new byte[is.available()];
				is.read(buffer_update);
				
				memVO.setMem_no(mem_no);
				memVO.setMem_pw(mem_pw);
				memVO.setMem_name(mem_name);
				memVO.setMem_id(mem_id);
				memVO.setMem_bday(mem_bday);
				memVO.setMem_tel(mem_tel);
				memVO.setMem_pho(mem_pho);
				memVO.setMem_gend(mem_gend);
				memVO.setMem_email(mem_email);
				memVO.setMem_pic(buffer_update);
				memVO.setMem_intro(mem_intro);
				memVO.setMem_code(mem_code);
				memVO.setMem_state(mem_state);
				memVO.setMem_gps_lat(mem_gps_lat);
				memVO.setMem_gps_lng(mem_gps_lng);
				memVO.setMem_ip(mem_ip);
				memVO.setMem_date(mem_date);
				memVO.setMission_count(mission_count);
				memVO.setMem_address(mem_address);
				memVO.setMem_search(mem_search);
				memVO.setMem_point(mem_point);
				
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("memVO", memVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/mem/update_mem_input.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				/***************************2.開始新增資料***************************************/
				MemService memSvc = new MemService();
				memVO = memSvc.updateMem(mem_no,mem_pw, mem_name, mem_id, mem_bday, mem_tel, mem_pho, mem_gend, mem_email, buffer_update, mem_intro, mem_code, mem_state, mem_gps_lat, mem_gps_lng, mem_ip, mem_date, mission_count, mem_address,mem_search,mem_point);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("memVO", memVO);
				String url = "/mem/listOneMem.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e){
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
//				String mem_no = new String(req.getParameter("mem_no").trim());
				
				String mem_pw = req.getParameter("mem_pw").trim();
				if (mem_pw == null || mem_pw.trim().length() == 0){
					errorMsgs.add("密碼請勿空白");
				}
				
				String mem_name = req.getParameter("mem_name");
				String mem_name_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (mem_name == null || mem_name.trim().length() == 0){
					errorMsgs.add("員工姓名: 請勿空白");
				}else if(!mem_name.trim().matches(mem_name_reg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員姓名: 只能是中、英文字母、數字和_ , 且長度必須在2到10之間");					
				}
				
				String mem_id = req.getParameter("mem_id").trim();
				if (mem_id == null || mem_id.trim().length() == 0){
					errorMsgs.add("暱稱請勿空白");
				}
				
				Date mem_bday =null;
				try{
					mem_bday = Date.valueOf(req.getParameter("mem_bday").trim());
				} catch (IllegalArgumentException e) {
					mem_bday = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期 ! ");
				}
				
				String mem_tel = req.getParameter("mem_tel");
				String mem_tel_reg = "^0[0-9]{1}-[0-9]{7,8}$";
				if (mem_tel == null || mem_tel.trim().length() == 0){
					errorMsgs.add("市話號碼: 請勿空白");
				}else if(!mem_tel.trim().matches(mem_tel_reg)) { 
				errorMsgs.add("市話號碼: 只能是數字和- , 且長度必須在9到10之間 ，EX:06-3345678");
				}
				
				String mem_pho = req.getParameter("mem_pho");
				String mem_pho_reg = "^09[0-9]{2}-[0-9]{6}$";
				if (mem_pho == null || mem_pho.trim().length() == 0){
					errorMsgs.add("手機號碼: 請勿空白");
				}else if(!mem_pho.trim().matches(mem_pho_reg)) {
				errorMsgs.add("手機號碼: 只能是數字和- , 且長度必須在10碼 ，EX:0988-988988");
				}
				
				
				Integer mem_gend;
				try{
				mem_gend = new Integer(req.getParameter("mem_gend").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入性別 !");
					mem_gend = null;
					errorMsgs.add("性別: 只能1 或 2 或 3  (1.男; 2.女 ; 3.其他");
				}
				
				String mem_email = req.getParameter("mem_email");
				String mem_email_reg = "^[a-zA-Z0-9_]{3,15}@[a-zA-Z]{2,7}.[a-zA-Z.]{3,7}$";
				if (mem_email ==null || mem_email.trim().length() ==0){
					errorMsgs.add("E-mail請勿空白");
				}else if (!mem_email.trim().matches(mem_email_reg)){
				errorMsgs.add("請正確輸入E-mail");
				}
				
				
//				res.setContentType("image/*");
//				ServletOutputStream out = res.getOutputStream();
//				String action1 = req.getParameter("action1");
//				
				
				
				
				String mem_intro = req.getParameter("mem_intro");
				if (mem_intro == null || mem_intro.trim().length() ==0){
					errorMsgs.add("自我介紹請勿空白");
				}else if (mem_intro == null || mem_intro.trim().length() <10){
					errorMsgs.add("自我介少請超過10個字");
				}
				
				Integer mem_code = null;
				try{
					mem_code = new Integer(req.getParameter("mem_code").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請正確輸入驗證碼 ! ");
				}
				
				//後端調整狀態用
				Integer mem_state = null;
				try{
					mem_state = new Integer(req.getParameter("mem_state").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入 0 或 1 或 2 (0.未驗證會員 ; 1.普通會員 ; 2.黃金會員");
				}
				
				
				Double mem_gps_lat = null;
				try{
				mem_gps_lat = new Double (req.getParameter("mem_gps_lat").trim());
//				Double mem_gps_lat_reg =  "^[0-9]{2,3}.[0-9]{6}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確格式的經度");
				}
			 
				Double mem_gps_lng = null;
				try{
				mem_gps_lng = new Double (req.getParameter("mem_gps_lng").trim());
	//			Double mem_gps_lat_reg =  "^[0-9]{2,3}.[0-9]{6}$";
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確格式的緯度");
				}
				
				String mem_ip = req.getParameter("mem_ip");
				String mem_ip_reg =  "^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$";
				if (!mem_ip.trim().matches(mem_ip_reg)){
					errorMsgs.add("請輸入正確ip位置");
				}
				
				Date mem_date;
				try{
					mem_date = Date.valueOf(req.getParameter("mem_date").trim());
					
				} catch (IllegalArgumentException e) {
					mem_date = new Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期 ! ");
				}
				
				Integer mission_count = null;
				try{
					mission_count = new Integer(req.getParameter("mission_count").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確任務次數數字 ! ");
				}
				
				String mem_address = req.getParameter("mem_address");
				String mem_address_reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{15,30}$";
				if (mem_address == null || mem_address.trim().length() == 0){
					errorMsgs.add("請輸入地址 ! ");
				} else if(!mem_address.trim().matches(mem_address_reg)){
					errorMsgs.add("請正確輸入地址格式 !  ");
				}
				
				Integer mem_search = null;
				try{
					mem_search = new Integer(req.getParameter("mem_search").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入正確數字 (0.不願意被搜尋 , 1.可以被搜尋");
				}
				
				Integer mem_point = null;
				try{
					mem_point = new Integer(req.getParameter("mem_point").trim());
				} catch (NumberFormatException e){
					errorMsgs.add("請輸入積分數字");
				}
				
				
				MemVO memVO = new MemVO();
				Part part = req.getPart("mem_pic");
				InputStream is = part.getInputStream();
				byte[] buffer = new byte[is.available()];
				is.read(buffer);
				

				memVO.setMem_pw(mem_pw);
				memVO.setMem_name(mem_name);
				memVO.setMem_id(mem_id);
				memVO.setMem_bday(mem_bday);
				memVO.setMem_tel(mem_tel);
				memVO.setMem_pho(mem_pho);
				memVO.setMem_gend(mem_gend);
				memVO.setMem_email(mem_email);
				memVO.setMem_pic(buffer);
				memVO.setMem_intro(mem_intro);
				memVO.setMem_code(mem_code);
				memVO.setMem_state(mem_state);
				memVO.setMem_gps_lat(mem_gps_lat);
				memVO.setMem_gps_lng(mem_gps_lng);
				memVO.setMem_ip(mem_ip);
				memVO.setMem_date(mem_date);
				memVO.setMission_count(mission_count);
				memVO.setMem_address(mem_address);
				memVO.setMem_search(mem_search);
				memVO.setMem_point(mem_point);
				
				
				if (!errorMsgs.isEmpty()){
					req.setAttribute("memVO", memVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/mem/addMem.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				/***************************2.開始新增資料***************************************/
				MemService memSvc = new MemService();
				memVO = memSvc.addMem(mem_pw, mem_name, mem_id, mem_bday, mem_tel, mem_pho, mem_gend, mem_email, buffer, mem_intro, mem_code, mem_state, mem_gps_lat, mem_gps_lng, mem_ip, mem_date, mission_count, mem_address,mem_search,mem_point);
				
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
				String mem_no = req.getParameter("mem_no");
				
				/***************************2.開始刪除資料***************************************/
				MemService memSvc = new MemService();
				memSvc.deleteMem(mem_no);
				
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
