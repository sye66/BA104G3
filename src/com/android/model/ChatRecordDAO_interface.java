package com.android.model;

import java.sql.Timestamp;
import java.util.List;

public interface ChatRecordDAO_interface {
	public void insert(ChatRecordVO chatRecordVO);
	public void delete(String sender_Mem_No, String receiver_Mem_no, Timestamp chat_Datetime);
	public void update(ChatRecordVO chatRecordVO);
	public ChatRecordVO findByPrimaryKey(String sender_Mem_No, String receiver_Mem_no, Timestamp chat_Datetime);
	public List<ChatRecordVO> getAll();
}
