package com.android.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.android.model.Case_CandidateService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.android.model.MemDAO;
import com.android.model.MemService;
import com.android.model.MemVO;

@WebServlet("/MemServlet")
public class MemServlet extends HttpServlet {
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		doPost(req, res);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		BufferedReader br = req.getReader();
		StringBuffer jsonIn = new StringBuffer();
		String line = null;
		while((line = br.readLine())!=null){
			jsonIn.append(line);
		}
		System.out.println("input:" + jsonIn);
		
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		
		MemDAO memDAO = new MemDAO();
		Case_CandidateService case_CandidateSvc = new Case_CandidateService();
		
		String action = jsonObject.get("action").getAsString();
		System.out.println(action);
		
		if("getAll".equals(action)) {
			List<MemVO> memList = memDAO.getAll();
			System.out.println(memList.get(0));
			writeText(res, gson.toJson(memList));
	
		} else
		if("getAllNoSelf".equals(action)) {
			String mem_No = jsonObject.get("mem_No").getAsString();
			List<MemVO> memList = memDAO.getAll(mem_No);
			System.out.println(memList.get(0));
			writeText(res, gson.toJson(memList));
		
		} else
		if ("findByEmail".equals(action)) {
			MemVO mem=gson.fromJson(jsonIn.toString(), MemVO.class);
			System.out.println(mem.getMem_Email());
			try{
				MemVO memDB=memDAO.findByEmail(mem.getMem_Email());
				MemService memSvc = new MemService();
				mem = memSvc.addMem(memDB.getMem_Pw(), memDB.getMem_Name(), memDB.getMem_Id(), memDB.getMem_Bday(), memDB.getMem_Tel(), memDB.getMem_Pho(), memDB.getMem_Gend(), memDB.getMem_Email(), memDB.getMem_Pic(), memDB.getMem_Intro(), memDB.getMem_Code(), memDB.getMem_State(), memDB.getMem_Gps_Lat(), memDB.getMem_Gps_Lng(), memDB.getMem_Ip(), memDB.getMem_Date(), memDB.getMission_Count(), memDB.getMem_Address(), memDB.getMem_Search(),memDB.getMem_Point());
				writeText(res, gson.toJson(mem));
			} catch (Exception e) {
				 mem.setMem_Email("");
				 mem.setMem_Pw("");
				 writeText(res, gson.toJson(mem) );
			     System.out.println("no the email");
			}
		}else 
		if ("findByPrimary".equals(action)) {
			String mem_No=jsonObject.get("mem_No").getAsString();
			System.out.println("mem NO: "+mem_No);
			try{
				MemVO mem = memDAO.findByPrimaryKey(mem_No);
			
				writeText(res, gson.toJson(mem));
			} catch (Exception e) {
			     System.out.println("no the mem_No");
			}
		}else 
		if (action.equals("getMem_Pic")){
			OutputStream os = res.getOutputStream();
			String mem_No = jsonObject.get("mem_No").getAsString();
			System.out.println(mem_No);
			byte[] mem_Pic = memDAO.getMem_Pic(mem_No);
			int imageSize = jsonObject.get("imageSize").getAsInt();
			if (mem_Pic != null) {
				mem_Pic = ImageUtil.shrink(mem_Pic, imageSize);
				res.setContentType("image/png");
				res.setContentLength(mem_Pic.length);
			}
			try{
				os.write(mem_Pic);
			} catch (Exception e) {
				System.out.println("¨S¹Ï®@");
			}
		} else 
		if (action.equals("insert") || action.equals("update")) {
			String memJson = jsonObject.get("mem").getAsString();
			MemVO mem = gson.fromJson(memJson, MemVO.class);
//			String imageBase64 = jsonObject.get("imageBase64").getAsString();
//			byte[] mem_Pic = Base64.getMimeDecoder().decode(imageBase64);;
//			int count = 0;
			if (action.equals("insert")) {
//				/*count =*/ memDAO.insert(mem, mem_Pic);
			} else if (action.equals("update")) {
//				/*count =*/ memDAO.update(mem, mem_Pic);
			}
//			writeText(res, String.valueOf(count));
			
		} else if (action.equals("delete")) {
			String memJson = jsonObject.get("mem").getAsString();
			MemVO mem = gson.fromJson(memJson, MemVO.class);
			/*int count =*/ memDAO.delete(mem.getMem_No());
//			writeText(response, String.valueOf(count));
		} else 
		if("getAllCandidateByMissionNo".equals(action)){
			//
			List<MemVO> case_CandidateList = new ArrayList<>();
			String missionJson = jsonObject.get("mission_No").getAsString();
			List<String> candidate_Mem_NoList= case_CandidateSvc.getAllCandidateMemNoByMissionNo(missionJson);
			for(String candidate_Mem_No:candidate_Mem_NoList){	
				case_CandidateList.add(memDAO.findByPrimaryKey(candidate_Mem_No));
			}
			writeText(res, gson.toJson(case_CandidateList));
		}else
		if ("updatePointAndMissionCount".equals(action)){
			Integer mem_Point = jsonObject.get("point").getAsInt(); 
			String mem_No = jsonObject.get("mem_No").getAsString();
			Integer mission_Count = jsonObject.get("mission_Count").getAsInt();
			memDAO.updatePointAndMissionCount(mem_Point, mission_Count, mem_No);
		}
		
		
		
		
		
	}


	private void writeText(HttpServletResponse res, String outText)
			throws IOException {
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
//		System.out.println("outText: " + outText);
		out.print(outText);
		out.flush();
//		System.out.println("output: " + outText);
	}	
		
		
}
	  
