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

		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">目前所發佈任務</h3>
			</div>
			<div class="panel-body">
				<table class="table">
				<tr><td>${memVO.mem_No}</td>
				<td>---------------${memSvc.getOneMem(memVO.mem_No).mem_Name } 你好</td>
</tr>
					<tr>
						<td>任務編號</td>
						<td>任務名</td>
						<td></td>
						<td></td>
					</tr>
					<c:forEach var="caseVO"
						items="${getMissionSvc.findIssuerCase(memVO.mem_No)}" varStatus="i"
						step="1">

						<tr>
							<td>${caseVO.mission_No}</td>
							<td>${getMissionSvc.getOneMission(caseVO.mission_No).mission_Name }</td>
							<td></td>
							<td></td>
						</tr>

						<c:if test="${caseCandidateSvc.getCandidate(caseVO.mission_No).size() !=0}">

							<c:forEach var="caseCandidateVO"
								items="${caseCandidateSvc.getCandidate(caseVO.mission_No)}"
								varStatus="m" step="1">

								<tr>

									<td>接案人編號:${caseCandidateVO.candidate_Mem_No}</td>
									<td>接案人
										:${memSvc.getOneMem(caseCandidateVO.candidate_Mem_No).mem_Name }</td>
									
									
									<!-- decide who -->

									<td>
									<div class="panel-body">

										<form method="post"
											action="<%=request.getContextPath()%>/getmission/getmission.do"
											name="getmission3">
											<a href='#modal-id${i.index}-${m.index} ' data-toggle="modal"><button
													class="btn btn-info" type="submit" name="action" value="checkmem">確認人選</button></a> 
													
													<input type="hidden"
												name="takecase_Mem_No" value="${caseCandidateVO.candidate_Mem_No}">
												<input type="hidden"
												name="mission_No" value="${caseVO.mission_No}">
										</form>
									</div>
								</td>

								<div class="modal fade" id="modal-id${i.index}-${m.index}">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true">&times;</button>
												<h4 class="modal-title">任務編號:${caseVO.mission_No}</h4>
											</div>
											<div class="modal-body">
												<h4>任務名稱:</h4>
												<p>----${getMissionSvc.getOneMission(caseVO.mission_No).mission_Name }</p>
												<h4>任務種類:</h4>
												<p>----${getMissionSvc.getOneMission(caseVO.mission_No).mission_Category }</p>
												<p>${memSvc.getOneMem(caseCandidateVO.candidate_Mem_No).mem_Id}</p>
											</div>
											<div class="modal-footer">

												<form method="post"
													action="<%=request.getContextPath()%>/getmission/getmission.do"
													name="getmission3">
													<button class="btn btn-warning" type="submit" name="action"
														value="checkmem">就決定是你了~</button>
													<input type="hidden" name="takecase_Mem_No"
														value="${caseCandidateVO.candidate_Mem_No}"> 
														<input type="hidden" name="mission_No"
														value="${caseVO.mission_No}"> 
												</form>
												<button type="button" class="btn btn-default"
													data-dismiss="modal">關閉</button>
											</div>
										</div>
									</div>
								</div>

								</tr>
							</c:forEach>
						</c:if>
						<c:if
							test="${caseCandidateSvc.getCandidate(caseVO.mission_No).size() ==0}">

							<td>目前無人接取</td>
							<td></td>
						</c:if>
						<tr>
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

</div></div>
		</div>
</div>
<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>

		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>