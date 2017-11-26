package com.chatrecord.model;

import java.sql.Timestamp;

public class ChatRecordVO {
	String sender_Mem_No;
	String receiver_Mem_No;
	Timestamp chat_Datetime;
	String chat_Content;
	
	public ChatRecordVO(){
		// TODO Auto-generated constructor stub
	}
	
	public ChatRecordVO(String parameter) {
		// TODO Auto-generated constructor stub
	}
	public String getSender_Mem_No() {
		return sender_Mem_No;
	}
	public void setSender_Mem_No(String sender_Mem_No) {
		this.sender_Mem_No = sender_Mem_No;
	}
	public String getReceiver_Mem_No() {
		return receiver_Mem_No;
	}
	public void setReceiver_Mem_No(String receiver_Mem_No) {
		this.receiver_Mem_No = receiver_Mem_No;
	}
	public Timestamp getChat_Datetime() {
		return chat_Datetime;
	}
	public void setChat_Datetime(Timestamp chat_Datetime) {
		this.chat_Datetime = chat_Datetime;
	}
	public String getChat_Content() {
		return chat_Content;
	}
	public void setChat_Content(String chat_Content) {
		this.chat_Content = chat_Content;
	}
	
}
