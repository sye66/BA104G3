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

import com.ad.model.AdService;
import com.ad.model.AdVO;
import com.artiForm.model.ArtiFormService;
import com.artiForm.model.ArtiFormVO;
import com.mem.model.MemService;
import com.mem.model.MemVO;
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
		
		if("arti_Pic".equals(action)){
			String arti_No = req.getParameter("arti_No");
			ArtiFormService artiFormSvc = new ArtiFormService();
			
			try{

				ArtiFormVO artiFormVO =  artiFormSvc.getOneArtiForm(arti_No);
				InputStream in = new ByteArrayInputStream(artiFormVO.getArti_Pic());
				byte[] buffer = new byte[in.available()];
				int len = 0;
				
				try{
					while((len=in.read(buffer))!=-1){
						out.write(buffer,0,len);
						out.close();
					}
				} catch(IOException ie){
					ie.printStackTrace();
				}
			} catch (Exception e){
				FileInputStream in = new FileInputStream(getServletContext().getRealPath("/res/images/arti_ref/XXX.jpg"));
				byte [] arti_Pic = new byte[in.available()];
				in.read(arti_Pic);
				out.write(arti_Pic);
				in.close();
			}
		}
		
		if("mem_Pic".equals(action)){
			String mem_No = req.getParameter("mem_No");
			MemService memSvc = new MemService();
			
			try{

				MemVO memVO =  memSvc.getOneMem(mem_No);
				InputStream in = new ByteArrayInputStream(memVO.getMem_Pic());
				byte[] buffer = new byte[in.available()];
				int len = 0;
				
				try{
					while((len=in.read(buffer))!=-1){
						out.write(buffer,0,len);
						out.close();
					}
				} catch(IOException ie){
					ie.printStackTrace();
				}
			} catch (Exception e){
				FileInputStream in = new FileInputStream(getServletContext().getRealPath("/res/images/arti_ref/XXX.jpg"));
				byte [] arti_Pic = new byte[in.available()];
				in.read(arti_Pic);
				out.write(arti_Pic);
				in.close();
			}
		}
		
		if("ad_Pic".equals(action)){
			String ad_No = req.getParameter("ad_No");
			AdService adSvc = new AdService();
			
			try{

				AdVO adVO =  adSvc.getOneAd(ad_No);
				InputStream in = new ByteArrayInputStream(adVO.getAd_Pic());
				byte[] buffer = new byte[in.available()];
				int len = 0;
				
				try{
					while((len=in.read(buffer))!=-1){
						out.write(buffer,0,len);
						out.close();
					}
				} catch(IOException ie){
					ie.printStackTrace();
				}
			} catch (Exception e){
				FileInputStream in = new FileInputStream(getServletContext().getRealPath("/res/images/arti_ref/XXX.jpg"));
				byte [] arti_Pic = new byte[in.available()];
				in.read(arti_Pic);
				out.write(arti_Pic);
				in.close();
			}
		}
	}
}
