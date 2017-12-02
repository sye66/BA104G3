<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.getmission.model.*" %>   
 <jsp:useBean id="caseCandidateSvc" scope="page"
	class="com.casecandidate.model.CaseCandidateService" />   
 <jsp:useBean id="memSvc" scope="page"
	class="com.mem.model.MemService" /> 
<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" /> 
 <%
 	GetMissionService getMissionService = new GetMissionService();
 	GetMissionVO getMissionVO = new GetMissionVO();
	List<GetMissionVO> list = getMissionService.getAll();
	String mem_No = (String) session.getAttribute("mem_No");
	String mission_No = (String) session.getAttribute("mission_No");
	Integer mission_State = getMissionVO.getMission_State();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="3;URL=<%=request.getContextPath()%>/frontdesk/mission/missionComment.jsp?mission_No=${getMissionVO.mission_No}">
<title>
	
</title>
<style>
img #show {heigth:100%}
</style>
<script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>
<link href="<%=request.getContextPath()%>/lib/publicfile/include/css/sweetalert2.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
        body {
            background-image: url(<%=request.getContextPath()%>/res/images/getmission/discovery-space-shuttle1920.jpg);
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            background-size: cover;
            font-family: Microsoft JhengHei;
        }
       h1 {
       	color: #11866f;
       	font-size: 60px;
       }
       p{
       	color: #11866f;
       	font-size: 24px;
       }
    </style>

</head>
<body>

	<c:if test="${getMissionSvc.getOneMission(mission_No).mission_State == 5}">
	    <script type="text/javascript">
	    	swal($ { memSvc.getOneMem(memVO.mem_No).mem_Id }， 恭喜結案!可喜可賀可喜可賀);
	    </script>
	</c:if>

	<h1>恭喜你！${memSvc.getOneMem(memVO.mem_No).mem_Name}！任務完成</h1>
	<p>3秒之後自動跳轉到評論</p>





</body>
</html>