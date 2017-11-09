package com.chatrecord.model;

import java.sql.Timestamp;
import java.util.List;

public interface ChatRecordDAO_interface {
	public void insert(ChatRecordVO chatRecordVO);
	public void delete(String sender_mem_no, String receiver_mem_no, Timestamp chat_datetime);
	public void update(ChatRecordVO chatRecordVO);
	public ChatRecordVO findByPrimaryKey(String sender_mem_no, String receiver_mem_no, Timestamp chat_datetime);
	public List<ChatRecordVO> getAll();
}
