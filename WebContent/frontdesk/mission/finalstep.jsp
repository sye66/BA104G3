<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="getMissionSvc" scope="page" class="com.getmission.model.GetMissionService" />
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
<title>進行中的接案</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		
    <style type="text/css">
    	td, tr{
    		text-align: center;
    	}
    	table {
  			background-color: transparent;
  			table-layout: fixed;
		}	
	</style>
</head>
<body>
    <%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission">
                        <button class="btn btn-info" type="submit" name="action" value="missionindex">回到接案區頁面</button>
                    </form>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">進行中的接案</h3>
                        </div>
                        <div class="panel-body">
                            <c:if test="${not empty errorMsgs}">
                                <div>${errorMsgs}</div>
                            </c:if>
	                            <c:if test="${not empty mailService}">
	                                <div>信件寄送成功~!!!!!!!等待發案人回應吧</div>
	                            </c:if>
                        </div>
                        <table class="table">
                        	<tr>
	                        	<th>任務編號</th>
	                        	<th>任務名稱</th>
	                        	<th>任務描述</th>
	                        	<th>發案人</th>
	                        	<th></th>
                        	</tr>
                            <c:forEach var="successGetMission" items="${getMissionSvc.successGetMission(memVO.mem_No)}" varStatus="m" step="1">
                                <c:if test="${successGetMission.mission_State == 3||successGetMission.mission_State == 4 ||successGetMission.mission_State ==73 ||successGetMission.mission_State == 74}">
                                    <tr>
                                        <td>${successGetMission.mission_No}</td>
                                        <td>${successGetMission.mission_Name}</td>
                                        <td>${successGetMission.mission_Des}</td>
                                        <td>${memSvc.getOneMem(successGetMission.issuer_Mem_No).mem_Id}</td>
                                        <td>
                                            <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission">
                                                <c:if test="${successGetMission.mission_State == 4 ||successGetMission.mission_State == 74}">
                                                    <c:if test="${!sendmail}">
                                                        <input type="hidden" name="mission_No" value="${successGetMission.mission_No}">
                                                        <input type="hidden" name="requestURL" value="/frontdesk/mission/finalstep.jsp">
                                                        <button class="btn btn-danger" type="submit" name="action" value="finishwork">完成任務交付</button>
                                                    </c:if>
                                                </c:if>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </table>
                    </div>
                    
                </div>
            </div>
        </div>
        
        <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>
</body>

</html>