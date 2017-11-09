package com.missionimages.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.missionimages.model.MissionImagesService;




//@WebServlet("/MissionImagesServlet")
public class MissionImagesServlet extends HttpServlet {
	
	Connection con;
	
       
	protected void doGost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/jpeg");
		ServletOutputStream out = res.getOutputStream();
		
		try{
			
			String image_No = req.getParameter("image_No");
			
			MissionImagesService missionImagesSvc = new MissionImagesService();
			
			byte[] image = missionImagesSvc.getOneImage(image_No).getIssuer_images();
			
			out.write(image);
			
			
		}catch(Exception e){
			
		}
		
	}

	

}
