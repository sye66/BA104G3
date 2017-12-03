<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" />

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
				<h3 class="panel-title">檢舉處理</h3>
				<div role="tabpanel">
					<!-- 標籤面板：標籤區 -->
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="#tab1"
							aria-controls="tab1" role="tab" data-toggle="tab">檢舉處理中</a></li>
						<li role="presentation"><a href="#tab2" aria-controls="tab2"
							role="tab" data-toggle="tab">處理完成歷史查閱</a></li>

					</ul>

					<!-- 標籤面板：內容區 -->
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane active" id="tab1">
							<div>${empSvc.getOneEmp(empVO.emp_No).emp_Name}~請趕快處理</div>
							<div class="panel-body mission">
								<c:if test="${errorMsgs.size() !=0}">
			${errorMsgs}
			</c:if>
							</div>
							<table class="table mission" border="1">
								<td>檢舉文件編號</td>
								<td>受檢舉任務編號</td>
								<td>受檢舉任務名稱</td>
								<td>發案人</td>
								<td>檢舉人編號</td>
								<td>檢舉人</td>
								<td>檢舉日期</td>
								<td>檢舉細節</td>
								<td>處理選項</td>
								<td>處理確認</td>
								<td>任務細節</td>
								<c:forEach var="accusecaseVO" items="${accusecaseSvc.getAll()}"
									varStatus="a" step="1">
									<c:if test="${accusecaseVO.accuse_State ==1}">
										<tr>
											<td>${accusecaseVO.accuse_No}</td>
											<td>${getMissionSvc.getOneMission(accusecaseVO.mission_No).mission_No}</td>
											<td>${getMissionSvc.getOneMission(accusecaseVO.mission_No).mission_Name}</td>
											<td>${memSvc.getOneMem(getMissionSvc.getOneMission(accusecaseVO.mission_No).issuer_Mem_No).mem_Id}</td>
											<td>${accusecaseVO.accuser_No}</td>
											<td>${memSvc.getOneMem(accusecaseVO.accuser_No).mem_Id}</td>
											<td>${accusecaseVO.accuse_Date}</td>
											<td>${accusecaseVO.accuse_Detail}</td>
											<form method="post" action="<%=request.getContextPath()%>/accusecase/accusecase.do" name="accusecase1">
												<td><select id="accuse_State" name="accuse_State">
														<option value="1">檢舉審核中</option>
														<option value="2">檢舉成功</option>
														<option value="3">打回檢舉</option>
												</select></td>
												<td>
													<button class="btn btn-info" type="submit" name="action" value="manageaccuse">審核確認</button> 
													<input type="hidden" name="accuse_No" value="${accusecaseVO.accuse_No}">
													<input type="hidden" name="mission_No" value="${accusecaseVO.mission_No}">
													<input type="hidden" name="requestURL" value="/backdesk/missionManage/missionManage.jsp">
												</td>
											</form>
											<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission1">
												<td>
													
														<button class="btn btn-warning" type="submit" name="action" value="mission_Detail">任務細節</button>
														<input type="hidden" name="mission_No" value="${accusecaseVO.mission_No}"> 
														<input type="hidden" name="requestURL" value="/bakedesk/missionManage/missionManage.jsp">
													
												</td>
											</form>
										</tr>
									</c:if>
								</c:forEach>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="tab2">
						<div>歷史查閱</div>
						<div class="panel-body mission">
			<c:if test="${errorMsgs.size() !=0}">
			${errorMsgs}
			</c:if>
			</div>
			<table class="table mission" border="1">
				<td>檢舉文件編號</td>
				<td>受檢舉任務編號</td>
				<td>受檢舉任務名稱</td>
				<td>發案人</td>
				<td>檢舉人編號</td>
				<td>檢舉人</td>
				<td>檢舉日期</td>
				<td>檢舉細節</td>
				<td>處理結果</td>
				<td>處理員工編號</td>
				<td>處理員工名</td>
				<td>任務細節</td>
				<c:forEach var="accusecaseVO" items="${accusecaseSvc.getAll()}"
					varStatus="a" step="1">
					<c:if test="${accusecaseVO.accuse_State !=1}">
					<tr>
						<td>${accusecaseVO.accuse_No}</td>
						<td>${getMissionSvc.getOneMission(accusecaseVO.mission_No).mission_No}</td>
						<td>${getMissionSvc.getOneMission(accusecaseVO.mission_No).mission_Name}</td>
						<td>${memSvc.getOneMem(getMissionSvc.getOneMission(accusecaseVO.mission_No).issuer_Mem_No).mem_Id}</td>
						<td>${accusecaseVO.accuser_No}</td>
						<td>${memSvc.getOneMem(accusecaseVO.accuser_No).mem_Id}</td>
						<td>${accusecaseVO.accuse_Date}</td>
						<td>${accusecaseVO.accuse_Detail}</td>
						<td>
						<c:if test="${accusecaseVO.accuse_State ==2}">
						成功檢舉,任務已失效
						</c:if>
						<c:if test="${accusecaseVO.accuse_State ==3}">
						檢舉打回,任務正常進行
						</c:if>
						</td>
						<td>${accusecaseVO.emp_No}</td>
						<td>${empSvc.getOneEmp(accusecaseVO.emp_No).emp_Name}	</td>
						<td>
						
										<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission1">
											<button class="btn btn-warning" type="submit" name="action"
												value="mission_Detail">任務細節</button>
											<input type="hidden" name="mission_No" value="${accusecaseVO.mission_No}"> 
											<input type="hidden" name="requestURL" value="/bakedesk/missionManage/missionManageok.jsp">
										</form>
						
						</td>
					</tr>
					</c:if>
				</c:forEach>


			</table>
						
						
						
						</div>

					</div>
				</div>
			</div>

		</div>
	</div>
</body>
</html>