<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.emp.model.EmpVO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.disputecase.model.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
EmpVO empVO;
List<DisputeCaseVO> listAllCase;
// 列出所有未處理案件
List<DisputeCaseVO> listAllPendingCase;
// 列出該員工的處理中案件
List<DisputeCaseVO> listEmpHandlingCase;
// 列出所有已結案案件
List<DisputeCaseVO> listAllClosedCase;
// 列出所有已退回案件
List<DisputeCaseVO> listAllRejectCase;
SimpleDateFormat simpleDateFormat;
try{
	empVO = (EmpVO) request.getSession().getAttribute("empVO");
	if (empVO.getEmp_No() == null){
		RequestDispatcher notLogin = request.getRequestDispatcher("/backdesk/index.jsp");
		notLogin.forward(request, response);
		return;
	}
	DisputeCaseService disputeCaseService = new DisputeCaseService();
	listAllCase = disputeCaseService.getAllDisputeCase();
	// 列出所有未處理案件
	listAllPendingCase = disputeCaseService.getDisputeCaseByStatus(1);
	// 列出該員工的處理中案件
	listEmpHandlingCase = disputeCaseService.getDisputeCaseByStatus(2, empVO.getEmp_No());
	// 列出所有已結案案件
	listAllClosedCase = disputeCaseService.getDisputeCaseByStatus(3);
	// 列出所有已退回案件
	listAllRejectCase = disputeCaseService.getDisputeCaseByStatus(4);
	simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
} catch (NullPointerException e) {
	RequestDispatcher notLogin = request.getRequestDispatcher("/backdesk/index.jsp");
	notLogin.forward(request, response);
	return;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/font-awesome/css/font-awesome.css">
<style type="text/css">
	.huge {
    font-size: 50px;
    margin: 15px;
	}
</style>
<title>爭議案件 - 已結案</title>
</head>
<body>

	<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/missionManage/missiondeskLeft.jsp" flush="true" />	<br>
	<br>
	<br>
	<div class="container">
	<%-- 上方圖示列表 --%>
		<div class="row">
			<%-- 未處理案件 --%>
			<div class="col-xs-12 col-sm-3">
			    <div class="panel panel-red" style="background-color: #d9534f; color: white;">
			        <div class="panel-heading">
			            <div class="row">
			                <div class="col-xs-3">
			                    <i class="fa fa-exclamation fa-5x"></i>
			                </div>
			                <div class="col-xs-9 text-right">
			                    <div class="huge"><%=listAllPendingCase.size()%></div>
			                    <div>新增案件</div>
			                </div>
			            </div>
			        </div>
			        <a href="<%=request.getContextPath()%>/backdesk/disputecase/disputecase_New.jsp">
			            <div class="panel-footer">
			                <span class="pull-left">查看細節</span>
			                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
			                <div class="clearfix"></div>
			            </div>
			        </a>
			    </div>
			</div>
			<%-- 爭議處理中 --%>
			<div class="col-xs-12 col-sm-3">
			    <div class="panel panel-primary" style="background: #5cb85c; color: white;">
			        <div class="panel-heading">
			            <div class="row">
			                <div class="col-xs-3">
			                    <i class="fa fa-comments fa-5x"></i>
			                </div>
			                <div class="col-xs-9 text-right">
			                    <div class="huge"><%=listEmpHandlingCase.size()%></div>
			                    <div>正在處理中</div>
			                </div>
			            </div>
			        </div>
			        <a href="<%=request.getContextPath()%>/backdesk/disputecase/disputecase_OnGoing.jsp">
			            <div class="panel-footer">
			                <span class="pull-left">查看細節</span>
			                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
			                <div class="clearfix"></div>
			            </div>
			        </a>
			    </div>
			</div>
			<%-- 爭議結案 --%>
			<div class="col-xs-12 col-sm-3">
			    <div class="panel panel-green" style="background-color: #5cb85c; color: white;">
			        <div class="panel-heading">
			            <div class="row">
			                <div class="col-xs-3">
			                    <i class="fa fa-check-circle-o fa-5x"></i>
			                </div>
			                <div class="col-xs-9 text-right">
			                    <div class="huge"><%=listAllClosedCase.size() %></div>
			                    <div>已經結案</div>
			                </div>
			            </div>
			        </div>
			        <a href="<%=request.getContextPath()%>/backdesk/disputecase/disputecase_Closed.jsp">
			            <div class="panel-footer">
			                <span class="pull-left">查看細節</span>
			                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
			                <div class="clearfix"></div>
			            </div>
			        </a>
			    </div>
			</div>
			<%-- 退回案件 --%>
			<div class="col-xs-12 col-sm-3">
			    <div class="panel panel-yellow" style="background-color: #f0ad4e; color: white;">
			        <div class="panel-heading">
			            <div class="row">
			                <div class="col-xs-3">
			                    <i class="fa fa-window-close-o fa-5x"></i>
			                </div>
			                <div class="col-xs-9 text-right">
			                    <div class="huge"><%=listAllRejectCase.size()%></div>
			                    <div>案件退回</div>
			                </div>
			            </div>
			        </div>
			        <a href="<%=request.getContextPath()%>/backdesk/disputecase/disputecase_Rejected.jsp">
			            <div class="panel-footer">
			                <span class="pull-left">查看細節</span>
			                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
			                <div class="clearfix"></div>
			            </div>
			        </a>
			    </div>
			</div>
		</div>
		<br>
		<br>
		<br>
		<div class="row">
			<%-- 待處理案件列出 --%>
			<div class="col-xs-12 col-sm-12">
		        <table class="table table-hover">
		            <h2>爭議案件 - 待處理</h2>
		            <thead>
		                <tr>
		                    <th>案件編號</th>
		                    <th>原任務編號</th>
		                    <th>提出人(發案人)</th>
		                    <th>申請爭議時間</th>
		                    <th>案件結束時間</th>
		                    <th>負責員工</th>
		                </tr>
		            </thead>
		            <tbody>
		                <%for(DisputeCaseVO disputeCaseVO : listAllClosedCase){%>
		                    <tr>
		                        <td>
		                            <%=disputeCaseVO.getDispute_Case_No()%>
		                        </td>
		                        <td>
		                            <%=disputeCaseVO.getMission_No()%>
		                        </td>
		                        <td>
		                            <%=disputeCaseVO.getDispute_Mem_No() %>
		                        </td>
		                        <td>
		                            <%=simpleDateFormat.format(disputeCaseVO.getIssue_Datetime())%>
		                        </td>
		                        <td>
									<%=simpleDateFormat.format(disputeCaseVO.getClose_Datetime())%>
								</td>
								<td>
									<%=disputeCaseVO.getEmp_No()%>
		                        </td>
		                    </tr>
		                <%}%>
		            </tbody>
		    	</table>
			</div>
		</div>
	</div>
</body>
</html>