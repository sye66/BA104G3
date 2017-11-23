
public class Websocket {

	
	
	package com.friend_list.model;

	import java.io.*;
	import java.util.*;

	import javax.websocket.server.PathParam;
	import javax.websocket.server.ServerEndpoint;

	import org.json.JSONException;
	import org.json.JSONObject;

	import com.member_profile.model.MemberProfileService;

	import javax.websocket.Session;
	import javax.websocket.OnOpen;
	import javax.websocket.OnMessage;
	import javax.websocket.OnError;
	import javax.websocket.OnClose;
	import javax.websocket.CloseReason;

	@ServerEndpoint("/FriendListChatServer/{myName}")
	public class FriendListChatServer  {
			
		private static Map<String, Set<Session>> friendListSessions = Collections.synchronizedMap(new HashMap<String, Set<Session>>());
		private static Map<String, Set<Session>> groupBuySessions = Collections.synchronizedMap(new HashMap<String, Set<Session>>());	
		
			@OnOpen
			public void onOpen(@PathParam("myName") String myName, Session userSession) throws IOException {
				
				
				if ("MB".equals(myName.substring(0, 2))) {
					
					if (friendListSessions.containsKey(myName)) {
						
						friendListSessions.get(myName).add(userSession);
						
					} else {
						
						Set<Session> userSessions = Collections.synchronizedSet(new HashSet<Session>());
						userSessions.add(userSession);
						friendListSessions.put(myName, userSessions);
						
					}
					
					System.out.println("FriendList" + userSession.getId() + ": 已連線");
					System.out.println("FriendList" + myName + ": 已連線");
//					
//				} else if ("MO".equals(myName.substring(0, 2))) {
//					
//					if (groupBuySessions.containsKey(myName)) {
//						
//						groupBuySessions.get(myName).add(userSession);
//						
//					} else {
//						
//						Set<Session> userSessions = Collections.synchronizedSet(new HashSet<Session>());
//						userSessions.add(userSession);
//						groupBuySessions.put(myName, userSessions);
//						
//					}
//					
//					System.out.println("GroupBuy" + userSession.getId() + ": 已連線");
//					System.out.println("GroupBuy" + myName + ": 已連線");
//					
//				}
				
			}
			
			@OnMessage
			synchronized public void onMessage(Session userSession, String message) {
				
				JSONObject jsonObj = null;
				
				try {
					
					jsonObj = new JSONObject(message);
					
					if ("sendMessages".equals((String) jsonObj.get("action"))) {
						
						if (friendListSessions.containsKey((String) jsonObj.get("targetNumber"))) {
							
							JSONObject sendJsonObj = new JSONObject();
							
							MemberProfileService mps = new MemberProfileService();
							
							String senderName = mps.getMyProfile((String)jsonObj.get("senderNumber")).getMem_name();
							
							sendJsonObj.put("action", "talkMessage");
							sendJsonObj.put("senderName", senderName);
							sendJsonObj.put("senderNumber", (String)jsonObj.get("senderNumber"));
							sendJsonObj.put("targetNumber", (String)jsonObj.get("targetNumber"));
							sendJsonObj.put("message", (String)jsonObj.get("message"));
							
							for (Session targetSession : friendListSessions.get((String)jsonObj.get("targetNumber"))) {
								
								if (targetSession.isOpen()) {
									
									synchronized(targetSession){
										
										targetSession.getAsyncRemote().sendText(sendJsonObj.toString());
										
									}
										
								}
								
							}
							
							for (Session senderSession : friendListSessions.get((String)jsonObj.get("senderNumber"))) {
								
								if (senderSession.isOpen()) {
									
									synchronized(senderSession){
										
										senderSession.getAsyncRemote().sendText(sendJsonObj.toString());
										
									}
										
								}
								
							}
							
						}
						
						System.out.println("Message received: " + (String)jsonObj.get("message"));
						
					} else if ("sendIsRead".equals((String) jsonObj.get("action"))) {
						
						if (friendListSessions.containsKey((String) jsonObj.get("targetNumber"))) {
							
							JSONObject sendJsonObj = new JSONObject();
							
							sendJsonObj.put("action", "sendIsRead");
							sendJsonObj.put("senderNumber", (String)jsonObj.get("senderNumber"));
							sendJsonObj.put("message", (String)jsonObj.get("message"));
							
							for (Session targetSession : friendListSessions.get((String)jsonObj.get("targetNumber"))) {
								
								if (targetSession.isOpen()) {
										
									synchronized(targetSession){
										
										targetSession.getAsyncRemote().sendText(sendJsonObj.toString());
										
									}
										
								}
								
							}
							
						}
						
					
				} catch (JSONException e) {
					e.printStackTrace();
				}
				
			}
			
			@OnError
			public void onError(Session userSession, Throwable e){
				e.printStackTrace();
			}
			
			@OnClose
			public void onClose(Session userSession, CloseReason reason, @PathParam("myName") String myName) {
				
				if (friendListSessions.containsKey(myName)) {
					
					if(friendListSessions.get(myName).contains(userSession)){
						
						friendListSessions.get(myName).remove(userSession);
						
						System.out.println("ID:" + userSession.getId() + "=>Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
						
					}
					
				}
				
				
				if (groupBuySessions.containsKey(myName)) {
					
					if(groupBuySessions.get(myName).contains(userSession)){
						
						groupBuySessions.get(myName).remove(userSession);
						
						System.out.println("ID:" + userSession.getId() + "=>Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
						
					}
					
				}
				
			}
			
			
		public static Map<String, Set<Session>> getFriendListSessions() {
			return friendListSessions;
		}
		
		public static Map<String, Set<Session>> getGroupBuySessions() {
			return groupBuySessions;
		}
		 
	}

}
