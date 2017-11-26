package com.tool.controller;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
public class ProOrderEmail implements Runnable{
	// 設定傳送郵件:至收信人的Email信箱,Email主旨,Email內容
//		public void sendMail(String to, String subject, String messageText) {
//				
//		   try {
//			   // 設定使用SSL連線至 Gmail smtp Server
//			   Properties props = new Properties();
//			   props.put("mail.smtp.host", "smtp.gmail.com");
//			   props.put("mail.smtp.socketFactory.port", "465");
//			   props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
//			   props.put("mail.smtp.auth", "true");
//			   props.put("mail.smtp.port", "465");
//
//	       // ●設定 gmail 的帳號 & 密碼 (將藉由你的Gmail來傳送Email)
//	       // ●須將myGmail的【安全性較低的應用程式存取權】打開
//		     final String myGmail = "aa0953711016@gmail.com";
//		     final String myGmail_password = "ting5201314";
//			   Session session = Session.getInstance(props, new Authenticator() {
//				   protected PasswordAuthentication getPasswordAuthentication() {
//					   return new PasswordAuthentication(myGmail, myGmail_password);
//				   }
//			   });
//
//			   Message message = new MimeMessage(session);
//			   message.setFrom(new InternetAddress(myGmail));
//			   message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));
//			  
//			   //設定信中的主旨  
//			   message.setSubject(subject);
//			   //設定信中的內容 
//			   message.setText(messageText);
//
//			   Transport.send(message);
//			   System.out.println("傳送成功!");
//	     }catch (MessagingException e){
//		     System.out.println("傳送失敗!");
//		     e.printStackTrace();
//	     }
//	   }
		
	String to = "";
	String subject = "";
	String messageText = "";
	public void sendMail(String to, String subject, String messageText){
		this.to = to;
		this.subject = subject;
		this.messageText = messageText;
	}
	
	
	
		@Override
		public void run() {
			// 設定傳送郵件:至收信人的Email信箱,Email主旨,Email內容
					
			   try {
				   // 設定使用SSL連線至 Gmail smtp Server
				   Properties props = new Properties();
				   props.put("mail.smtp.host", "smtp.gmail.com");
				   props.put("mail.smtp.socketFactory.port", "465");
				   props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
				   props.put("mail.smtp.auth", "true");
				   props.put("mail.smtp.port", "465");

		       // ●設定 gmail 的帳號 & 密碼 (將藉由你的Gmail來傳送Email)
		       // ●須將myGmail的【安全性較低的應用程式存取權】打開
			     final String myGmail = "aa0953711016@gmail.com";
			     final String myGmail_password = "ting5201314";
				   Session session = Session.getInstance(props, new Authenticator() {
					   protected PasswordAuthentication getPasswordAuthentication() {
						   return new PasswordAuthentication(myGmail, myGmail_password);
					   }
				   });

				   Message message = new MimeMessage(session);
				   message.setFrom(new InternetAddress(myGmail));
				   message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));
				  
				   //設定信中的主旨  
				   message.setSubject(subject);
				   //設定信中的內容 
				   message.setText(messageText);

				   Transport.send(message);
				   System.out.println("傳送成功!");
		     }catch (MessagingException e){
			     System.out.println("傳送失敗!");
			     e.printStackTrace();
		     }
		   }
		
		
		public static void main (String args[]){
			for(int i=0;i<10;i++){
				
				String to = "eatkaikai@gmail.com";
			      
			      String subject = "信用卡帳單通知";
			      
			      String ch_name = "俊豪先生";
			      String passRandom = "這個月欠款9487元,請盡速繳納!";
			      String messageText = "Hello! " + ch_name + "  : " + passRandom + "\n" +" (已經啟用)"; 
			       
			      ProOrderEmail mailService = new ProOrderEmail();
			      mailService.sendMail(to, subject, messageText);
			      Thread thread = new Thread(mailService);
			      thread.start();
				}
			      

			   }
		
}
