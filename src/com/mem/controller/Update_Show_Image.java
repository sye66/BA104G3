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
		public Update_Show_Image() {

		}

		

		public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

			res.setContentType("image/*");
			ServletOutputStream out = res.getOutputStream();
			String action = req.getParameter("action");
			
			if ("mem_pic".equals(action)) {
				String mem_no = req.getParameter("mem_no");
				MemService memSvc = new MemService();
				try {
					MemVO memVO = memSvc.getOneMem(mem_no);
					InputStream in = new ByteArrayInputStream(memVO.getMem_pic());
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
					FileInputStream in = new FileInputStream(getServletContext().getRealPath("/images/nopic.jpg"));
					byte[] propic = new byte[in.available()];
					in.read(propic);
					out.write(propic);
					in.close();

				}

			}
		}

		
	}



