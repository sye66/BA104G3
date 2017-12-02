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
<br>
<br>
<br>
<br>
<br>
<br><br><br>
<div class="container">
	<div class="col-xs-12 col-sm-4"></div>
		<div class="col-xs-12 col-sm-8">
		<div class="container">
			<div class="row">
			    <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="missiongroup">
			        <button class="btn btn-success" type="submit" name="action" value="missiongroup" align="right">我的任務管理</button>
			    </form>
			</div>
			<h2>${memSvc.getOneMem(memVO.mem_No).mem_Name }...您目前所發佈任務</h2>
			<c:forEach var="caseVO" items="${getMissionSvc.findIssuerCase(memVO.mem_No)}" varStatus="i" step="1">
			<c:if test="${	caseVO.mission_State == 1 || caseVO.mission_State == 2 ||  caseVO.mission_State == 3 ||  caseVO.mission_State == 4 ||  caseVO.mission_State == 7 || caseVO.mission_State == 72}">
				<div class="panel panel-info"></div>
					<div class="panel-heading">
						<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission1">
							<%-- 備用 --%>
							<input type="hidden" name="mission_No" value="${caseVO.mission_No}">
							<input type="hidden" name="requestURL" value="/frontdesk/getmission/getMission.jsp">
							<button class="btn btn-warning pull-right" type="submit" name="action" value="mission_Detail">任務細節</button>
						</form>
						<h3 class="panel-title">${caseVO.mission_No} 任務 >>>>${getMissionSvc.getOneMission(caseVO.mission_No).mission_Name }</h3>
					</div>
					
					<div class="panel-body">
						<table class="table" >
								<c:if test="${caseCandidateSvc.getCandidate(caseVO.mission_No).size() !=0}">
								<c:forEach var="caseCandidateVO" items="${caseCandidateSvc.getCandidate(caseVO.mission_No)}" varStatus="m" step="1">
									<tr>
										<td>
										    <h3>接案人編號:${caseCandidateVO.candidate_Mem_No}</h3>
										</td>
										<td>
										    <h3>接案人:${memSvc.getOneMem(caseCandidateVO.candidate_Mem_No).mem_Name }</h3>
										</td>
										<!-- decide who -->
										<td>
											<div class="panel-body">
												<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission3">
													<%-- 啟動modal --%>
													<a href='#modal-id${i.index}-${m.index} ' data-toggle="modal">
														<button class="btn-lg btn-info" type="submit" name="action" value="chosemem">確認人選</button>
													</a> 
													<%-- 備用 --%>
													<input type="hidden" name="takecase_Mem_No" value="${caseCandidateVO.candidate_Mem_No}">
													<input type="hidden" name="mission_No" value="${caseVO.mission_No}">
												</form>
											</div>
										</td>
										
									<div class="modal fade" id="modal-id${i.index}-${m.index}">
									    <div class="modal-dialog">
									        <div class="modal-content">
									        	<%-- 標題與右上角關閉開關 --%>
									            <div class="modal-header">
									                <h4 class="modal-title">任務編號:${caseVO.mission_No}</h4>
									                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									            </div>

												<%-- 內文 --%>
									            <div class="modal-body">
									                <h4>任務名稱:</h4>
									                <p>----${getMissionSvc.getOneMission(caseVO.mission_No).mission_Name }</p>
									                <h4>任務種類:</h4>
									                <p>----${getMissionSvc.getOneMission(caseVO.mission_No).mission_Category }</p>
									                <p>接案人為>>${memSvc.getOneMem(caseCandidateVO.candidate_Mem_No).mem_Id}</p>
									            </div>
									            <%-- Footer，觸發GetMissionServlet --%>
									            <div class="modal-footer">
									                <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission3">
									                    <%-- TODO: Send Email , SMS, Generate QRcode here. --%>
								                        <input type="hidden" name="takecase_Mem_No" value="${caseCandidateVO.candidate_Mem_No}">
								                        <input type="hidden" name="mission_No" value="${caseVO.mission_No}">
									                    <button class="btn btn-warning" type="submit" name="action" value="chosemem">就決定是你了~</button>
									                </form>
									                <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
									            </div>
											<%-- model-content結束 --%>
									        </div>
										<%-- modal-dialog結束 --%>
									    </div>
									</div>

									<td>
										<div class="panel-body">
											<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission3">
											<button class="btn-lg btn-success" type="submit" name="action" value="chatting">和他聊天~</button>
											<input type="hidden" name="takecase_Mem_No" value="${caseCandidateVO.candidate_Mem_No}"> 
											<input type="hidden" name="mission_No" value="${caseVO.mission_No}"> 
											</form>
										</div>
									</div>
								</div>
								<td>
									<div class="panel-body">
										<form BorderStyle="0" method="get" action="<%=request.getContextPath()%>/lib/publicfile/include/file/webSocket.jsp?takecase_Mem_No=${caseCandidateVO.candidate_Mem_No}&mission_No=${caseVO.mission_No}" name="getmission3">
										<button onclick="window.open(' <%=request.getContextPath() %>/lib/publicfile/include/file/webSocket.jsp?takecase_Mem_No=${caseCandidateVO.candidate_Mem_No}&mission_No=${caseVO.mission_No} ', 'Yahoo', config='height=500,width=550')" class="btn-lg btn-success" type="button" name="action" value="chatting">和他聊天~</button>
										<input type="hidden" name="takecase_Mem_No" value="${caseCandidateVO.candidate_Mem_No}"> 
										<input type="hidden" name="mission_No" value="${caseVO.mission_No}"> 
										</form>
									</div>
								</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${caseCandidateSvc.getCandidate(caseVO.mission_No).size() ==0}">
							<td><h4>目前無人接取</h4></td>
							<td></td>
						</c:if>
						
					
							</table>
							</div>

									
							</c:if>
								</c:forEach>
								
					</div>


		</div></div>

<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>

		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>