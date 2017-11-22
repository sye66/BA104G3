<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>

<jsp:useBean id="MemSvc" scope="session" class="com.mem.model.MemService"/>

<%-- <c:if test="${not empty login_memVO.mem_Id}"><% MemVO memVO = (MemVO)request.getSession().getAttribute("login_memVO"); %></c:if> --%>
<%MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<%request.getAttribute("updateSuccess");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

  <head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%=request.getContextPath()%>/lib/publicfile/include/css/webSocket.css" type="text/css"/>
<title>Insert title here</title>
</head>
<!-- 起點 : (1)     onload="connect(); 與 disconnect(); 都是連接到本html的websocket.onopen -->
    <body onload="connect();" onunload="disconnect();">
        <h1> Chat Room </h1>
	    <h3 id="statusOutput" class="statusOutput"></h3>
        <textarea id="messagesArea" class="panel message-area" readonly ></textarea>
        <div class="panel input-area">
            <input id="userName" class="text-field" type="text" placeholder="使用者名稱"/>		
       
<!--         		onkeydown="if (event.keyCode == 13) sendMessage(); 是按enter 也可以送出發言 -->
        
            <input id="message"  class="text-field" type="text" placeholder="訊息" onkeydown="if (event.keyCode == 13) sendMessage();"/>
       
       			點到     
            
            <input type="submit" id="sendMessage" class="button" value="送出" onclick="sendMessage();"/>
		    <input type="button" id="connect"     class="button" value="連線" onclick="connect();"/>
		    <input type="button" id="disconnect"  class="button" value="離線" onclick="disconnect();"/>
	    </div>
    </body>
    
<script>
    
    var MyPoint = "/MyEchoServer/peter/309";		// 對照server 哪個Server / 使用者名稱 / 房號
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    
	var statusOutput = document.getElementById("statusOutput");
	var webSocket;
	
	function connect() {
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
// 	(2)	webSocket.onopen 連結到server的 onOpen (配對myName , myRoom, 把資訊存到userSession)
		
		webSocket.onopen = function(event) {
			updateStatus("WebSocket 成功連線");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
		};
//  (6) JSON.parse()把server傳過來的物件轉存成 jsonObj ,在把jsonObj取出存到message 並接到
webSocket.onmessage = function(event) {
			var messagesArea = document.getElementById("messagesArea");
	        var jsonObj = JSON.parse(event.data);
	        var message = jsonObj.userName + ": " + jsonObj.message + "\r\n";
	        
	        					//空值 + jsonObj內容物接上
	        messagesArea.value = messagesArea.value + message;
	        					//保持視窗一直在最下面,以方便顯示內容
	        messagesArea.scrollTop = messagesArea.scrollHeight;
		};

	// (7) 關閉連線變傳到server 
webSocket.onclose = function(event) {
			updateStatus("WebSocket 已離線");
		};
	}
	
	
	var inputUserName = document.getElementById("userName");
	inputUserName.focus();
	
	
	// (4) 送出訊息到server端的 onMessage() 
	
	function sendMessage() {
	    var userName = inputUserName.value.trim();
	    if (userName === ""){
	        alert ("使用者名稱請勿空白!");
	        
	        // * 把游標移到使用者名字輸入處
	        inputUserName.focus();	
			return;
	    }
	    
	    // * 把打再inputMessage的字存在message
	    
	    var inputMessage = document.getElementById("message");
	    var message = inputMessage.value.trim();
	    
	    if (message === ""){
	        alert ("訊息請勿空白!");
	        inputMessage.focus();	
	    }else{
	    	
	    	// * 把使用者名稱 跟訊息 存成jsonObj 傳到 server端的 onMessage()
	    	
	        var jsonObj = {"userName" : userName, "message" : message};
webSocket.send(JSON.stringify(jsonObj));
	        inputMessage.value = "";
	        inputMessage.focus();
	    }
	}

	// (9) 把斷線的按扭打開 ,其他兩個關閉
	function disconnect () {
webSocket.close();
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
	}

	// (10)上方顯示的狀態改完顯示斷線
	function updateStatus(newStatus) {
		statusOutput.innerHTML = newStatus;
	}
    
</script>
</html>
