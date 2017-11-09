package com.getpic;



import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.missionimages.model.MissionImagesService;





public class Getpic extends HttpServlet {
	
	Connection con;
	
       
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doGet(req, res);
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/jpeg");
		ServletOutputStream out = res.getOutputStream();
		
		try{
			
			String image_No = req.getParameter("image_No");
			
			MissionImagesService missionImagesSvc = new MissionImagesService();
			
			byte[] image = missionImagesSvc.getOneImage(image_No).getIssuer_images();
			
			out.write(image);
			
			
		}catch(Exception e){
			InputStream in = getServletContext().getResourceAsStream("/frontdesk/getmission/images/tomcat.gif");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
		}
		
	}

	public void init() throws ServletException {
		try {
			Context ctx = new InitialContext();
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