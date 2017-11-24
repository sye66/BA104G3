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


<style>


/* 兩側對話框的邊線 */
	div.speech {

    float: left;
    margin: 10px 0;
    padding: 8px;
    table-layout: fixed;
    word-break: break-all;
    position: relative;
    background: -webkit-gradient( linear, 50% 0%, 50% 100%, from(#ffffff), color-stop(0.1, #ececec), color-stop(0.5, #dbdbdb), color-stop(0.9, #dcdcdc), to(#8c8c8c) );
    border: 1px solid #989898;
    border-radius: 8px;
}

/* 右側文字過常會自動換行,及對話框換色*/
div.speech.right {

 display: inline-block;
 box-shadow: -2px 2px 5px #CCC;
 margin-right: 10px;
 max-width: 75%;
 float: right;
 background: -webkit-gradient( linear, 50% 0%, 50% 100%, from(#e4ffa7), color-stop(0.1, #bced50), color-stop(0.4, #aed943), color-stop(0.8, #a7d143), to(#99BF40) );

}

/* 左側文字過常會自動換行*/
div .left {

 display: inline-block;
 box-shadow: 2px 2px 2px #CCCCCC;
 margin-left: 10px;
 max-width: 75%;
 position: relative;
 background: -webkit-gradient( linear, 50% 0%, 50% 100%, from(#ffffff), color-stop(0.1, #eae8e8), color-stop(0.4, #E3E3E3), color-stop(0.8, #DFDFDF), to(#D9D9D9) );

}


/* 左邊上下對話框的間距*/
.leftd {

 clear: both;
 float: left;
 margin-left: 10px;

}

/* 右邊上下對話框的間距*/
.rightd {

 clear: both;
 float: right;
 margin-right: 10px;

}


#messagesArea1{
	float: left;
	opacity:100%;
	z-index:-100%;
}
</style>

<title>Insert title here</title>
</head>
<!-- 起點 : (1)     onload="connect(); 與 disconnect(); 都是連接到本html的websocket.onopen -->
    <body onload="connect();" onunload="disconnect();">
        <h1> Chat Room </h1>
	    <h3 id="statusOutput" class="statusOutput"></h3>


		<div class="leftd">
    <div class="speech left" ng-class="speech left"> 
        <textarea id="messagesArea" class="panel message-area" readonly ></textarea>
        </div></div>
        
        <div class="rightd">
    <div class="speech right" ng-class="speech left"> 
        <textarea id="messagesArea1" class="panel message-area" readonly ></textarea>
        </div></div>
        
        <div class="panel input-area">
            <input value="${memVO.mem_Id}" readonly id="userName" class="text-field" type="text" placeholder="使用者名稱"/>		
       
<!--         		onkeydown="if (event.keyCode == 13) sendMessage(); 是按enter 也可以送出發言 -->
        
            <input id="message"  class="text-field" type="text" placeholder="訊息" onkeydown="if (event.keyCode == 13) sendMessage();"/>
       
       			
            
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
		
// 		if("${memVO.mem_Id}" == inputUserName){
//  (6) JSON.parse()把server傳過來的物件轉存成 jsonObj ,在把jsonObj取出存到message 並接到


webSocket.onmessage = function(event) {
			var messagesArea = document.getElementById("messagesArea");
			
			var messagesArea1 = document.getElementById("messagesArea1");
	        var jsonObj = JSON.parse(event.data);
	        
	        var message = jsonObj.userName + ": " + jsonObj.message + "\r\n";
	        
	        if("${memVO.mem_Id}" == jsonObj.userName){
	        					//空值 + jsonObj內容物接上
	        messagesArea1.value = messagesArea1.value + message;
	        					//保持視窗一直在最下面,以方便顯示內容
	        messagesArea1.scrollTop = messagesArea1.scrollHeight;
 		}
	        
	        
	        var message = jsonObj.userName + ": " + jsonObj.message + "\r\n";
	        
	        if("${memVO.mem_Id}" != jsonObj.userName){
	        	console.log("123","${memVO.mem_Id}" != jsonObj.userName);
	        					//空值 + jsonObj內容物接上
	        messagesArea.value = messagesArea.value + message;
	        					//保持視窗一直在最下面,以方便顯示內容
	        messagesArea.scrollTop = messagesArea.scrollHeight;
 		}
	        
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
		
	    console.log("${memVO.mem_Id}" == userName);
	    
	   
	    if (userName === ""){
	        alert ("使用者名稱請勿空白!");
	        
	        // * 把游標移到使用者名字輸入處
	        inputUserName.focus();	
			return;
	    }
	    
	    // * 把打再inputMessage的字存在message
	    
	     if("${memVO.mem_Id}" == userName){
	    var inputMessage = document.getElementById("message");
	    var message = inputMessage.value.trim();
	     }
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
