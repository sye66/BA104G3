<jsp:useBean id="missionImagesSvc" scope="page"
	class="com.missionimages.model.MissionImagesService" />
<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<%@ page import="com.getmission.model.*"%>
<%@ page import="com.missionimages.model.*"%>

<%
	GetMissionVO getMissionVO = (GetMissionVO) request.getAttribute("getMissionVO");
	String mem_No = (String) session.getAttribute("mem_No");
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

<div class="col-xs-12 col-sm-12">
<%@ include file="/backdesk/backdesk.jsp"%>
</div>

<div class="col-xs-12 col-sm-12">
<%@ include file="/backdesk/missionManage/missiondeskLeft.jsp"%>
</div>
</body>
</html>