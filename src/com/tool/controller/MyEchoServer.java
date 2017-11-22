package com.tool.controller;
import java.io.*;
import java.util.*;
import com.mem.model.*;

import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.Session;
import javax.websocket.OnOpen;
import javax.websocket.OnMessage;
import javax.websocket.OnError;
import javax.websocket.OnClose;
import javax.websocket.CloseReason;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;




	// 對照clinet 的 servername / 使用者名稱 / 房號		記得要先匯入jar檔
@ServerEndpoint("/MyEchoServer/{myName}/{myRoom}")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MyEchoServer extends HttpServlet{
	
private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
	
@OnOpen
	public void onOpen(@PathParam("myName") String myName, @PathParam("myRoom") int myRoom, Session userSession) throws IOException {
	
	//	(3)	把資訊存到allSession 的集合裡面 ,便且顯示
		allSessions.add(userSession);
		System.out.println(userSession.getId() + ": 已連線");
		System.out.println(myName + ": 已連線");
		System.out.println(myRoom + ": 房號");
//		userSession.getBasicRemote().sendText("WebSocket 連線成功");
	}

	// (5) 把userSession 跟 message存到 非同步的遙控器(主要是在前一封訊息還蠻傳送完成,不能傳下一封)
@OnMessage
	public void onMessage(Session userSession, String message) {
		for (Session session : allSessions) {
			if (session.isOpen())
//				this.doPost(req, res);
				session.getAsyncRemote().sendText(message);
		}
		System.out.println("Message received: " + message);
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
//		e.printStackTrace();
	}
	
	// (8) 收到哪個使用者的userSession ,機關閉內容 ,將使用者Session移除
@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		allSessions.remove(userSession);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}

public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
	doPost(req, res);
}

public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {


	String mem_No = req.getParameter("memno");
	
	
}
}
