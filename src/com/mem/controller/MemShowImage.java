package com.mem.controller;


	import java.io.*;
	import java.sql.*;

	import javax.naming.Context;
	import javax.naming.NamingException;
	import javax.servlet.*;
	import javax.servlet.http.*;
	import javax.sql.DataSource;

	public class MemShowImage extends HttpServlet {

		Connection con;
		

		public void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			
			res.setCharacterEncoding("UTF-8");		//先
			res.setContentType("image/gif");
			ServletOutputStream out = res.getOutputStream();

			try {
				Statement stmt = con.createStatement();
				String mem_no = req.getParameter("mem_no");		//後
				String mem_no2 = new String(mem_no.getBytes("ISO-8859-1"),"UTF-8");		//再 (用doget & 有需要輸入中文時)
//				System.out.println(mem_no2);
				ResultSet rs = stmt.executeQuery(
					"SELECT mem_pic FROM mem WHERE mem_no = '"+mem_no2+"'");		//動態捕捉

				if (rs.next()) {
					BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("mem_pic"));
					byte[] buf = new byte[4 * 1024]; // 4K buffer		此時還不能改用in.available()方式存取資料庫檔案，會抓不到準確資料大小 (本機可以)
					int len;
					while ((len = in.read(buf)) != -1) {
						out.write(buf, 0, len);
					}
					in.close();
				} else {
					exception(out);
//					InputStream in = getServletContext().getResourceAsStream("/NoData/nopic.jpg");	//改變例外處理圖片
//					byte b[] = new byte[in.available()];		//in.available()是InputStream的方法(會得到一個InputStream的物件)
//					in.read(b);									//使用in.available()的方法需要等從資料庫抓取資料完，而且不帶連線物件，才可以用
//					out.write(b);
//					in.close();
				}
				rs.close();
				stmt.close();
			} catch (Exception e) {
				exception(out);
			}
		}

		public void exception(ServletOutputStream out){
			InputStream in = getServletContext().getResourceAsStream("/mem/image/nopic.jpg");
			try {
				byte b[] = new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		public void init() throws ServletException {
			try {
				Context ctx = new javax.naming.InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
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


