package com.achieve.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.achieve.model.AchieveService;


//@WebServlet("/AchieveShowImage")
public class AchieveShowImage extends HttpServlet {
	Connection con;
	

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		res.setCharacterEncoding("UTF-8");		//��
		res.setContentType("image/jpeg");
		ServletOutputStream out = res.getOutputStream();

		try{
			String ach_Picture = req.getParameter("ach_No");
			AchieveService achieveSvc = new AchieveService();
			byte[] image = achieveSvc.getOneAchieve(ach_Picture).getAch_Picture();
			out.write(image);
		}	catch (Exception e){
			InputStream in = getServletContext().getResourceAsStream("/NoData/nopic.jpg");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
		}	
	}
	
	public void init() throws ServletException {
		try {
			Context ctx = new javax.naming.InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G3");
			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void destroy() {
		try {
			if (con != null) con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}

}

