package com.artiForm.model;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.rowset.serial.SerialBlob;

import com.artiForm.model.ArtiFormService;
import com.artiForm.model.ArtiFormVO;

@MultipartConfig(fileSizeThreshold = 1024*1024, maxFileSize = 5*1024*1024, maxRequestSize = 5*5*1024*1024)
public class Jump_ArtiFormServlet extends HttpServlet {
	
	public void doGet (HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException{
		doPost(req, res);
		}
	
	public void doPost (HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException{
			
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		/******[ 取出ㄧ個展示 ]******/

		
	}
}
