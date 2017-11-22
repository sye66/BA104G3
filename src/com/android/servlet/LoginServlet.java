package com.android.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.android.model.MemDAO;
import com.android.model.MemService;
import com.android.model.MemVO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		doPost(req, res);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//		req.setCharacterEncoding("UTF-8");
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
//		BufferedReader br = req.getReader();
//		StringBuffer jsonIn = new StringBuffer();
//		String line = null;
//		while((line = br.readLine())!=null){
//			jsonIn.append(line);
//		}
//		System.out.println("input:" + jsonIn);
//		
//		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
//		
//		MemDAO memDAO = new MemDAO();
		

		
		
		  req.setCharacterEncoding("UTF-8");
		  res.setCharacterEncoding("UTF-8");
		  res.setContentType("application/json");
		  MemDAO memDAO = new MemDAO();
		  
		  
		  String str = "";
		  StringBuilder sb = new StringBuilder();
		  BufferedReader br = new BufferedReader(new InputStreamReader(req.getInputStream()));
		  while((str=br.readLine())!=null){
		   sb.append(str);
		  }
		  System.out.println(sb.toString());
		  
		  Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		  MemVO mem=gson.fromJson(sb.toString(), MemVO.class);
		  System.out.println(mem.getMem_Email());
		  
		  
		  try{
			  MemVO memDB=memDAO.findByEmail(mem.getMem_Email());
			
			  String aaa=memDB.getMem_Email();
			  System.out.println(aaa);
			  
//			  mem.setMem_Email(memDB.getMem_Email());
//			  mem.setMem_Pw(memDB.getMem_Pw());
//			  mem.setMem_Address(memDB.getMem_Address());
//			  mem.setMem_Bday(memDB.getMem_Bday());
//			  mem.setMem_Code(memDB.getMem_Code());
//			  mem.setMem_Date(memDB.getMem_Date());
//			  mem.setMem_Gend(memDB.getMem_Gend());
//			  mem.setMem_Gps_Lat(memDB.getMem_Gps_Lat());
//			  mem.setMem_Gps_Lng(memDB.getMem_Gps_Lng());
//			  mem.setMem_Id(memDB.getMem_Id());
//			  mem.setMem_Intro(memDB.getMem_Intro());
//			  mem.setMem_Ip(memDB.getMem_Ip());
//			  mem.setMem_Name(memDB.getMem_Name());
//			  mem.setMem_No(memDB.getMem_No());
//			  mem.setMem_Pho(memDB.getMem_Pho());
//			  mem.setMem_Pic(memDB.getMem_Pic());
//			  mem.setMem_Search(memDB.getMem_Search());
//			  mem.setMem_State(memDB.getMem_State());
//			  mem.setMem_Tel(memDB.getMem_Tel());
//			  mem.setMission_Count(memDB.getMission_Count());
//			
//			  MemService memSvc = new MemService();
//			  mem = memSvc.addMem(memDB.getMem_Pw(), memDB.getMem_Name(), memDB.getMem_Id(), memDB.getMem_Bday(), memDB.getMem_Tel(), memDB.getMem_Pho(), memDB.getMem_Gend(), memDB.getMem_Email(), memDB.getMem_Pic(), memDB.getMem_Intro(), memDB.getMem_Code(), memDB.getMem_State(), memDB.getMem_Gps_Lat(), memDB.getMem_Gps_Lng(), memDB.getMem_Ip(), memDB.getMem_Date(), memDB.getMission_Count(), memDB.getMem_Address(), memDB.getMem_Search(),memDB.getMem_Point());
			  PrintWriter s = res.getWriter();
			  System.out.println(memDB.getMem_No());
			  s.println(gson.toJson(memDB));
			  s.flush();
		  } catch (Exception e) {
			  mem.setMem_Email("");
			  mem.setMem_Pw("");
			  PrintWriter s = res.getWriter();
			  s.println(gson.toJson(mem));
			  s.flush();
			  System.out.println("no the email");
		  }
		
	
		  

		
	


     }
	
}




























//package com.android.servlet;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStreamReader;
//import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.Date;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.LinkedList;
//import java.util.List;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//import com.google.gson.JsonObject;
//import com.mem.model.MemDAO;
//import com.mem.model.MemService;
//import com.mem.model.MemVO;
//import com.mission.model.MissionDAO;
//import com.mission.model.MissionVO;
//
//@WebServlet("/MemServlet")
//public class MemServlet extends HttpServlet {
//	
//	@Override
//	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//		
//		doPost(req, res);
//	}
//	
//	@Override
//	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//		req.setCharacterEncoding("UTF-8");
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
//		BufferedReader br = req.getReader();
//		StringBuffer jsonIn = new StringBuffer();
//		String line = null;
//		while ((line = br.readLine()) != null) {
//			jsonIn.append(line);
//		}
//		System.out.println("input: " + jsonIn);
//		
//		JsonObject jsonObject = gson.fromJson(jsonIn.toString(),
//				JsonObject.class);
//		MemDAO memDAO = new MemDAO();
//	
//		String action = jsonObject.get("action").getAsString();
//		System.out.println(action);
//		
//		if (action.equals("getAll")) {
//			List<MemVO> memList = memDAO.getAll();
//			System.out.println(memList);
//			writeText(res, gson.toJson(memList));
//		} else if (action.equals("findByEmail")) {
//			String mem_Email = jsonObject.get("mem_Email").getAsString();
//			MemVO mem = memDAO.findByEmail(mem_Email);
//			writeText(res, gson.toJson(mem));
//		
//	
////		}else if (action.equals("getImage")) {
////			OutputStream os = res.getOutputStream();
////			int id = jsonObject.get("id").getAsInt();
////			int imageSize = jsonObject.get("imageSize").getAsInt();
////			byte[] image = missionDAO.getImage(id);
////			if (image != null) {
////				image = ImageUtil.shrink(image, imageSize);
////				response.setContentType("image/jpeg");
////				response.setContentLength(image.length);
////			}
////			os.write(image);
////		} else if (action.equals("spotInsert") || action.equals("spotUpdate")) {
////			String spotJson = jsonObject.get("spot").getAsString();
////			Spot spot = gson.fromJson(spotJson, Spot.class);
////			String imageBase64 = jsonObject.get("imageBase64").getAsString();
////			byte[] image = Base64.getMimeDecoder().decode(imageBase64);;
////			int count = 0;
////			if (action.equals("spotInsert")) {
////				count = spotDao.insert(spot, image);
////			} else if (action.equals("spotUpdate")) {
////				count = spotDao.update(spot, image);
////			}
////			writeText(response, String.valueOf(count));
////		} else if (action.equals("spotDelete")) {
////			String spotJson = jsonObject.get("spot").getAsString();
////			Spot spot = gson.fromJson(spotJson, Spot.class);
////			int count = spotDao.delete(spot.getId());
////			writeText(response, String.valueOf(count));
////		} else if (action.equals("findById")) {
////			int id = jsonObject.get("id").getAsInt();
////			Spot spot = spotDao.findById(id);
////			writeText(response, gson.toJson(spot));
//		} else {
//			writeText(res, "");
//		}
//		
//	
//		
//	}
//		
//		private void writeText(HttpServletResponse res, String outText)
//				throws IOException {
//			res.setContentType("text/html; charset=UTF-8");
//			PrintWriter out = res.getWriter();
//			// System.out.println("outText: " + outText);
//			out.print(outText);
//			System.out.println("output: " + outText);
//		}
//	
//}
