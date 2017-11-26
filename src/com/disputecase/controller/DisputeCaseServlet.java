package com.disputecase.controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.Authenticator.RequestorType;
import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.businessrefinery.barcode.QRCode;
import com.disputecase.model.DisputeCaseService;
import com.disputecase.model.DisputeCaseVO;
import com.getmission.model.GetMissionService;
import com.getmission.model.GetMissionVO;
import com.mem.model.MemService;
import com.mem.model.MemVO;

// TODO 新增案件請連上Session


@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class DisputeCaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//FrontDesk
	private static final String ISSUE_CASE 			= "/frontdesk/disputeCase/issueDisputeCase.jsp";
    private static final String ISSUE_CASE_SUCCESS 	= "/frontdesk/disputeCase/issueSuccess.jsp";
    private static final String ISSUE_CASE_FAILED 	= "/frontdesk/disputeCase/issueDisputeCaseFail.jsp";
    //BackDesk
    private static final String CASE_MANAGE 	= "/backdesk/disputecase/disputecase_Manage.jsp";
    private static final String GET_RESULT 		= "/backdesk/disputecase/disputecase_Result.jsp";
    private static final String CASE_REPLY		= "/backdesk/disputecase/disputecase_Reply.jsp";
    private static final String CASE_REPLY_SENT = "/backdesk/disputecase/disputecase_ReplySent.jsp";
    private static final String TEST_FAILED 	= "/backdesk/disputecase/disputecase_Fail_Closed.jsp";
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		DisputeCaseService disputeCaseService = new DisputeCaseService();
		
		/**
		 * @author
		 * @hidden search_Dispute_Case
		 * 查詢爭議案件
		 */
		if ("get_One_Dispute_Case".equals(action)) {
			List<String> errorMsg = new LinkedList<>();
			request.setAttribute("errorMsg", errorMsg);
			try {
				/********** 接收請求參數 - 文字 **********/
				String dispute_Case_No = request.getParameter("dispute_Case_No");
				DisputeCaseVO disputeCaseVO  = disputeCaseService.getOneDisputeCase(dispute_Case_No);
				
				System.out.println(dispute_Case_No);				
				/**********錯誤驗證與處理**********/
				if (dispute_Case_No == null||(dispute_Case_No.trim()).length() == 0) {
					errorMsg.add("請輸入案件編號");
				}
				if (disputeCaseVO == null) {
					errorMsg.add("無此案件!");
					RequestDispatcher failview = request.getRequestDispatcher(CASE_MANAGE);
					failview.forward(request, response);
				}
				if (disputeCaseVO.getDispute_Case_Status() != 1) {
					RequestDispatcher notAvailable = request.getRequestDispatcher(ISSUE_CASE_FAILED);
					notAvailable.forward(request, response);
				}
				if (!errorMsg.isEmpty()) {
					RequestDispatcher failview = request.getRequestDispatcher(CASE_MANAGE);
					for (String string : errorMsg) {
						System.out.println(string);
					}
					failview.forward(request, response);
				}
				
				/**********準備寫入與轉向**********/
				
				request.setAttribute("disputeCaseVO", disputeCaseVO);
				RequestDispatcher successView = request.getRequestDispatcher("/backdesk/disputecase/disputecase_Result.jsp");
				successView.forward(request, response);
			} catch (Exception e) {
				errorMsg.add(e.getMessage());
				RequestDispatcher failview = request.getRequestDispatcher(CASE_MANAGE);
				failview.forward(request, response);
			}
		}
		
		/**
		 * @author Sander
		 * @hidden issue_Dispute_Case
		 * 新增爭議案件
		 * 驗證爭議案件內容不為空，圖片可為空值
		 * 呼叫GetMissionService.missionDisputeCase 啟動爭議案件程序
		 */
		
		if ("issue_Dispute_Case".equals(action)) {
			List<String> errorMsg = new LinkedList<>();
			request.setAttribute("errorMsg", errorMsg);
			
			try {
				/********** 接收請求參數 - 文字 **********/
				String disputeContent = request.getParameter("dispute_Content");
				/********** 接收請求參數 - 圖片  **********/
				Part pic = request.getPart("dispute_Attachment");
				/********** 條件式 - 如果有上傳圖片(不為空值) **********/
				byte[] byteArrPic = null;
				if (pic != null) {
					InputStream inputStream = pic.getInputStream();
					byteArrPic = new byte[inputStream.available()];
					System.out.println(byteArrPic.length);
					inputStream.read(byteArrPic);
					inputStream.close();					
				}
				
				/**********錯誤驗證與處理**********/
				if (disputeContent == null && (disputeContent.trim()).length() == 0) {
					errorMsg.add("請輸入內文");
					System.out.println("輸入錯誤");
				}
				if (!errorMsg.isEmpty()) {
					RequestDispatcher failureView = request.getRequestDispatcher(ISSUE_CASE);
					failureView.forward(request, response);
					System.out.println("轉向");
					return; // Program interrupt.
				}
				
				/**********準備寫入與轉向**********/

				DisputeCaseVO disputeCaseVO = new DisputeCaseVO();
				disputeCaseVO.setDispute_Case_Status(1);
				disputeCaseVO.setDispute_Content(disputeContent);
				disputeCaseVO.setDispute_Attachment(byteArrPic);
				Date date = new Date();
				Timestamp timestamp = new Timestamp(date.getTime());
				// TODO 轉換任務狀態要有會員的SESSION
				GetMissionService getMissionService = new GetMissionService();
				getMissionService.missionFinish("MISSION000000027");
				// TODO 新增爭議案件要有會員的SESSION
				disputeCaseService.addDisputeCase(null, "MISSION000000027", "M000007", null, timestamp, null, 1, disputeContent, byteArrPic, null);
				System.out.println("新增爭議案件: "); // TODO 在console加上爭議案件編號
				
				RequestDispatcher issueDoneView = request.getRequestDispatcher(ISSUE_CASE_SUCCESS);
				issueDoneView.forward(request, response);
			} catch (Exception e) {
				errorMsg.add("無法取得資料" + e.getMessage());
				RequestDispatcher failureView = request.getRequestDispatcher(ISSUE_CASE);
				failureView.forward(request, response);
				System.out.println("轉向" + e.getMessage());
			}
		}
		
		/**
		 * @author Sander
		 * @Param reply_Dispute_Case
		 * 爭議勝訴，要做幾件事情:
		 * 1. 寫入回覆存入資料庫
		 * 2. 寫入結案時間存入資料庫
		 * 3. 改變爭議案件狀態
		 * 4. 改變任務狀態
		 * 5. 退回積分給發案人
		 * 6. 積分不給接案人
		 */
		
		if ("reply_Dispute_Case".equals(action)) {
			List<String> errorMsg = new LinkedList<>();
			request.setAttribute("errorMsg", errorMsg);
			
			try {
				/********** 接收請求參數 - 文字 **********/
				String disputeCaseNo = request.getParameter("dispute_Case_No");
				String disputeReply = request.getParameter("dispute_Reply");
				
				/**********錯誤驗證與處理**********/
				
				if (disputeCaseNo == null||(disputeCaseNo.trim()).length() == 0) {
					errorMsg.add("請輸入案件編號");
				}
				
				/**********準備寫入與轉向**********/
				// 抓原本VO出來
				DisputeCaseVO disputeCaseVO = disputeCaseService.getOneDisputeCase(disputeCaseNo);
				
				// 1. 寫入回覆存入資料庫
				// 2. 寫入結案時間存入資料庫
				// 3. 改變爭議案件狀態 - 爭議結案(3)		
				Date date = new Date();
				Timestamp timestamp = new Timestamp(date.getTime());
				disputeCaseService.replyDisputeCase(disputeCaseNo, timestamp, 3, disputeReply);		
				System.out.println("爭議案件結案: " + disputeCaseNo);

				// 4. 改變任務狀態 (5)
				GetMissionService getMissionService = new GetMissionService();
				String mission_No = disputeCaseVO.getMission_No();
				getMissionService.updateOneMissionStatus(mission_No, 5);
				System.out.println("狀態改變 - 任務: " + mission_No);
				
				// 5. 退回積分給發案人
				
				GetMissionVO getMissionVO = getMissionService.getOneMission(mission_No);
				Integer mission_Pay = 0;
				try {
					mission_Pay = Integer.parseInt((getMissionVO.getMission_Pay()).toString());
				} catch (NumberFormatException e) {
					System.out.println("數字格式錯誤，使用預設值50");
					mission_Pay = 50;
				}
				MemService memService = new MemService();
				MemVO memVO = memService.IncreaseMemPoint(getMissionVO.getIssuer_Mem_No(),mission_Pay);
				RequestDispatcher ReplyDoneView = request.getRequestDispatcher(CASE_REPLY_SENT);
				ReplyDoneView.forward(request, response);
			} catch (Exception e) {
				errorMsg.add("無法取得資料" + e.getMessage());
				// TODO ADD DISPATCH PAGE
				for (String string : errorMsg) {
					System.out.println(string);
				}
				RequestDispatcher failureView = request.getRequestDispatcher(TEST_FAILED); 
				failureView.forward(request, response);
				System.out.println("轉向" + e.getMessage());
			}
		}
		
		/**
		 * @author Sander
		 * @hidden reject_Dispute_Case
		 * 拒絕爭議案件，要做幾件事情:
		 * 1. 寫入回覆存入資料庫
		 * 2. 寫入結案時間存入資料庫
		 * 3. 改變爭議案件狀態
		 * 4. 改變任務狀態
		 * 5. 積分不退發案人
		 * 6. 積分給接案人
		 */
		
		if ("reject_Dispute_Case".equals(action)) {
			List<String> errorMsg = new LinkedList<>();
			request.setAttribute("errorMsg", errorMsg);
			try {
				/********** 接收請求參數 - 文字 **********/
				String disputeCaseNo = request.getParameter("dispute_Case_No");
				String dispute_Reject = request.getParameter("dispute_Reject");
				/**********錯誤驗證與處理**********/
				
				if (disputeCaseNo == null||(disputeCaseNo.trim()).length() == 0) {
					errorMsg.add("請輸入案件編號");
				}
				
				/**********準備寫入與轉向**********/
				// 抓原本VO出來
				DisputeCaseVO disputeCaseVO = disputeCaseService.getOneDisputeCase(disputeCaseNo);
				// 1. 寫入回覆存入資料庫
				// 2. 寫入結案時間存入資料庫
				// 3. 改變爭議案件狀態 - 退回爭議案件(4)		
				Date date = new Date();
				Timestamp timestamp = new Timestamp(date.getTime());
				disputeCaseService.replyDisputeCase(disputeCaseNo, timestamp, 4, dispute_Reject);		
				System.out.println("爭議案件退回: " + disputeCaseNo);
				
				// 4. 改變任務狀態 (5)
				GetMissionService getMissionService = new GetMissionService();
				String mission_No = disputeCaseVO.getMission_No();
				getMissionService.updateOneMissionStatus(mission_No, 5);
				System.out.println("狀態改變 - 任務: " + mission_No);
				
				// 5. 發積分給接案人
				GetMissionVO getMissionVO = getMissionService.getOneMission(mission_No);
				Integer mission_Pay = 0;
				try {
					mission_Pay = Integer.parseInt((getMissionVO.getMission_Pay()).toString());
				} catch (NumberFormatException e) {
					System.out.println("數字格式錯誤，使用預設值50");
					mission_Pay = 50;
				}
				MemService memService = new MemService();
				MemVO memVO = memService.IncreaseMemPoint(getMissionVO.getTakecase_Mem_No(),mission_Pay);
				// 轉到結案頁面
				RequestDispatcher ReplyDoneView = request.getRequestDispatcher(CASE_REPLY_SENT);
				ReplyDoneView.forward(request, response);
			} catch (Exception e) {
				errorMsg.add("無法取得資料" + e.getMessage());
				// TODO ADD DISPATCH PAGE
				for (String string : errorMsg) {
					System.out.println(string);
				}
				RequestDispatcher failureView = request.getRequestDispatcher(TEST_FAILED); 
				failureView.forward(request, response);
				System.out.println("轉向" + e.getMessage());
			}
		}
		
		
		/**
		 * @author Sander
		 * @hidden delete_Dispute_Case
		 * 刪除案件，只要呼叫service就可以 
		 */
		if ("delete_Dispute_Case".equals(action)) {
			List<String> errorMsg = new LinkedList<>();
			request.setAttribute("errorMsg", errorMsg);
			
			try {
				/********** 接收請求參數 - 文字 **********/
				String disputeCaseNo = request.getParameter("dispute_Case_No");
				
				/**********錯誤驗證與處理**********/
				
				if (disputeCaseNo == null||(disputeCaseNo.trim()).length() == 0) {
					errorMsg.add("請輸入案件編號");
				}
				
				/**********準備寫入與轉向**********/

				disputeCaseService.deleteDisputeCase(disputeCaseNo);
				System.out.println("刪除爭議案件: " + disputeCaseNo);
				RequestDispatcher issueDoneView = request.getRequestDispatcher(CASE_MANAGE);
				issueDoneView.forward(request, response);
			} catch (Exception e) {
				errorMsg.add("無法取得資料" + e.getMessage());
				// TODO ADD DISPATCH PAGE
				RequestDispatcher failureView = request.getRequestDispatcher(CASE_MANAGE); 
				failureView.forward(request, response);
				System.out.println("轉向" + e.getMessage());
			}
		}
	}
}