package com.chatrecord.model;

import java.sql.Timestamp;
import java.util.List;

public class ChatRecordService {
	public ChatRecordDAO_interface dao;
	public ChatRecordService() {
		dao = new ChatRecordDAO();
	}
	public ChatRecordVO addChatRecord(String sender_mem_no, String receiver_mem_no, Timestamp chat_datetime, String chat_content) {
		ChatRecordVO chatRecordVO = new ChatRecordVO();
		chatRecordVO.setSender_mem_no(sender_mem_no);
		chatRecordVO.setReceiver_mem_no(receiver_mem_no);
		chatRecordVO.setChat_datetime(chat_datetime);
		chatRecordVO.setChat_content(chat_content);
		dao.insert(chatRecordVO);
		return chatRecordVO;
	}
	public void deleteChatRecord(String sender_mem_no, String receiver_mem_no, Timestamp chat_datetime) {
		dao.delete(sender_mem_no, receiver_mem_no, chat_datetime);
	}
	public ChatRecordVO updateChatRecord(String sender_mem_no, String receiver_mem_no, Timestamp chat_datetime, String chat_content) {
		ChatRecordVO chatRecordVO = new ChatRecordVO();
		chatRecordVO.setSender_mem_no(sender_mem_no);
		chatRecordVO.setReceiver_mem_no(receiver_mem_no);
		chatRecordVO.setChat_datetime(chat_datetime);
		chatRecordVO.setChat_content(chat_content);
		dao.update(chatRecordVO);
		return chatRecordVO;
	}
	
	public ChatRecordVO getOneChatRecord(String sender_mem_no, String receiver_mem_no, Timestamp chat_datetime) {
		return dao.findByPrimaryKey(sender_mem_no, receiver_mem_no, chat_datetime);
	}
	
	public List<ChatRecordVO> getAllChatRecord(){
		return dao.getAll();
	}
	
}
