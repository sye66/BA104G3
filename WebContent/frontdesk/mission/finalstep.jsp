<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />



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


<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">任務進行式</h3>
  </div>
  <div class="panel-body">
    內容文字
  </div>
  <table class="table">
    <c:forEach var="successGetMission" items="${getMissionSvc.successGetMission(mem_No)}"
								varStatus="m" step="1">

<c:if test="${successGetMission.mission_State == 3||successGetMission.mission_State == 4 ||successGetMission.mission_State ==73 ||successGetMission.mission_State == 74}">
<tr>
<td>${successGetMission.mission_No}</td>
<td>${successGetMission.mission_Name}</td>
<td>${successGetMission.mission_Des}</td>
<td>${memSvc.getOneMem(successGetMission.issuer_Mem_No).mem_Id}</td>
<td>
<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
<c:if test="${successGetMission.mission_State == 4 ||successGetMission.mission_State == 74}">	
<button class="btn btn-danger" type="submit" name="action" value="finishwork">完成任務交付</button>
</c:if>
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