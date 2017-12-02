package com.missioncomment.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.mem.model.MemVO;
import com.missioncomment.model.*;

public class MissionCommentServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("");
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
		JSONObject obj = new JSONObject();

		if ("givecomment".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			
			MemVO memVO = (MemVO) req.getSession().getAttribute("memVO");
			if (memVO == null) {
				errorMsgs.add("請登入再來喔");
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);

				return;
			} else if (memVO.getMem_State() == 0) {
				errorMsgs.add("請驗證再來喔");
				System.out.println(errorMsgs);
				RequestDispatcher failureView = req.getRequestDispatcher("/frontdesk/getmission/getMission.jsp");
				failureView.forward(req, res);

				return;
			}
			
			try{
				String mission_No = (String)req.getParameter("mission_No");
				Integer comment_Point = new Integer(req.getParameter("comment_Point"));
				String listener = (String)req.getParameter("listener");
				String comment_Detail = (String)req.getParameter("comment_Detail");
				
				MissionCommentService missionCommentSvc = new MissionCommentService();
				MissionCommentVO missionCommentVO = new MissionCommentVO();
				
				missionCommentSvc.addMissionComment(memVO.getMem_No(), listener, mission_No, comment_Detail, comment_Point);
				missionCommentVO = (MissionCommentVO) missionCommentSvc.getByReviewer(memVO.getMem_No());
				
				req.setAttribute("missionCommentVO", missionCommentVO);
				RequestDispatcher failureView = req.getRequestDispatcher("");
				failureView.forward(req, res);
				return;
				
			}catch (Exception e) {
				System.out.println(e);
				errorMsgs.add("評論:" + e.getMessage());
				req.setAttribute("errorMsgs", errorMsgs);
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
				return;
			}
		}
	}

}
