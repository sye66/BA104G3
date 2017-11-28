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
    <meta http-equiv="refresh" content="3;URL=<%=request.getContextPath()%>/frontdesk/casecandidate/waitcase.jsp"></span>
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/css/issuemission/animate.css">
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/css/sweetalert2.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">        
    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>
        <c:if test="${CaseCandidateSvc.getCandidate(getMissionVO.mission_No).contains(mem_No)}">，恭喜'接案'成功 ! 請等待發案方回復 </c:if>
    </title>
    <style>
        body {
            background-image: url(<%=request.getContextPath()%>/res/images/getmission/cooperate_1920.jpg);
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            background-size: cover;
            font-family: Microsoft JhengHei;
        }
    </style>
</head>

<body>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<div class="container">
    <div class="row">
        <div class="col-xs-12 col-sm-12 fadeInLeft animated" style="text-align: center;">
            <p style="font-family: Microsoft JhengHei; color: yellow; font-size: 800%;">恭喜接案成功！</p>
            <p style="font-family: Microsoft JhengHei; color: white; font-size: 600%;">請等發案方回復</p>
        </div>
    </div>
</div>

<%--      
    <c:if test="${CaseCandidateSvc.getCandidate(getMissionVO.mission_No).contains(mem_No)}">
        <script type="text/javascript">
            swal($ { memSvc.getOneMem(memVO.mem_No).mem_Id }， 恭喜接案成功!請等待發案方回復);
        </script>
    </c:if>    

   
    <form id="login-form" method="post" action="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">
        <div>
            <input type="hidden" name="action" value="register">
            <button type="submit" class="btn btn-success btn-lg btn-block">按我直接回首頁</button>
        </div>
    </form>
 --%>

</body>

</html>



