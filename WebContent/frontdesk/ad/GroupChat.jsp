<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.relation.model.*" %>

<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>
<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>

<% 
   MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); 
   MemVO memVO1 = (MemVO)request.getSession().getAttribute("memVO");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Chat Room</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/chat.min.css" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml"></html>
<style>

.panel {
    border: 3px solid #0078ae;
    border-radius: 20px;
    width:100%;
    
}

.mp4{
    height:350px;
    text-align: center;
}

.list-content{
    height:500px
}

.list >.list-content >.message-area {
    height: 100%;
    resize: none;
    box-sizing: border-box;
    overflow: auto;
}

.input-area {
    background: #0078ae;
    box-shadow: inset 0 0 10px #00568c;
}

.input-area input {
    margin: 0.5em 0em 0.5em 0.5em;
}

.text-field {
    border: 1px solid grey;
    padding: 0.2em;
    box-shadow: 0 0 5px #000000;
}

.button {
    border: none;
    padding: 5px 5px;
    border-radius: 5px;
    width: 60px;
    background: orange;
    box-shadow: inset 0 0 10px #000000;
    font-weight: bold;
}

.button:hover {
    background: yellow;
}

h1 {
    font-size: 1.5em;
    padding: 5px;
    margin: 5px;
}

#userName {
    width: 20%;
}

#message {
    min-width: 50%;
    max-width: 60%;
}

.statusOutput{
	background: #0078ae;
    text-align:center;
    color: #ffffff;
    border: 1px solid grey;
    padding: 0.2em;
    box-shadow: 0 0 5px #000000;
    width: 20%;
}
textarea {
  font-weight: inherit;
  font-style: inherit;
  font-family: inherit;
  font-size: 100%;
  vertical-align: baseline;
  color: inherit;
  margin: 0;
  width:100%;
  height: 100%;
}

</style>
    </head>
    <body onload="connect();" onunload="disconnect();" class="layout-scroll">

        <h1> Chat Room ***</h1>            
	        <h3 id="statusOutput" class="statusOutput"></h3>
	        

    
	 <main class="list" >
        <div>
            <div id="list" class="list-content">      
            <textarea id="messagesArea" class="panel message-area" readonly >
            </textarea>
            </div>
        </div>
    </main>  
    
<c:choose>
    <c:when test="${memVO.mem_State == 1}">
    <main class="mp4">
	    <div>
	        <div id="list" class="mp4"> 
	        <jsp:include page="/frontdesk/ad/Chat_movie.jsp" flush="true" />
	        </div>
	    </div>
    </main>
    </c:when>
    
    <c:otherwise>
    <main class="mp4">
	    <div>
	        <div id="list" class="mp4"> 
	        <jsp:include page="/frontdesk/ad/robbit_party.jsp" flush="true" />
	        </div>
	    </div>
    </main>
    </c:otherwise>
</c:choose>
    
   
 <footer id="toolbar" class="publisher">
    <div class="bar" data-type="bar">  
        <div class="panel input-area">
            <input type="hidden" id="userName" class="text-field"  value="${memVO.mem_Name}"/>${memVO.mem_Name}
            <input type="text" id="message"  class="text-field"  placeholder="訊息" onkeydown="if (event.keyCode == 13) sendMessage();"/>
            <input type="submit" id="sendMessage" class="button" value="送出" onclick="sendMessage();"/>
		    <input type="button" id="connect"     class="button" value="連線" onclick="connect();"/>
		    <input type="button" id="disconnect"  class="button" value="離線" onclick="disconnect();"/>
	    </div>
	</div>
</footer>
	    
</body>
<script>

   var mem_No = '${memVO.mem_No}';
   var mem_Name='${memVO.mem_Name}';
   var context = '<%=request.getContextPath() %>';
   
    var MyPoint = "/MyEchoServer/" +mem_No+ "/"+context;
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
	        alert ("要先登入才能一起神靠北喔~~~");
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
