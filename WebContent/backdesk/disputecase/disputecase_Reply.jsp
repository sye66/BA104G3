
<%@page import="com.getmission.model.GetMissionVO"%>
<%@page import="com.getmission.model.GetMissionService"%>
<%@page import="com.mem.model.MemService"%>
<%@page import="com.mem.model.MemVO"%>
<%@page import="com.disputecase.model.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 取出來自爭議案件 管理頁面的請求參數(dispute_case_no)
	String disputeCaseNo = (String) request.getParameter("dispute_Case_No");
	System.out.print(disputeCaseNo);
	// DisputeCaseVO取出
	DisputeCaseService disputeCaseService = new DisputeCaseService();
	DisputeCaseVO disputeCaseVO = disputeCaseService.getOneDisputeCase(disputeCaseNo);
	// MemVO取出
	MemService memService = new MemService();
	MemVO memVO = memService.getOneMem(disputeCaseVO.getDispute_Mem_No());
	// GetMissionVO取出
	GetMissionService getMissionService = new GetMissionService();
	GetMissionVO missionVO = getMissionService.getOneMission(disputeCaseVO.getMission_No());
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
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
<title>回覆爭議案件</title>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-8 col-sm-offset-2">
                <div class="row">
                    <%-- 爭議案件編號 --%>
                    <div class="col-xs-12 col-sm-6">
                        <div class="form-group">
                            <label for="dispute_Case_No">爭議案件編號</label>
                            <input type="text" name="dispute_Case_No" id="dispute_Case_No" class="form-control" value="<%=disputeCaseVO.getDispute_Case_No()%>" readonly>
                        </div>
                    </div>
                    <%-- 原任務編號 --%>
                    <div class="col-xs-12 col-sm-6">
                        <div class="form-group">
                            <label for="mission_No">原任務編號</label>
                            <input type="text" name="mission_No" id="mission_No" class="form-control" value="<%=disputeCaseVO.getMission_No()%>" readonly>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <%-- 爭議提案人編號 --%>
                    <div class="col-xs-12 col-sm-6">
                        <div class="form-group">
                            <label for="dispute_Mem_No">爭議提案人編號</label>
                            <input type="text" name="dispute_Mem_No" id="dispute_Mem_No" class="form-control" value="<%=disputeCaseVO.getDispute_Mem_No()%>" readonly>
                        </div>
                    </div>
                    <%-- 員工編號 --%>
                    <div class="col-xs-12 col-sm-6">
                        <div class="form-group">
                            <label for="issue_Datetime">發案時間</label>
                            <input type="text" name="issue_Datetime" id="issue_Datetime" class="form-control" value="<%=simpleDateFormat.format(disputeCaseVO.getIssue_Datetime())%>" readonly>
                        </div>
                    </div>
                </div>
                <%-- 申訴內容 --%>
                <div class="form-group">
                    <label for="dispute_Content">申訴內容</label>
                    <input type="text" name="dispute_Content" id="dispute_Content" class="form-control" value="<%=disputeCaseVO.getDispute_Content()%>" readonly="readonly">
                </div>
                <!-- 回覆modal -->
                <a href='#modal-id' data-toggle="modal" class="btn btn-primary">回覆此案件</a>
                <div class="modal fade" id="modal-id">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="<%=request.getContextPath()%>/disputecase/disputecase.do">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">回覆訊息</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="text" name="dispute_Reply" id="dispute_Reply" class="form-control" placeholder="請輸入回覆訊息" style="height: 200px">
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
                                    <input type="hidden" name="dispute_Case_No" value="<%=disputeCaseNo%>">
                                    <input type="hidden" name="action" value="reply_Dispute_Case">
                                    <input type="submit" class="btn btn-primary" value="回覆">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>                
                <!-- 退回modal -->
                <a href='#modal-id2' data-toggle="modal" class="btn btn-warning">退回此案件</a>
                <div class="modal fade" id="modal-id2">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <!-- 表單從此開始 -->
                            <form method="post" action="<%=request.getContextPath()%>/disputecase/disputecase.do">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">退回原因</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="text" name="dispute_Reject" id="dispute_Reject" class="form-control" placeholder="請輸入退回原因" style="height: 200px">
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
                                    <input type="hidden" name="dispute_Case_No" value="<%=disputeCaseNo%>">
                                    <input type="hidden" name="action" value="reject_Dispute_Case">
                                    <input type="submit" class="btn btn-warning" value="退回">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</body>

</html>