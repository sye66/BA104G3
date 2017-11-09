package com.tool.controller;

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.model.ProService;
import com.pro.model.ProVO;

public class ShowImage extends HttpServlet {
	public ShowImage() {
	}

	// public void doPost(HttpServletRequest req, HttpServletResponse res)
	// throws ServletException, IOException {
	// doGet(req, res);
	// }

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		String action = req.getParameter("action");
		if ("propic".equals(action)) {
			String pro_No = req.getParameter("pro_No");
			ProService proSvc = new ProService();
			try {
				ProVO proVO = proSvc.getOnePro(pro_No);
				InputStream in = new ByteArrayInputStream(proVO.getPro_Pic());
				byte[] buffer = new byte[in.available()];
				int len = 0;
				try {
					while ((len = in.read(buffer)) != -1)
						out.write(buffer, 0, len);
					out.close();
					return;
				} catch (IOException e) {
					e.printStackTrace();

				}
			} catch (Exception e) {
				FileInputStream in = new FileInputStream(getServletContext().getRealPath("/res/images/pro_icons/nopic.jpg"));
				byte[] propic = new byte[in.available()];
				in.read(propic);
				out.write(propic);
				in.close();
			}
		
		
		}
	}
}
