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
	
	@OnOpen
	public void onOpen(@PathParam("myName") String myName, @PathParam("myRoom") int myRoom, Session userSession) throws IOException {
		allSessions.add(userSession);
		System.out.println(userSession.getId() + ": 已連線");
		System.out.println(myName + ": 已連線");
		System.out.println(myRoom + ": 房號");
//		userSession.getBasicRemote().sendText("WebSocket 連線成功");
	}

	
	@OnMessage
	public void onMessage(Session userSession, String message) {
		
		try {
			JSONObject jb = new JSONObject(message);
			
			if ("XXX".equals(jb.get("action").toString())) {
				for (Session session : allSessions) {
					if (session.isOpen())
						session.getAsyncRemote().sendText(message);
						
				}
			}
			
			
			
			
			
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		for (Session session : allSessions) {
			if (session.isOpen())
				session.getAsyncRemote().sendText(message);
		}
		System.out.println("Message received: " + message);
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
//		e.printStackTrace();
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		allSessions.remove(userSession);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}

 
}
