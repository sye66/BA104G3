package com.personal.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.mem.model.MemService;


@WebServlet("/PersonalShowImage")
public class PersonalShowImage extends HttpServlet {
Connection con;
	

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		res.setCharacterEncoding("UTF-8");		//��
		res.setContentType("image/jpeg");
		ServletOutputStream out = res.getOutputStream();

		try{
			String mem_No = req.getParameter("mem_No");
			MemService memSvc = new MemService();
			byte[] image = memSvc.getOneMem(mem_No).getMem_Pic();
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

