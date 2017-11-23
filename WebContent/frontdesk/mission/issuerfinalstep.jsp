<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />



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
	<br><br><br><br><br>
	<br>

<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">任務完成小面板兒</h3>
  </div>
  <div class="panel-body">
<c:if test="${not empty errorMsgs}">
<div>${errorMsgs}</div>
</c:if>
  </div>
  <table class="table">
    <c:forEach var="issuerMission" items="${getMissionSvc.findIssuerCase(memVO.mem_No)}"
								varStatus="m" step="1">

<c:if test="${issuerMission.mission_State == 3||issuerMission.mission_State == 4 }">
<tr>
<td>${issuerMission.mission_No}</td>
<td>${issuerMission.mission_Name}</td>
<td>${issuerMission.mission_Des}</td>
<td>${memSvc.getOneMem(issuerMission.takecase_Mem_No).mem_Id}</td>
<td>
<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
<c:if test="${issuerMission.mission_State == 3 }">	
<button class="btn btn-warning" type="submit" name="action" value="checkmem">接案人身分確認</button>
</c:if>
<c:if test="${issuerMission.mission_State == 4 }">	
<button class="btn btn-danger" type="submit" name="action" value="givepay">完成報酬交付</button>
<button class="btn btn-danger" type="submit" name="action" value="haveproblem">案件爭議訴求</button>
</c:if>
<input type="hidden" name="mission_No" value="${issuerMission.mission_No}">
<input type="hidden" name="takecase_Mem_No" value="${issuerMission.takecase_Mem_No}">
<input type="hidden" name="requestURL" value="/frontdesk/mission/issuerfinalstep.jsp">
</form>
</td>
</tr>
</c:if>
</c:forEach>
  </table>
</div>

<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
	
<button class="btn btn-info" type="submit" name="action" value="missionindex">任務首頁</button>

</form>

</body>
</html>