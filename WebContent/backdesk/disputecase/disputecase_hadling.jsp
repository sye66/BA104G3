<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.disputecase.model.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	DisputeCaseService disputeCaseService = new DisputeCaseService();
	List<DisputeCaseVO> listAllDisputeCase = disputeCaseService.getDisputeCaseByStatus(2);
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/mm/dd hh:mm:ss");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<style type="text/css">
	.mt30{
		margin-top: 30px;
	}
</style>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/disputecase/backdeskLeft_DisputeCase.jsp" flush="true" />

	<%-- 列出所有爭議案件 --%>
	<%-- include的file占了兩col，寫9個別靠到邊界 --%>
	<div class="col-xs-12 col-sm-9 mt30">
		<h2>爭議案件 - 處理中</h2>
		<table class="table table-hover mt30">
			<thead>
				<tr>
					<th>案件編號</th>
					<th>原任務編號</th>
					<th>提出人</th>
					<th>發案時間</th>
				</tr>
			</thead>
			<tbody>
				<%for(DisputeCaseVO disputeCaseVO : listAllDisputeCase){%>
				<tr>
					<td><%=disputeCaseVO.getDispute_Case_No()%></td>
					<td><%=disputeCaseVO.getMission_No()%></td>
					<td><%=disputeCaseVO.getDispute_Mem_No() %></td>
					<td><%=simpleDateFormat.format(disputeCaseVO.getIssue_Datetime())%></td>
					<td><button class="btn-primary">查看</button></td>
				</tr>
				<%}%>
			</tbody>
</body>
</html>