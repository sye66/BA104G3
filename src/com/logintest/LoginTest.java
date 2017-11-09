package com.logintest;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mem.model.MemVO;

@WebServlet("/LoginTest")
public class LoginTest extends HttpServlet {
	MemVO memVO = new MemVO();

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();

		// 【取得使用者 帳號(account) 密碼(password)】
		String account = req.getParameter("account");
		String password = req.getParameter("password");

		
		HttpSession session = req.getSession();
		session.setAttribute("account", account); // *工作1: 才在session內做已經登入過的標識

		try {
			String location = (String) session.getAttribute("location");
			if (location != null) {
				session.removeAttribute("location"); // *工作2: 看看有無來源網頁
														// (-->如有來源網頁:則重導至來源網頁)
				res.sendRedirect(location);
				return;
			}
		} catch (Exception ignored) {
		}

		String url = "/frontdesk/getmission/getMission.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url); // 如無來源網頁:則至此網頁
		successView.forward(req, res);
	}

}
