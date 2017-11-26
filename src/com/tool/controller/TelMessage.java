package com.tool.controller;
import java.io.*;
public class TelMessage {
	public void sendMessage(String[] tel , String message)  {

		  try {
		      String server  = "203.66.172.131"; //Socket to Air Gateway IP
		      int port	     = 8000;            //Socket to Air Gateway Port

		      String user    = "85559671"; //帳號
		      String passwd  = "2irioiai"; //密碼
		      String messageBig5 = new String(message.getBytes(),"big5"); //簡訊內容

		      //----建立連線 and 檢查帳號密碼是否錯誤
		      sock2air mysms = new sock2air();
		      int ret_code = mysms.create_conn(server,port,user,passwd) ;
		      if( ret_code == 0 ) {
		           System.out.println("帳號密碼Login OK!");
		      } else {
		      	   System.out.println("帳號密碼Login Fail!");
		           System.out.println("ret_code="+ret_code + ",ret_content=" + mysms.get_message());
		           //結束連線
		           mysms.close_conn();
		           return ;
		      }

		      //傳送文字簡訊
		      //如需同時傳送多筆簡訊，請多次呼叫send_message()即可。
		    for(int i=0 ; i<tel.length ; i++){  
		      ret_code=mysms.send_message(tel[i],messageBig5);
		      if( ret_code == 0 ) {
		           System.out.println("簡訊已送到簡訊中心!");
		           System.out.println("MessageID="+mysms.get_message()); //取得MessageID
		           System.out.println("messageBig5="+messageBig5);
		      } else {
		           System.out.println("簡訊傳送發生錯誤!");
		           System.out.print("ret_code="+ret_code+",");
		           System.out.println("ret_content="+mysms.get_message());//取得錯誤的訊息
		           //結束連線
		           mysms.close_conn();
		           return ;
		      }
		    }

		      //結束連線
		      mysms.close_conn();

		  }catch (Exception e)  {

		      System.out.println("I/O Exception : " + e);
		   }
		 }

		 public static void main(String[] args) {
			 TelMessage se = new TelMessage();
			 String te = "0953-711016";
			 String tel2 =te.replaceAll("-","");
			 String[] tel ={tel2};
		 	
		 	String message = "恭喜你獲得麗星郵輪3日遊,請於三日內繳交保證金100元,於(005) 069-005-161111,以確認資格!!";
		 	se.sendMessage(tel , message);
		 }	

}
