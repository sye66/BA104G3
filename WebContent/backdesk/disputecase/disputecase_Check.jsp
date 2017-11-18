<%@page import="com.mem.model.MemVO"%>
<%@page import="com.disputecase.model.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//取出來自爭議案件 管理頁面的請求參數(dispute_case_no)
	String disputeCaseNo = (String) request.getParameter("dispute_Case_No");
	DisputeCaseService disputeCaseService = new DisputeCaseService();
	DisputeCaseVO disputeCaseVO = disputeCaseService.getOneDisputeCase(disputeCaseNo);
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
	//DisputeCaseVO disputeCaseVO = (DisputeCaseVO) request.getAttribute("disputeCaseVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; chaset=UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>查看爭議案件</title>
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-8 col-sm-offset-2">
				<form method="post"
					action="<%=request.getContextPath()%>/disputecase/disputecase.do">
					<div class="row">
						<div class="col-xs-12 col-sm-6">
							<div class="form-group">
								<label for="dispute_Case_No">爭議案件編號</label> <input type="text"
									name="dispute_Case_No" id="dispute_Case_No"
									class="form-control"
									value="<%=disputeCaseVO.getDispute_Case_No()%>" readonly>
							</div>
						</div>
						<div class="col-xs-12 col-sm-6">
							<div class="form-group">
								<label for="mission_No">原任務編號</label> <input type="text"
									name="mission_No" id="mission_No" class="form-control"
									value="<%=disputeCaseVO.getMission_No()%>" readonly>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-4">
							<div class="form-group">
								<label for="dispute_Mem_No">爭議提案人編號</label> <input type="text"
									name="dispute_Mem_No" id="dispute_Mem_No" class="form-control"
									value="<%=disputeCaseVO.getDispute_Mem_No()%>" readonly>
							</div>
						</div>
						<div class="col-xs-12 col-sm-4">
							<div class="form-group">
								<label for="emp_No">員工編號</label> <input type="text"
									name="emp_No" id="emp_No" class="form-control"
									value="<%=disputeCaseVO.getEmp_No()%>" readonly>
							</div>
						</div>
						<div class="col-xs-12 col-sm-4">
							<div class="form-group">
								<label for="issue_Datetime">發案時間</label> <input type="text"
									name="issue_Datetime" id="issue_Datetime" class="form-control"
									value="<%=simpleDateFormat.format(disputeCaseVO.getIssue_Datetime())%>"
									readonly>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="dispute_Content">申訴內容</label> <input type="text"
							name="dispute_Content" id="dispute_Content" class="form-control"
							value="<%=disputeCaseVO.getDispute_Content()%>">
					</div>

					<div class="form-group">
						<label for="dispute_Reply">申訴回復</label> <input type="text"
							name="dispute_Reply" id="dispute_Reply" placeholder="文字"
							class="form-control"> <input type="hidden" name="action"
							value="reply_Dispute_Case">

						<div class="col-xs-12 col-sm-12"
							style="margin-top: 30px; text-align: center;">
							<input type="submit" class="btn btn-primary" value="回覆爭議案件">
							<input type="button" name="">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>
</body>

</html>