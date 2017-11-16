<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="missionImagesSvc" scope="page"
	class="com.missionimages.model.MissionImagesService" />
<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page"
	class="com.mem.model.MemService" />
<%@ page import="com.getmission.model.*"%>
<%@ page import="com.missionimages.model.*"%>

<%
	GetMissionVO getMissionVO = (GetMissionVO) request.getAttribute("mission_No");
	String mem_No = (String)session.getAttribute("mem_No"); 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mem mission home</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link href="<%=request.getContextPath()%>/lib/publicfile/include/css/sweetalert2.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>


</head>
<body>

${memSvc.getOneMem(mem_No).mem_Name} 你好



<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
	
<button class="btn btn-info" type="submit" name="action" value="missionindex">任務首頁</button>

</form>

<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
	
<button class="btn btn-info" type="submit" name="action" value="mymission">我的案子</button>

</form>


<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
	
<button class="btn btn-info" type="submit" name="action" value="missionwait">目前接案等待</button>

</form>

<c:if test="${getMissionSvc.successGetMission(mem_No).size() != null  }">
<c:forEach var="missionstate" items="${getMissionSvc.successGetMission(mem_No)}" varStatus="state" step="1">
<c:if test="${missionstate.mission_State == 3 ||missionstate.mission_State ==  4 ||missionstate.mission_State ==  73||missionstate.mission_State ==  74 }" var="alright">
<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
	

</form>
</c:if>
</c:forEach>
<c:if test="${alright}">
<button class="btn btn-danger" type="submit" name="action" value="successgetmission">出動吧~工具人</button>
</c:if>
</c:if>

<c:if test="${getMissionSvc.findIssuerCase(mem_No).size() != null  }">
<c:forEach var="missionstate2" items="${getMissionSvc.findIssuerCase(mem_No)}" varStatus="state2" step="1">
<c:if test="${missionstate2.mission_State == 3 || missionstate2.mission_State == 4 ||missionstate2.mission_State == 73||missionstate2.mission_State == 74 } " var= "ok">
<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
</form>
</c:if>
</c:forEach>
<c:if test="${ok}">
<button class="btn btn-warning" type="submit" name="action" value="missiondone">任務結案</button>
</c:if>
</c:if>

<input type="hidden" id=" " >

</body>



<script>
    
    var MyPoint = "/MyEchoServer/peter/309";
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    
	var statusOutput = document.getElementById("statusOutput");
	var webSocket;
	
	function connect() {
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			updateStatus("WebSocket 成功連線");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
		};

		webSocket.onmessage = function(event) {
			var messagesArea = document.getElementById("messagesArea");
	        var jsonObj = JSON.parse(event.data);
	        var message = jsonObj.userName + ": " + jsonObj.message + "\r\n";
	        messagesArea.value = messagesArea.value + message;
	        messagesArea.scrollTop = messagesArea.scrollHeight;
		};

		webSocket.onclose = function(event) {
			updateStatus("WebSocket 已離線");
		};
	}
	
	
	var inputUserName = document.getElementById("userName");
	inputUserName.focus();
	
	function sendMessage() {
	    var userName = inputUserName.value.trim();
	    if (userName === ""){
	        alert ("使用者名稱請勿空白!");
	        inputUserName.focus();	
			return;
	    }
	    
	    var inputMessage = document.getElementById("message");
	    var message = inputMessage.value.trim();
	    
	    if (message === ""){
	        alert ("訊息請勿空白!");
	        inputMessage.focus();	
	    }else{
	        var jsonObj = {"userName" : userName, "message" : message};
	        webSocket.send(JSON.stringify(jsonObj));
	        inputMessage.value = "";
	        inputMessage.focus();
	    }
	}

	
	function disconnect () {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
	}

	
	function updateStatus(newStatus) {
		statusOutput.innerHTML = newStatus;
	}
    
</script>
</html>