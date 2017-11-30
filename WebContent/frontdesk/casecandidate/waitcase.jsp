<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="java.util.*"%>


<jsp:useBean id="getMissionSvc" scope="page" class="com.getmission.model.GetMissionService" />
<jsp:useBean id="caseCandidateSvc" scope="page" class="com.casecandidate.model.CaseCandidateService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<c:set var="sessionMemVO" value="${memVO}"/>

<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>接案候選人等待區</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
</head>

<body>
	<%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    
    <div class="container">
        <div class="col-xs-12 col-sm-12">
            <div class="container">
                <div class="row">
                    <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="missiongroup">
                        <button class="btn btn-success" type="submit" name="action" value="missiongroup">我的任務管理</button>
                    </form>
                </div>
            </div>
            <h2>${sessionMemVO.mem_Name}您好，目前等待發案人回應之任務：</h2>
			<c:forEach var="caseCandidateVO" items="${caseCandidateSvc.getCase(memVO.mem_No)}" varStatus="m" step="1">
				<c:set var="mission_No" value="${caseCandidateVO.mission_No}"/>
				<c:set var="missionVO" value="${getMissionSvc.getOneMission(mission_No)}"/>
				<c:set var="issuerMemVO" value="${memSvc.getOneMem(missionVO.issuer_Mem_No)}"/>
				<c:set var="mission_status" value="${missionVO.mission_State}"/>
			<%-- 除完成(5),失敗(6),爭議(8),失效(9) --%>
				<c:if test="${	mission_status ==1 || 
								mission_status ==2 ||
								mission_status ==3 || 
								mission_status ==4 || 
								mission_status ==7 ||
								mission_status ==72	}">
					<div class="panel panel-warning">
						<div class="panel-heading">
							<%-- 標題 --%>
							<h3 class="panel-title">${mission_No} 任務>> ${missionVO.mission_Name} </h3>
							<%-- 表單 - 取得任務細節 --%>
							<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission1">
								<input type="hidden" name="mission_No" value="${caseCandidateVO.mission_No}">
								<input type="hidden" name="requestURL" value="/frontdesk/casecandidate/waitcase.jsp">
								<button class="btn btn-warning pull-right" type="submit" name="action" value="mission_Detail">了解任務細節</button>
							</form>
						</div>
						<div class="panel-body">
							<%-- 表格 - 內容 --%>					
							<table class="table">
							    <tr style="text-align:center;">
							        <th>發案人編號</th>
							        <th>發案人</th>
							        <th>聊個天嗎?</th>
							    </tr>
							    <tr>
							        <td>${missionVO.issuer_Mem_No}</td>
							        <td>${issuerMemVO.mem_Id}</td>
							        <td style="text-align:center;">
										<form BorderStyle="0" method="get"
											action="<%=request.getContextPath()%>/lib/publicfile/include/file/webSocket.jsp?issuer_Mem_No=${missionVO.issuer_Mem_No}&mission_No=${mission_No}"
											name="getmission5">
											<button
												onclick="window.open('<%=request.getContextPath() %>/lib/publicfile/include/file/webSocket.jsp?takecase_Mem_No=${missionVO.issuer_Mem_No}&mission_No=${caseCandidateVO.mission_No} ', 'Yahoo', config='height=500,width=550')"
												class="btn btn-lg btn-success" type="button" name="action"
												value="chatting">和他聊天~</button>
											<input type="hidden" name="issuer_Mem_No"
												value="${missionVO.issuer_Mem_No}"> <input
												type="hidden" name="mission_No" value="${mission_No}">
										</form>
									</td>
							    </tr>
							</table>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

	<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>