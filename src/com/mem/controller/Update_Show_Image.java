package com.mem.controller;


	import java.io.ByteArrayInputStream;
	import java.io.FileInputStream;
	import java.io.IOException;
	import java.io.InputStream;

	import javax.servlet.ServletException;
	import javax.servlet.ServletOutputStream;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;


	import com.mem.model.MemService;
	import com.mem.model.MemVO;


	public class Update_Show_Image extends HttpServlet {

		public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

			res.setCharacterEncoding("UTF-8");	//先
			res.setContentType("image/gif");
			ServletOutputStream out = res.getOutputStream();
//			String action = req.getParameter("action");
//			System.out.println(action);
			
//			if ("mem_Pic".equals(action)) {
				String mem_No = req.getParameter("mem_No");//後
//				String mem_No2 = new String(mem_No.getBytes("ISO-8859-1"),"UTF-8");		//再 (用doget & 有需要輸入中文時)
				MemService memSvc = new MemService();
				try {
					MemVO memVO = memSvc.getOneMem(mem_No);
					InputStream in = new ByteArrayInputStream(memVO.getMem_Pic());
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
					FileInputStream in = new FileInputStream(getServletContext().getRealPath("/lib/publicfile/include/img/nopic.jpg"));
					byte[] propic = new byte[in.available()];
					in.read(propic);
					out.write(propic);
					in.close();

				}

//			}
		}

		
	}



