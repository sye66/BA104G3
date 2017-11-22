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

import com.android.model.Follow_tmDAO;
import com.android.model.Follow_tmService;
import com.android.model.Follow_tmVO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.android.model.MemService;
import com.android.model.MemVO;
import com.android.model.RelationDAO;
import com.android.model.RelationService;
import com.android.model.RelationVO;

@WebServlet("/FollowServlet")
public class FollowServlet extends HttpServlet{

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
		
		Follow_tmService follow_tmSvc = new Follow_tmService();
		Follow_tmDAO follow_tmDAO = new Follow_tmDAO();
		
		RelationDAO relationDAO = new RelationDAO();
		RelationService relationSvc = new RelationService();
		

		if ("getOne_For_Display".equals(action)){
			
			
		} //getOne_For_Display end
		
		
		
		if ("getAll_For_Display".equals(action)){ // android 顯示關注
			String mem_No = jsonObject.get("mem_No").getAsString();
			System.out.println("getAll_For_Display: "+mem_No);
			List<Follow_tmVO> followList = follow_tmSvc.getAllDependOnFollower_mem_no(mem_No);
			System.out.println("followList "+ followList);
			writeText(res, gson.toJson(followList));
			
			
		} //getAll_For_Display end
		
		
		
		if ("getAddFriend_For_Display".equals(action)){
			
		}
		
		
		if ("getOne_For_Update".equals(action)){// 來自listAllStored.jsp的請求
			
		} //getOne_For_Update end
		

		
		if ("update".equals(action)){// 來自update_stored_input.jsp的請求
			Integer follow_Status = jsonObject.get("follow_Status").getAsInt();
			String follower_Mem_No = jsonObject.get("follower_Mem_No").getAsString();
			String followed_Mem_No = jsonObject.get("followed_Mem_No").getAsString();
			follow_tmSvc.updateFollow_tmVO(follower_Mem_No, followed_Mem_No, follow_Status);
		} //update end
		
		if ("insert".equals(action)){// 來自addStored.jsp的請求
			Integer follow_Status = 0;
			String follower_Mem_No = jsonObject.get("follower_Mem_No").getAsString();
			String followed_Mem_No = jsonObject.get("followed_Mem_No").getAsString();
			follow_tmSvc.addFollow_tmVO(follower_Mem_No, followed_Mem_No, follow_Status);
		} //insert end
		
		
		if("delete".equals(action)){ //android 刪除好友
			String follower_Mem_No = jsonObject.get("follower_Mem_No").getAsString();
			String followed_Mem_No = jsonObject.get("followed_Mem_No").getAsString();
			follow_tmSvc.deleteFollow_tmVO(follower_Mem_No, followed_Mem_No);
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