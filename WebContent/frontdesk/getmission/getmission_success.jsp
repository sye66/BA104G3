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
<span style="font-size:18px;"> </span><span style="font-size:24px;"><meta http-equiv="refresh" content="3;URL=<%=request.getContextPath()%>/frontdesk/casecandidate/waitcase.jsp"> </span> 
<span style="font-size:24px;">3秒之後自動跳轉到首頁</span> 
<title>
	<c:if test="${CaseCandidateSvc.getCandidate(getMissionVO.mission_No).contains(mem_No)}">，恭喜'接案'成功 ! 請等待發案方回復 </c:if>
	
</title>
<style>
img #show {heigth:100%}
</style>
<script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>
<link href="<%=request.getContextPath()%>/lib/publicfile/include/css/sweetalert2.css" rel="stylesheet" type="text/css" />

</head>
<body>
 
 
<c:if test="${CaseCandidateSvc.getCandidate(getMissionVO.mission_No).contains(mem_No)}">
	<script type="text/javascript">
		swal(${memSvc.getOneMem(memVO.mem_No).mem_Id}，恭喜接案成功 ! 請等待發案方回復);
	</script>
</c:if>

memVO.mem_Id = ${memSvc.getOneMem(memVO.mem_No).mem_Id}







	 <form id="login-form" method="post" action="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">
                    	<div>
                    		<input type="hidden" name="action" value="register">
                    		<button type="submit" class="btn btn-success btn-lg btn-block">按我直接回首頁</button>
                    	</div>
                    </form>
                    
                    <div class="row">
			<div class="col-xs-12 col-sm-12"><img id="show" src="<%=request.getContextPath()%>/res/images/index/intelligence.png"></div>
		</div>
                    
</body>
</html>