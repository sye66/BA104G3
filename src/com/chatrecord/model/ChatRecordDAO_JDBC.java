package com.chatrecord.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ChatRecordDAO_JDBC implements ChatRecordDAO_interface{
	private static final String DRIVER = "oracle.jdbc.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USR = "BA104G3";
	private static final String PSW = "123456";
	
	private static final String INSERT_STMT = "INSERT INTO CHAT_RECORD(SENDER_MEM_NO,RECEIVER_MEM_NO,CHAT_DATETIME,CHAT_CONTENT) VALUES(?,?,?,?)";
	private static final String GET_ONE_STMT = "SELECT * FROM CHAT_RECORD WHERE (SENDER_MEM_NO =? AND RECEIVER_MEM_NO =? AND CHAT_DATETIME =?)";
	private static final String GET_ALL_STMT = "SELECT * FROM CHAT_RECORD";
	private static final String DELETE_STMT = "DELETE FROM CHAT_RECORD WHERE (SENDER_MEM_NO =? AND RECEIVER_MEM_NO =? AND CHAT_DATETIME =?)";
	private static final String UPDATE_STMT = "UPDATE CHAT_RECORD SET CHAT_CONTENT=? WHERE (SENDER_MEM_NO =? AND RECEIVER_MEM_NO =? AND CHAT_DATETIME =?)";
	private static final String GET_CONTENT = "SELECT * FROM CHAT_RECORD WHERE (SENDER_MEM_NO =? AND RECEIVER_MEM_NO =?) order by CHAT_DATETIME";
	
	
	
	@Override
	public void insert(ChatRecordVO chatRecordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, chatRecordVO.getSender_Mem_No());
			pstmt.setString(2, chatRecordVO.getReceiver_Mem_No());
			pstmt.setTimestamp(3, chatRecordVO.getChat_Datetime());
			pstmt.setString(4, chatRecordVO.getChat_Content());

			pstmt.executeUpdate();
			System.out.println("新增成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void delete(String sender_mem_no, String receiver_mem_no, Timestamp chat_datetime) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(DELETE_STMT);
			
			pstmt.setString(1, sender_mem_no);
			pstmt.setString(2, receiver_mem_no);
			pstmt.setTimestamp(3, chat_datetime);
			pstmt.executeUpdate();
			
			System.out.println("刪除成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void update(ChatRecordVO chatRecordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, chatRecordVO.getChat_Content());
			pstmt.setString(2, chatRecordVO.getSender_Mem_No());
			pstmt.setString(3, chatRecordVO.getReceiver_Mem_No());
			pstmt.setTimestamp(4, chatRecordVO.getChat_Datetime());
			pstmt.executeUpdate();
			
			System.out.println("更新成功");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
	}


	@Override
	public ChatRecordVO findByPrimaryKey(String sender_mem_no, String receiver_mem_no, Timestamp chat_datetime) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ChatRecordVO chatRecordVO = null;
		ResultSet rs = null;
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, sender_mem_no);
			pstmt.setString(2, receiver_mem_no);
			pstmt.setTimestamp(3, chat_datetime);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				chatRecordVO = new ChatRecordVO();
				chatRecordVO.setSender_Mem_No(rs.getString(1));
				chatRecordVO.setReceiver_Mem_No(rs.getString(2));
				chatRecordVO.setChat_Datetime(rs.getTimestamp(3));
				chatRecordVO.setChat_Content(rs.getString(4));
			}
			
			System.out.println("主鍵查詢完畢");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
		return chatRecordVO;
	}
	
	@Override
	public List<ChatRecordVO> getRecord(String sender_mem_no, String receiver_mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		List<ChatRecordVO> list = new ArrayList<>();
		ResultSet rs = null;
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_CONTENT);
			
			pstmt.setString(1, sender_mem_no);
			pstmt.setString(2, receiver_mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChatRecordVO chatRecordVO = new ChatRecordVO();
				chatRecordVO.setSender_Mem_No(rs.getString(1));
				chatRecordVO.setReceiver_Mem_No(rs.getString(2));
				chatRecordVO.setChat_Datetime(rs.getTimestamp(3));
				chatRecordVO.setChat_Content(rs.getString(4));
			}
			
			System.out.println("主鍵查詢完畢");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
		return list;
	}
	

	@Override
	public List<ChatRecordVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ChatRecordVO chatRecordVO = null;
		ResultSet rs = null;
		List<ChatRecordVO> listAllChatRecord = new ArrayList<>();
		
		try {
			System.out.println("---------------------------------------");
			Class.forName(DRIVER);
			System.out.println("載入成功");
			con = DriverManager.getConnection(URL, USR, PSW);
			System.out.println("連線成功");
			
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				chatRecordVO = new ChatRecordVO();
				chatRecordVO.setSender_Mem_No(rs.getString(1));
				chatRecordVO.setReceiver_Mem_No(rs.getString(2));
				chatRecordVO.setChat_Datetime(rs.getTimestamp(3));
				chatRecordVO.setChat_Content(rs.getString(4));
				listAllChatRecord.add(chatRecordVO);
			}
			
			System.out.println("全部查詢完畢");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("載入失敗，類別未找到");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL異常");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		}
		return listAllChatRecord;
	}
	public static void main(String[] args) {
		ChatRecordDAO_interface dao = new ChatRecordDAO_JDBC();
//		ChatRecordVO insertChatRecord = new ChatRecordVO();
//		ChatRecordVO updateChatRecord = new ChatRecordVO();
//		ChatRecordVO getOneChatRecord = new ChatRecordVO();
//		List<ChatRecordVO> getAllChatRecord = new ArrayList<>();
//		
//		insertChatRecord.setSender_Mem_No("M000005");
//		insertChatRecord.setReceiver_Mem_No("M000018");
//		insertChatRecord.setChat_Datetime(Timestamp.valueOf("2017-11-11 11:11:11.000000000"));
//		insertChatRecord.setChat_Content("HIHIHI!!!!");
//		dao.insert(insertChatRecord);
//		
//		updateChatRecord.setSender_Mem_No("M000005");
//		updateChatRecord.setReceiver_Mem_No("M000018");
//		updateChatRecord.setChat_Datetime(Timestamp.valueOf("2017-11-11 11:11:11.000000000"));
//		updateChatRecord.setChat_Content("YOYOYOOYOYOYO!!!");
//		
//		dao.update(updateChatRecord);
//		
//		dao.delete("M000005", "M000018", Timestamp.valueOf("2017-11-11 11:11:11.000000000"));
//		
//		insertChatRecord.setSender_Mem_No("M000005");
//		insertChatRecord.setReceiver_Mem_No("M000018");
//		insertChatRecord.setChat_Datetime(Timestamp.valueOf("2017-11-11 11:11:11.000000000"));
//		insertChatRecord.setChat_Content("HIHIHI!!!!");
//		dao.insert(insertChatRecord);
		
//		System.out.println();
//		ChatRecordVO chatRecordVO4 =dao.findByPrimaryKey("M000003", "M000001", Timestamp.valueOf("2017-11月-27 11:37:36")); 
//		System.out.println(chatRecordVO4.getChat_Content());
//		System.out.println(chatRecordVO4.getReceiver_Mem_No());
//		System.out.println(chatRecordVO4.getSender_Mem_No());
//		System.out.println(chatRecordVO4.getChat_Datetime());
		
		List<ChatRecordVO> List =dao.getRecord("M000003", "M000001");
		for(ChatRecordVO VO: List){
		System.out.println(VO.getChat_Content());
		System.out.println(VO.getReceiver_Mem_No());
		System.out.println(VO.getSender_Mem_No());
		System.out.println(VO.getChat_Datetime());
		
		}
		dao.getAll();
		
		
	}
	
}
