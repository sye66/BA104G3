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
  	String str_Mission_Pay = (missionVO.getMission_Pay().toString()).substring(0, (missionVO.getMission_Pay().toString()).indexOf(".")) + (missionVO.getMission_Pay().toString()).substring((missionVO.getMission_Pay().toString()).indexOf(".") + 1);
  	Integer mission_Pay = Integer.parseInt(str_Mission_Pay);
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
        background-image: url(<%=request.getContextPath()%>/res/images/disputecase/tweed.png);
        background-repeat: repeat;
    }
    </style>
    <title>回覆爭議案件</title>
</head>
<body>
    <div class="container" style="text-align: center">
        <div class="row">
            <div class="col-xs-12 col-sm-8 col-sm-offset-2 formcol">
                <%-- ----------------------------------------------------------- --%>
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
                <%-- ----------------------------------------------------------- --%>
                <div class="row">
                    <%-- 原任務類別 --%>
                    <div class="col-xs-12 col-sm-6">
                        <div class="form-group">
                            <label for="mission_Category">原任務類別</label>
                            <input type="text" name="mission_Category" id="mission_Category" class="form-control" value="<%=missionVO.getMission_Category()%>" readonly>
                        </div>
                    </div>
                    <%-- 原任務名稱 --%>
                    <div class="col-xs-12 col-sm-6">
                        <div class="form-group">
                            <label for="mission_Name">原任務名稱</label>
                            <input type="text" name="mission_Name" id="mission_Name" class="form-control" value="<%=missionVO.getMission_Name()%>" readonly>
                        </div>
                    </div>
                </div>
                <%-- ----------------------------------------------------------- --%>
                <div class="row">
                    <%-- 爭議提案人編號 --%>
                    <div class="col-xs-12 col-sm-6">
                        <div class="form-group">
                            <label for="dispute_Mem_No">爭議提案人編號</label>
                            <input type="text" name="dispute_Mem_No" id="dispute_Mem_No" class="form-control" value="<%=disputeCaseVO.getDispute_Mem_No()%>" readonly>
                        </div>
                    </div>
                    <%-- 原任務接案人 --%>
                    <div class="col-xs-12 col-sm-6">
                        <div class="form-group">
                            <label for="takecase_Mem_No">原任務接案人</label>
                            <input type="text" name="takecase_Mem_No" id="takecase_Mem_No" class="form-control" value="<%=missionVO.getTakecase_Mem_No()%>" readonly>
                        </div>
                    </div>
                </div>
                <%-- ----------------------------------------------------------- --%>
                <%-- 任務敘述 --%>
                <div class="row">
                    <div class="col-xs-12 col-sm-12">
                        <div class="form-group">
                            <label for="mission_Des">原任務敘述</label>
                            <input type="text" name="mission_Des" id="mission_Des" class="form-control" value="<%=missionVO.getMission_Des()%>" readonly="readonly">
                        </div>
                    </div>
                </div>
                <%-- 報酬 --%>
                <div class="row">
                    <div class="col-xs-12 col-sm-6">
                        <div class="form-group">
                            <label for="mission_Pay">報酬</label>
                            <input type="text" name="mission_Pay" id="mission_Pay" class="form-control" value="<%=mission_Pay%>" readonly>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6">
                        <div class="form-group">
                            <label for="issue_Datetime">發案時間</label>
                            <input type="text" name="issue_Datetime" id="issue_Datetime" class="form-control" value="<%=simpleDateFormat.format(disputeCaseVO.getIssue_Datetime())%>" readonly>
                        </div>
                    </div>
                </div>
                <%-- 申訴內容 --%>
                <div class="row">
                    <div class="col-xs-12 col-sm-12">
                        <div class="form-group">
                            <label for="dispute_Content">申訴內容</label>
                            <input type="text" name="dispute_Content" id="dispute_Content" class="form-control" value="<%=disputeCaseVO.getDispute_Content()%>" readonly="readonly">
                        </div>
                    </div>
                </div>
                <%-- 爭議任務圖片 --%>
                <div class="row" style="text-align: center">
                    <img src="<%=request.getContextPath()%>/disputecase/disputecase.do?action=get_Picture&dispute_Case_No=<%=disputeCaseNo%>" id="dispute_Attachment">
                </div>
                    <div class="row" style="text-align: center; margin-top: 20px;">
                        <button id="emp_Get_Case" class="btn btn-primary">接手此案件</button>
                        <a href="<%=request.getContextPath()%>/backdesk/disputecase/disputecase_New.jsp">
                            <button id="so_lazy" class="btn btn-warning">算了好麻煩喔</button>
                        </a>
                    </div>
            </div>
        </div>
    </div>
    </div>
</body>
<script type="text/javascript">
    $('#emp_Get_Case').click(function() {
        $.ajax({
            url: '<%=request.getContextPath()%>/disputecase/disputecase.do',
            type: 'POST',
            data: {
                action: 'emp_Get_Case',
                emp_No: "${empVO.emp_No}",
                dispute_Case_No: "<%=disputeCaseNo%>"
            },
        })
        .done(function() {
            console.log("success");
            swal({
                  type: 'success',
                  title: '接收爭議案件：<%=disputeCaseNo%>',
                  showConfirmButton: false,
                  timer: 1500
            })
            setTimeout(function () {
                window.location.replace("<%=request.getContextPath()%>/backdesk/disputecase/disputecase_New.jsp")
            },1600)
        })
        .fail(function() {
            console.log("error");
        })
    });
</script>
</html>