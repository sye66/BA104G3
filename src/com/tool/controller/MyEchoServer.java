package com.tool.controller;
import java.io.*;
import java.util.*;

import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;


import com.google.gson.Gson;
import com.sun.corba.se.impl.protocol.giopmsgheaders.Message;

import javax.websocket.Session;
import javax.websocket.OnOpen;
import javax.websocket.OnMessage;
import javax.websocket.OnError;
import javax.websocket.OnClose;
import javax.websocket.CloseReason;

class MemChatRoom{
	
	//記錄會員在哪一個房間
	public static Map<String , String> mem_room = Collections.synchronizedMap(new HashMap<>());
	//記錄會員在哪一條session
	public static Map<String , MyEchoServer> mem_session = Collections.synchronizedMap(new HashMap<>());
	
}


	// 對照clinet 的 servername / 使用者名稱 / 房號		記得要先匯入jar檔
@ServerEndpoint("/MyEchoServer/{myName}/{myRoom}")
public class MyEchoServer {

	private String userName;	//會員編號
	private String roomNo;		//房間號碼	
	private Session session;	//哪條連線
	
//private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
	
@OnOpen
	public void onOpen(@PathParam("myName") String myName, @PathParam("myRoom") String myRoom, Session userSession) throws IOException {
	//	(3)	把資訊存到allSession 的集合裡面 ,便且顯示
//		allSessions.add(userSession);
		System.out.println(userSession.getId() + ": 已連線");
		System.out.println(myName + ": 已連線");
		System.out.println(myRoom + ": 房號");
//		userSession.getBasicRemote().sendText("WebSocket 連線成功");
		
		//連線時,初始化數值
		this.roomNo = myRoom;
		this.session = userSession;
		MemChatRoom.mem_room.put(myName, myRoom);
		MemChatRoom.mem_session.put(myName, this);
	}

	// (5) 把userSession 跟 message存到 非同步的遙控器(主要是在前一封訊息還蠻傳送完成,不能傳下一封)
@OnMessage
	public void onMessage(Session userSession, String message) {
		//預留之後使用
//		Gson gson = new Gson();
//		Message msg = gson.fromJson(message, Message.class);
//		System.out.println(msg.userName);
	
	
		//每個使用者都跑一次迴圈
		for(String loop : MemChatRoom.mem_room.keySet()){
			//伺服器推波到同一個房間的所有人
			if(MemChatRoom.mem_room.get(loop).equals(roomNo)){
				//假設使用者還在線上,就會收到此推播(必加,不加的話推播失敗會跳錯)
				if(MemChatRoom.mem_session.get(loop) != null && MemChatRoom.mem_session.get(loop).session.isOpen()){
					//推播給這個連線的所有人
					MemChatRoom.mem_session.get(loop).session.getAsyncRemote().sendText(message);
				}
			}
		}
	
//		for (Session session : allSessions) {
//			if (session.isOpen())
//				session.getAsyncRemote().sendText(message);
//		}
		System.out.println("Message received: " + message);
	}
	


	@OnError
	public void onError(Session userSession, Throwable e){
//		e.printStackTrace();
	}
	
	// (8) 收到哪個使用者的userSession ,機關閉內容 ,將使用者Session移除
@OnClose
	public void onClose(Session userSession, CloseReason reason) {
//		allSessions.remove(userSession);
		MemChatRoom.mem_session.remove(userName);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}

 
}
