<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<jsp:useBean id="missionImagesSvc" scope="page"
	class="com.missionimages.model.MissionImagesService" />
<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<%@ page import="com.getmission.model.*"%>
<%@ page import="com.missionimages.model.*"%>
<%@ page import="com.accusecase.model.*"%>
<jsp:useBean id="accusecaseSvc" scope="page"
	class="com.accusecase.model.AccuseCaseService" />

<%
	GetMissionVO getMissionVO = (GetMissionVO) request.getAttribute("getMissionVO");

	String errorMsgs = (String) session.getAttribute("errorMsgs");
%>

<!DOCTYPE html>
<html lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>missionManage</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>

	<%@ include file="/backdesk/backdeskTop.jsp"%>
	<div class="container">
		<div class="row"></div>
	</div>

	<%@ include file="/backdesk/missionManage/missiondeskLeft.jsp"%>

	<div class="col-xs-12 col-sm-9 mission">
		<div class="panel panel-info mission">
			<div class="panel-heading mission">
				<h3 class="panel-title">推推阿緯工具人</h3>
			</div>
			<div class="panel-body mission">內容文字</div>
			<table class="table mission" border="1">
				<c:forEach var="accusecaseVO" items="${accusecaseSvc.getAll()}"
					varStatus="a" step="1">
					<tr>
						<td>${accusecaseVO.accuse_No}</td>
						<td>${accusecaseVO.mission_No}</td>
						<td>${getMissionSvc.getOneMission(accusecaseVO.mission_No).mission_No}</td>
						<td>${memSvc.getOneMem(getMissionSvc.getOneMission(accusecaseVO.mission_No).issuer_Mem_No).mem_Id}</td>
						<td>${accusecaseVO.accuser_No}</td>
						<td>${memSvc.getOneMem(accusecaseVO.accuser_No).mem_Id}</td>
						<td>${accusecaseVO.accuse_Date}</td>
						<td>${accusecaseVO.accuse_Detail}</td>
						<form method="post" action="<%=request.getContextPath()%>/accusecase/accusecase.do" name="accusecase1">
						<td>
						<select id="accuse_State" name="accuse_State">
								<option value="-1">檢舉審核中</option>
								<option value="2">檢舉成功</option>
								<option value="3">打回檢舉</option>
						</select>
						</td>
						<td>
						<button class="btn btn-info" type="submit" name="action" value="manageaccuse">審核確認</button>

						<input type="hidden" name="mission_No" value="${accusecaseVO.accuse_No}"> 
						<input type="hidden" name="requestURL" value="/bakedesk/missionManage/missionManage.jsp">
						
						</td>
						</from>
						<td>
						<div class="panel-body">
										<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission1">
											<button class="btn btn-warning" type="submit" name="action"
												value="mission_Detail">任務細節</button>

											<input type="hidden" name="mission_No"
												value="${accusecaseVO.mission_No}"> 
											<input type="hidden" name="requestURL"
												value="/bakedesk/missionManage/missionManage.jsp">
										</form>
						</div>
						</td>
					</tr>
				</c:forEach>


			</table>
		</div>
	</div>
</body>
</html>