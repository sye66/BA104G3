package com.tool.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.mem.model.MemVO;

public class LoginFilter implements Filter {

	private FilterConfig config;

	public void init(FilterConfig config) {
		this.config = config;
	}

	public void destroy() {
		config = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws ServletException, IOException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		// 【取得 session】
		HttpSession session = req.getSession();
		// 【從 session 判斷此user是否登入過】
		MemVO memVO = (MemVO) session.getAttribute("memVO");
System.out.println(session.getAttribute("memVO"));
		if (memVO.getMem_State() == null || memVO.getMem_State() == 9) {
			session.setAttribute("location", req.getRequestURI());
			res.sendRedirect(req.getContextPath() + "/lib/publicfile/include/file/index.jsp");
			return;
		} else {
			 chain.doFilter(request, response);
		}
	}
}