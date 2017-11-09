package com.chatrecord.model;

import java.sql.Timestamp;
import java.util.List;

public class ChatRecordService {
	public ChatRecordDAO_interface dao;
	public ChatRecordService() {
		dao = new ChatRecordDAO();
	}
	public ChatRecordVO addChatRecord(String sender_Mem_No, String receiver_Mem_No, Timestamp chat_Datetime, String chat_Content) {
		ChatRecordVO chatRecordVO = new ChatRecordVO();
		chatRecordVO.setSender_Mem_No(sender_Mem_No);
		chatRecordVO.setReceiver_Mem_No(receiver_Mem_No);
		chatRecordVO.setChat_Datetime(chat_Datetime);
		chatRecordVO.setChat_Content(chat_Content);
		dao.insert(chatRecordVO);
		return chatRecordVO;
	}
	public void deleteChatRecord(String sender_Mem_No, String receiver_Mem_No, Timestamp chat_Datetime) {
		dao.delete(sender_Mem_No, receiver_Mem_No, chat_Datetime);
	}
	public ChatRecordVO updateChatRecord(String sender_Mem_No, String receiver_Mem_No, Timestamp chat_Datetime, String chat_Content) {
		ChatRecordVO chatRecordVO = new ChatRecordVO();
		chatRecordVO.setSender_Mem_No(sender_Mem_No);
		chatRecordVO.setReceiver_Mem_No(receiver_Mem_No);
		chatRecordVO.setChat_Datetime(chat_Datetime);
		chatRecordVO.setChat_Content(chat_Content);
		dao.update(chatRecordVO);
		return chatRecordVO;
	}
	
	public ChatRecordVO getOneChatRecord(String sender_Mem_No, String receiver_Mem_No, Timestamp chat_Datetime) {
		return dao.findByPrimaryKey(sender_Mem_No, receiver_Mem_No, chat_Datetime);
	}
	
	public List<ChatRecordVO> getAllChatRecord(){
		return dao.getAll();
	}
	
}
