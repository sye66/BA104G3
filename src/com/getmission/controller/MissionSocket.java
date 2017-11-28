package com.getmission.controller;

import java.io.*;
import java.util.*;

import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONException;
import org.json.JSONObject;

import javax.websocket.Session;
import javax.websocket.OnOpen;
import javax.websocket.OnMessage;
import javax.websocket.OnError;
import javax.websocket.OnClose;
import javax.websocket.CloseReason;

@ServerEndpoint("/MissionSocket/{myName}/{myRoom}")
public class MissionSocket {

	private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
	private static final Map<String,Session> missionMessage= Collections.synchronizedMap(new HashMap<String,Session>());
	@OnOpen
	public void onOpen(@PathParam("myName") String myName, @PathParam("myRoom") String myRoom, Session userSession)
			throws IOException {
		
		missionMessage.put(myName, userSession);
		System.out.println("missionMessage : " + myName +": 已連線");
		allSessions.add(userSession);
		System.out.println(userSession.getId() + ": 已連線");
		System.out.println(myName + ": 已連線");
		System.out.println(myRoom + ": 房號");
		// userSession.getBasicRemote().sendText("WebSocket 連線成功");
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {

		try {
			JSONObject jb = new JSONObject(message);

			if ("missionOk".equals(jb.get("action").toString())) {
				for (Session session : allSessions) {
					if (session.isOpen())
						session.getAsyncRemote().sendText(message);

				}
			}

		} catch (JSONException e) {
			e.printStackTrace();
		}

		for (Session session : allSessions) {
			if (session.isOpen())
				session.getAsyncRemote().sendText(message);
		}
		System.out.println("Message received: " + message);
	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		// e.printStackTrace();
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason,@PathParam("myName") String myName) {
		missionMessage.remove(myName);
		System.out.println("missionMessage"+myName + "已離線 。");
		allSessions.remove(userSession);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}

	 static void pushMissionText(String mem_no) {
		 System.out.println("outside missionOk");
		 		if(missionMessage.containsKey(mem_no)){
		 			System.out.println("Before missionOk");
		 			try {
		 				
		 				System.out.println("missionOk");
		 				
						JSONObject jb = new JSONObject();
						jb.put("action","missionOk" );
						Session session = missionMessage.get(mem_no);
						session.getAsyncRemote().sendText(jb.toString());
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
								
		 			
		 		}
		 	

		
	}
}
