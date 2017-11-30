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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>
    <style type="text/css">
    #dispute_Attachment {
        width: 200px;
    }
    .formcol{
        border-radius: 15px;
        padding-top: 50px;
        padding-bottom: 50px;
        margin-top: 30px;
        background-color: #34445e;
        border: #ff9000 solid 2px;
        color: white;
        font-family: "微軟正黑體";
    }

    body {
        background-image: url(<%=request.getContextPath()%>/res/images/disputecase/white-scratched-background-2074.png);
        background-repeat: repeat;
    }
    </style>
<title>回覆爭議案件</title>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-8 col-sm-offset-2 formcol">
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
                    <div class="row" style="text-align: center">
                        <img src="<%=request.getContextPath()%>/disputecase/disputecase.do?action=get_Picture&dispute_Case_No=<%=disputeCaseNo%>" id="dispute_Attachment">
                    </div>
                    <div class="row" style="text-align: center; margin-top: 20px;">
                        <a href='#modal-id' data-toggle="modal" class="btn btn-primary">回覆此案件</a>
                        <a href='#modal-id2' data-toggle="modal" class="btn btn-warning">退回此案件</a>
                    </div>

                <!-- 回覆modal -->
                <div class="modal fade" id="modal-id">
                    <div class="modal-dialog">
                        <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">回覆訊息</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="text" name="dispute_Reply" id="dispute_Reply" class="form-control" placeholder="請輸入回覆訊息" style="height: 200px">
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-primary" id="reply_Dispute_Case">回覆</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
                                </div>
                        </div>
                    </div>
                </div>                
                <!-- 退回modal -->
                <div class="modal fade" id="modal-id2">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <!-- 表單從此開始 -->
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">退回原因</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="text" name="dispute_Reject" id="dispute_Reject" class="form-control" placeholder="請輸入退回原因" style="height: 200px">
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-warning" id="reject_Dispute_Case" >退回</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button> 
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $("#reply_Dispute_Case").click(function(){
        $.ajax({
            url: '<%=request.getContextPath()%>/disputecase/disputecase.do',
            type: 'post',
            data:{
                action: "reply_Dispute_Case",
                dispute_Case_No: "<%=disputeCaseVO.getDispute_Case_No()%>",
                dispute_Reply: $("#dispute_Reply").val()
            },
            success: function(){
                swal({
                      type: 'success',
                      title: '已回覆該用戶',
                      showConfirmButton: false,
                      timer: 1500
                    })
                setTimeout(function(){
                    window.location.replace("<%=request.getContextPath()%>/backdesk/disputecase/disputecase_OnGoing.jsp")
                    },1600)
            }

        })

    })
    $("#reject_Dispute_Case").click(function(){
        $.ajax({
            url: '<%=request.getContextPath()%>/disputecase/disputecase.do',
            type: 'post',
            data:{
                action: "reject_Dispute_Case",
                dispute_Case_No: "<%=disputeCaseVO.getDispute_Case_No()%>",
                dispute_Reject: $("#dispute_Reject").val()
            },
            success: function(){
                swal({
                      type: 'success',
                      title: '此爭議案件退回',
                      showConfirmButton: false,
                      timer: 1500
                    })
                setTimeout(function(){
                    window.location.replace("<%=request.getContextPath()%>/backdesk/disputecase/disputecase_OnGoing.jsp")
                    },1600)
            }

        })

    })
</script>

</body>

</html>