package com.android.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ChatRecordDAO implements ChatRecordDAO_interface{
	
	private static final String INSERT_STMT = "INSERT INTO CHAT_RECORD(SENDER_MEM_NO,RECEIVER_MEM_NO,CHAT_DATETIME,CHAT_CONTENT) VALUES(?,?,?,?)";
	private static final String GET_ONE_STMT = "SELECT * FROM CHAT_RECORD WHERE (SENDER_MEM_NO =? AND RECEIVER_MEM_NO =? AND CHAT_DATETIME =?)";
	private static final String GET_ALL_STMT = "SELECT * FROM CHAT_RECORD";
	private static final String DELETE_STMT = "DELETE FROM CHAT_RECORD WHERE (SENDER_MEM_NO =? AND RECEIVER_MEM_NO =? AND CHAT_DATETIME =?)";
	private static final String UPDATE_STMT = "UPDATE CHAT_RECORD SET CHAT_CONTENT=? WHERE (SENDER_MEM_NO =? AND RECEIVER_MEM_NO =? AND CHAT_DATETIME =?)";
	private static final String GET_CHAT_RECORD = "SELECT SENDER_MEM_NO,RECEIVER_MEM_NO,CHAT_DATETIME,CHAT_CONTENT FROM CHAT_RECORD WHERE SENDER_MEM_NO =? OR RECEIVER_MEM_NO =? ORDER BY CHAT_DATETIME DESC ";
	private static final String GET_TWO_CHAT_RECORD = "SELECT SENDER_MEM_NO,RECEIVER_MEM_NO,TO_CHAR(CHAT_DATETIME,'YYYY-MM-DD HH24:MI:SS')CHAT_DATETIME,CHAT_CONTENT FROM CHAT_RECORD WHERE (SENDER_MEM_NO =? AND RECEIVER_MEM_NO =?) OR (SENDER_MEM_NO =? AND RECEIVER_MEM_NO =?) ORDER BY CHAT_DATETIME";
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	@Override
	public void insert(ChatRecordVO chatRecordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, chatRecordVO.getSender_Mem_No());
			pstmt.setString(2, chatRecordVO.getReceiver_Mem_No());
			pstmt.setTimestamp(3, chatRecordVO.getChat_Datetime());
			pstmt.setString(4, chatRecordVO.getChat_Content());

			pstmt.executeUpdate();
			System.out.println("新增成功");
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
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(DELETE_STMT);
			
			pstmt.setString(1, sender_mem_no);
			pstmt.setString(2, receiver_mem_no);
			pstmt.setTimestamp(3, chat_datetime);
			pstmt.executeUpdate();
			
			System.out.println("刪除成功");
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
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, chatRecordVO.getChat_Content());
			pstmt.setString(2, chatRecordVO.getSender_Mem_No());
			pstmt.setString(3, chatRecordVO.getReceiver_Mem_No());
			pstmt.setTimestamp(4, chatRecordVO.getChat_Datetime());
			pstmt.executeUpdate();
			
			System.out.println("更新成功");
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
			con = ds.getConnection();
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
	public List<ChatRecordVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ChatRecordVO chatRecordVO = null;
		ResultSet rs = null;
		List<ChatRecordVO> listAllChatRecord = new ArrayList<>();
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
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
	
	public List<ChatRecordVO> getChatRecord(String sender_Mem_No, String receiver_Mem_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ChatRecordVO chatRecordVO = null;
		ResultSet rs = null;
		List<ChatRecordVO> listAllChatRecord = new ArrayList<>();
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_CHAT_RECORD);
			pstmt.setString(1, sender_Mem_No);
			pstmt.setString(2, receiver_Mem_No);
			rs = pstmt.executeQuery();
//			rs.getString("SENDER_MEM_NO")發訊息人 rs.getString("RECEIVER_MEM_NO")收訊息人
			int count = 0;
			
			String sender = null;
			String receiver = null;
			Set<String> whoChat = new HashSet();
			while(rs.next()) {
							
				
				if( whoChat.contains(rs.getString(1)) && whoChat.contains(rs.getString(2)) ) {
					System.out.println(count);
					count =0;
					System.out.println("sender"+sender);
					System.out.println("receiver"+receiver);
					System.out.println("rs1"+rs.getString(1));
					System.out.println("rs2"+rs.getString(2));
					System.out.println("continue");
					continue;
				}
				count ++;
				System.out.println(count);
				chatRecordVO = new ChatRecordVO();
				
				
				System.out.println("sender"+sender);
				System.out.println("receiver"+receiver);
				System.out.println("rs1"+rs.getString(1));
				System.out.println("rs2"+rs.getString(2));
				whoChat.add(rs.getString(1));
				whoChat.add(rs.getString(2));
				chatRecordVO.setSender_Mem_No(rs.getString(1));
				chatRecordVO.setReceiver_Mem_No(rs.getString(2));
				chatRecordVO.setChat_Datetime(rs.getTimestamp(3));
				chatRecordVO.setChat_Content(rs.getString(4));
				listAllChatRecord.add(chatRecordVO);
				System.out.println(chatRecordVO.getChat_Datetime());
			}
			
			System.out.println("全部查詢完畢");
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
	
	public List<ChatRecordVO> getTwoChatRecord(String sender_Mem_No, String receiver_Mem_No) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ChatRecordVO chatRecordVO = null;
		ResultSet rs = null;
		List<ChatRecordVO> listAllChatRecord = new ArrayList<>();
		
		try {
			System.out.println("---------------------------------------");
			con = ds.getConnection();
			System.out.println("連線成功");
			pstmt = con.prepareStatement(GET_TWO_CHAT_RECORD);
			pstmt.setString(1, sender_Mem_No);
			pstmt.setString(2, receiver_Mem_No);
			pstmt.setString(3, receiver_Mem_No);
			pstmt.setString(4, sender_Mem_No);
			rs = pstmt.executeQuery();
//			rs.getString("SENDER_MEM_NO")發訊息人 rs.getString("RECEIVER_MEM_NO")收訊息人
		
			
			String sender = null;
			String receiver = null;
			while(rs.next()) {			
				chatRecordVO = new ChatRecordVO();
				chatRecordVO.setSender_Mem_No(rs.getString(1));
				chatRecordVO.setReceiver_Mem_No(rs.getString(2));
				chatRecordVO.setChat_Datetime(rs.getTimestamp(3));
				chatRecordVO.setChat_Content(rs.getString(4));
				listAllChatRecord.add(chatRecordVO);
				System.out.println("cccccctttt"+chatRecordVO.getChat_Datetime());
			}
			
			System.out.println("全部查詢完畢");
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
}
