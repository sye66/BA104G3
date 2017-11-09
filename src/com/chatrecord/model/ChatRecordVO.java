package com.chatrecord.model;

import java.sql.Timestamp;

public class ChatRecordVO {
	String sender_mem_no;
	String receiver_mem_no;
	Timestamp chat_datetime;
	String chat_content;
	
	public String getSender_mem_no() {
		return sender_mem_no;
	}
	public void setSender_mem_no(String sender_mem_no) {
		this.sender_mem_no = sender_mem_no;
	}
	public String getReceiver_mem_no() {
		return receiver_mem_no;
	}
	public void setReceiver_mem_no(String receiver_mem_no) {
		this.receiver_mem_no = receiver_mem_no;
	}
	public Timestamp getChat_datetime() {
		return chat_datetime;
	}
	public void setChat_datetime(Timestamp chat_datetime) {
		this.chat_datetime = chat_datetime;
	}
	public String getChat_content() {
		return chat_content;
	}
	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}
	
}
