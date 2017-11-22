package com.disputecase.controller;

import java.io.IOException;
import java.io.InputStream;
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




@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)



public class DisputeCaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
	
		
		/**
		 * @author Sander
		 * @hidden issue_Dispute_Case
		 * 只需驗證爭議案件內容不為空即可，圖片可為空值
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
					errorMsg.add("輸入錯誤");
					System.out.println("輸入錯誤");
				}
				if (!errorMsg.isEmpty()) {
					RequestDispatcher failureView = request.getRequestDispatcher("/frontdesk/disputeCase/issueDisputeCase.jsp");
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
				DisputeCaseService disputeCaseService = new DisputeCaseService();
				// TODO 新增爭議案件要有會員的SESSION
				disputeCaseService.addDisputeCase(null, "MISSION000000027", "M000007", null, timestamp, null, 1, disputeContent, byteArrPic, null);
				System.out.println("新增爭議案件: "); // TODO 在console加上爭議案件編號
				RequestDispatcher issueDoneView = request.getRequestDispatcher("/frontdesk/disputeCase/issueSuccess.jsp");
				issueDoneView.forward(request, response);
			} catch (Exception e) {
				errorMsg.add("無法取得資料" + e.getMessage());
				RequestDispatcher failureView = request.getRequestDispatcher("/frontdesk/disputeCase/issueDisputeCase.jsp");
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
				
				// 無錯誤驗證，直接抓出原本VO開始寫入值
				
				/**********準備寫入與轉向**********/
				
				// 抓原本VO出來
				
				DisputeCaseService disputeCaseService = new DisputeCaseService();
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
				
				// 嘗試加入QRcode
				response.setContentType("image/jpeg");
				System.out.println("寫QRCODE中");
				try {
				    // new QRcode物件
				    QRCode barcode = new QRCode();
				    // 填入要轉碼的資訊
				    barcode.setCode("https://www.google.com");
				    // 設定大小，15~20效果不錯
				    barcode.setModuleSize(15);
				    // 解析度
				    barcode.setResolution(144);
				    // 傳入byte陣列
				    byte[] barcodeByteArr = barcode.drawImage2Bytes();
				    request.setAttribute("barcodeByteArr", barcodeByteArr);
				    System.out.println("寫完囉");
				} catch (Exception e) {
				    throw new ServletException(e);
				}
				
				
				RequestDispatcher ReplyDoneView = request.getRequestDispatcher("/backdesk/disputecase/disputecase_Success.jsp");
				ReplyDoneView.forward(request, response);
			} catch (Exception e) {
				errorMsg.add("無法取得資料" + e.getMessage());
				// TODO ADD DISPATCH PAGE
				RequestDispatcher failureView = request.getRequestDispatcher("/backdesk/disputecase/disputecase_Success.jsp"); 
				failureView.forward(request, response);
				System.out.println("轉向" + e.getMessage());
			}
		}
		
		if ("delete_Dispute_Case".equals(action)) {
			List<String> errorMsg = new LinkedList<>();
			request.setAttribute("errorMsg", errorMsg);
			
			try {
				/********** 接收請求參數 - 文字 **********/
				String disputeCaseNo = request.getParameter("dispute_Case_No");
				
				/**********錯誤驗證與處理**********/
				
				// 無錯誤驗證，直接刪除
				
				/**********準備寫入與轉向**********/

				DisputeCaseService disputeCaseService = new DisputeCaseService();
				disputeCaseService.deleteDisputeCase(disputeCaseNo);
				System.out.println("刪除爭議案件: " + disputeCaseNo);
				RequestDispatcher issueDoneView = request.getRequestDispatcher("/backdesk/disputeCase/disputecase_manage.jsp");
				issueDoneView.forward(request, response);
			} catch (Exception e) {
				errorMsg.add("無法取得資料" + e.getMessage());
				// TODO ADD DISPATCH PAGE
				RequestDispatcher failureView = request.getRequestDispatcher("/backdesk/disputeCase/disputecase_manage.jsp"); 
				failureView.forward(request, response);
				System.out.println("轉向" + e.getMessage());
			}
		}
	}
}