<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />

<jsp:useBean id="caseCandidateSvc" scope="page"
	class="com.casecandidate.model.CaseCandidateService" />

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<%
	GetMissionVO getMissionVO = (GetMissionVO) request.getAttribute("mission_No");

	String mem_No = (String) session.getAttribute("mem_No");
%>

<!DOCTYPE html>
<html lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Title Page</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
</head>
<body>
<%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
	<br><br><br><br><br>
	<br>
<div class="container">
	<div class="col-xs-12 col-sm-4">

	</div>
		<div class="col-xs-12 col-sm-8">
			<div class="container">
				<div class="row">

					<form method="post"
						action="<%=request.getContextPath()%>/getmission/getmission.do"
						name="missiongroup">

						<button class="btn btn-success" type="submit" name="action"
							value="missiongroup">我的任務管理</button>

					</form>
				</div>


			</div>
			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title">目前接取所等待任務</h3>
				</div>
				<div class="panel-body">
					<table class="table">
					<tr>
					<td>${mem_No}</td>
					<td>---------------${memSvc.getOneMem(memVO.mem_No).mem_Name} 你好</td>
					</tr>
						<tr>
							<td>任務編號</td>
							<td>任務名</td>
							<td>發案人編號</td>
							<td>發案人</td>
						</tr>
						<c:forEach var="caseCandidateVO"
							items="${caseCandidateSvc.getCase(memVO.mem_No)}" varStatus="m"
							step="1">

							<tr>
								<td>${caseCandidateVO.mission_No}</td>
								<td>${getMissionSvc.getOneMission(caseCandidateVO.mission_No).mission_Name }</td>
								<td>${getMissionSvc.getOneMission(caseCandidateVO.mission_No).issuer_Mem_No }</td>
								<td>${memSvc.getOneMem(getMissionSvc.getOneMission(caseCandidateVO.mission_No).issuer_Mem_No).mem_Id }</td>
								<td>
									<div class="panel-body">
										<form method="post"
											action="<%=request.getContextPath()%>/getmission/getmission.do"
											name="getmission1">
											<button class="btn btn-warning" type="submit" name="action"
												value="mission_Detail">任務細節</button>

											<input type="hidden" name="mission_No"
												value="${caseCandidateVO.mission_No}"> <input
												type="hidden" name="requestURL"
												value="/frontdesk/getmission/getMission.jsp">
										</form>
									</div>

								</td>
						</tr>
						</c:forEach>
					</table>
				</div>


			</div>

</div>
</div>
<br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>
			<script src="https://code.jquery.com/jquery.js"></script>
			<script
				src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>