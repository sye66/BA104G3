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
    <br>
    <br>
    <br>
    <br>
    <br>
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
            <c:forEach var="issuerMission" items="${getMissionSvc.findIssuerCase(memVO.mem_No)}" varStatus="m" step="1">
                <c:if test="${issuerMission.mission_State == 3||issuerMission.mission_State == 4 }">
                    <tr>
                        <td>${issuerMission.mission_No}</td>
                        <td>${issuerMission.mission_Name}</td>
                        <td>${issuerMission.mission_Des}</td>
                        <td>${memSvc.getOneMem(issuerMission.takecase_Mem_No).mem_Id}</td>
                        <td>
                                <c:if test="${issuerMission.mission_State == 3 }">
                                	<form method="post" action="<%=request.getContextPath()%>/frontdesk/issuemission/issuemission_Pending.jsp">
                                		<input type="hidden" name="mission_No" value="${issuerMission.mission_No}">
                                		<input type="hidden" name="takecase_Mem_No" value="${issuerMission.takecase_Mem_No}">
                                    	<button class="btn btn-warning" type="submit">接案人身分確認</button>
                                    </form>
                                </c:if>
                                <c:if test="${issuerMission.mission_State == 4 }">
		                            <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission">
		                                <input type="hidden" name="mission_No" value="${issuerMission.mission_No}">
		                                <input type="hidden" name="takecase_Mem_No" value="${issuerMission.takecase_Mem_No}">
		                                <input type="hidden" name="requestURL" value="/frontdesk/mission/issuerfinalstep.jsp">
	                                    <button class="btn btn-danger" type="submit" name="action" value="givepay">完成報酬交付</button>
        		                    </form>
        		                    <form method="post" action="<%=request.getContextPath()%>/frontdesk/disputeCase/issueDisputeCase.jsp">
        		                    	<input type="hidden" name="mission_No" value="${issuerMission.mission_No}">
	                                    <button class="btn btn-danger" type="submit">案件爭議訴求</button>
	                                </form>
                                </c:if>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </table>
    </div>
    <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission">
        <button class="btn btn-info" type="submit" name="action" value="missionindex">任務首頁</button>
    </form>
<script>
    
    var ToolMan = "/MissionSocket/${memVO.mem_No}/${memVO.mem_Id}";
    var hostTool = window.location.host;
    var pathTool = window.location.pathname;
    var toolWebCtx = pathTool.substring(0, pathTool.indexOf('/', 1));
    var endToolManURL = "ws://" + window.location.host + toolWebCtx + ToolMan;
    
// 	var statusOutput = document.getElementById("statusOutput");
	var webSocket;
	
	function connect() {
		// 建立 webSocket 物件
		webSocket = new webSocket(endToolManURL);
		
		webSocket.onopen = function(event) {
			updateStatus("webSocket 成功連線");
		
		};

		webSocket.onmessage = function(event) {
			var messagesArea = document.getElementById("messagesArea");
	        var jsonObj = JSON.parse(event.data);
	        var message = jsonObj.userName + ": " + jsonObj.message + "\r\n";
	        messagesArea.value = messagesArea.value + message;
	        messagesArea.scrollTop = messagesArea.scrollHeight;
		};

		webSocket.onclose = function(event) {
			updateStatus("webSocket 已離線");
		};
	}
	
	
	var inputUserName = document.getElementById("userName");
	inputUserName.focus();
	
	function sendMessage(action, take_Meme_No) {
		
		
		
	    var userName = take_Meme_No;
	    
	    if("missionOk".equal(action)){
	    	var inputMessage = "你的任務已經OK囉,積分已匯入,請確認查閱";
		    
		    if (message === ""){
		        alert ("訊息請勿空白!");
		        inputMessage.focus();	
		    }else{
		        var jsonObj = {"action": action, "userName" : userName, "message" : inputMessage};
		        webSocket.send(JSON.stringify(jsonObj));
		    }
	    }
	    
 		
	}
	
	
	$("#id").click(function(){
		var Str = "你的任務已經OK囉";
		
		
		sendMessage(missionOk, take_Meme_No);
		
	})
	
	function disconnect () {
		webSocket.close();
		
	}

	
	function updateStatus(newStatus) {
		statusOutput.innerHTML = newStatus;
	}
    
</script>
</body>
</html>