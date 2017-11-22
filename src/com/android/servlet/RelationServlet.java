package com.android.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
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
import com.android.model.MemService;
import com.android.model.MemVO;
import com.android.model.RelationDAO;
import com.android.model.RelationService;
import com.android.model.RelationVO;

@WebServlet("/RelationServlet")
public class RelationServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
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
		String action = jsonObject.get("action").getAsString();
		
		RelationDAO relationDAO = new RelationDAO();
		RelationService relationSvc = new RelationService();
		
		if ("get_Who_Addme".equals(action)){
			String related_Mem_No = jsonObject.get("related_Mem_No").getAsString();
			relationSvc.getWhoAddme(related_Mem_No);
		} //getOne_For_Display end

		if ("getOne_For_Display".equals(action)){
			
			
		} //getOne_For_Display end
		
		
		
		if ("getAll_For_Display".equals(action)){ // android 顯示好友
			String mem_No = jsonObject.get("mem_No").getAsString();
			List<RelationVO> friendList= relationSvc.getAllRelationWithMem_No(mem_No);
			writeText(res, gson.toJson(friendList));
			
			
		} //getOne_For_Display end
		
		
		if ("getFriend_For_Display".equals(action)){ //android 顯示好友
			String mem_No = jsonObject.get("mem_No").getAsString();
			List<RelationVO> friendList= relationSvc.getAllFriendWithMem_No(mem_No);
			writeText(res, gson.toJson(friendList));
			
			
		} //getOne_For_Display end
		
		
		if ("getAddFriend_For_Display".equals(action)){ //android 顯示新增好友
			String mem_No = jsonObject.get("mem_No").getAsString();
			List<RelationVO> friendList= relationDAO.getAddFriendWithMem_No(mem_No);
			writeText(res, gson.toJson(friendList));
		}
		
		
		if ("getOne_For_Update".equals(action)){// 來自listAllStored.jsp的請求
			
		} //getOne_For_Update end
		

		
		if ("update".equals(action)){// 來自update_stored_input.jsp的請求
			Integer relation_Status = 1;
			String mem_No = jsonObject.get("mem_No").getAsString();
			String related_Mem_No = jsonObject.get("related_Mem_No").getAsString();
			relationSvc.updaterelationVO(mem_No, related_Mem_No, relation_Status);
		} //update end
		
		if ("insert".equals(action)){// 來自addStored.jsp的請求
			Integer relation_Status = 1;
			String mem_No = jsonObject.get("mem_No").getAsString();
			String related_Mem_No = jsonObject.get("related_Mem_No").getAsString();
			relationSvc.addRelationVO(mem_No, related_Mem_No, relation_Status);
		} //insert end
		
		if ("insertAndUpdate".equals(action)){// android 回覆接受好友
			Integer relation_Status = 1;
			String mem_No = jsonObject.get("mem_No").getAsString();
			String related_Mem_No = jsonObject.get("related_Mem_No").getAsString();
			relationSvc.addRelationVO(mem_No, related_Mem_No, relation_Status);
			relationSvc.updaterelationVO(related_Mem_No, mem_No, relation_Status);
		} //insert end
		
		if ("insertNew".equals(action)){// android 新增好友
			Integer relation_Status = 0;
			String mem_No = jsonObject.get("mem_No").getAsString();
			String related_Mem_No = jsonObject.get("related_Mem_No").getAsString();
			relationSvc.addRelationVO(mem_No, related_Mem_No, relation_Status);
		} //insert end
		
		
		if("delete".equals(action)){ //android 刪除好友
			String mem_No = jsonObject.get("mem_No").getAsString();
			String related_Mem_No = jsonObject.get("related_Mem_No").getAsString();
			relationSvc.deleteRelationVO(mem_No, related_Mem_No);
			relationSvc.deleteRelationVO(related_Mem_No , mem_No);
		}// delete end\
		System.out.println("==========end");
		
		
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