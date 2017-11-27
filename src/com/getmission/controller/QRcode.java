package com.getmission.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.businessrefinery.barcode.QRCode;
import com.sun.org.apache.bcel.internal.generic.GotoInstruction;


public class QRcode extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("image/jpeg");
		ServletOutputStream outputStream = response.getOutputStream();
		System.out.println("Get Request From img/issuemission_Pending");
		
		String mem_No = request.getParameter("mem_No");
		String mission_No = request.getParameter("mission_No");
		System.out.println("Got mem_No: " + mem_No);
		System.out.println("Got mission_No: " +mission_No);
		/**
		 * @author Sander
		 * 在<img>中屬性src連結到此Servlet即可
		 * <img>會傳一個GET過來，用outputstream流過去給他即可。
		 * setCode可以放入連結進行QRcode編碼。
		 */
		
	    // new QRcode物件
	    QRCode barcode = new QRCode();
	    // 填入要轉碼的資訊
	    String URL = request.getScheme() +"://"+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "?mission_No=";
	    System.out.println("Send Full URL: " + URL);
	    barcode.setCode(URL);
	    // 設定大小，15~20效果不錯
	    barcode.setModuleSize(15);
	    // 解析度
	    barcode.setResolution(144);
	    // 傳入byte陣列
	    byte[] barcodeByteArr;
		try {
			barcodeByteArr = barcode.drawImage2Bytes();
			int length = barcodeByteArr.length;
			outputStream.write(barcodeByteArr, 0, length);
			outputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
