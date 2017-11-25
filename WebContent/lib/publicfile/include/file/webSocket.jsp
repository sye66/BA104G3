<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.relation.model.*" %>
<%-- <c:if test="${not empty login_memVO.mem_Id}"><% MemVO memVO = (MemVO)request.getSession().getAttribute("login_memVO"); %></c:if> --%>

<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>
<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>



<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); 
   String memVO1 = request.getParameter("takecase_Mem_No");
   String takecase_Mem_No = request.getParameter("takecase_Mem_No");
   
   System.out.println(memVO1);
   System.out.println("takecase_Mem_No"+takecase_Mem_No);
%>
        
<%/*
// RelationService relationSvc = new RelationService();

//  String related_Mem_No = request.getParameter("relationVO");
// if(related_Mem_No ==null){
	
// 	related_Mem_No= memVO.getMem_No();
// 	System.out.println("related_Mem_No ++++ " +related_Mem_No);
// }
 
// List<RelationVO> relationVO = relationSvc.getAllFriends(related_Mem_No);
// pageContext.setAttribute("relationVO", relationVO);
// System.out.println("relationVO ++++ " +relationVO);
*/%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

  <head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/publicfile/include/css/webSocket.css" type="text/css"/> --%>


<style>
/* 	#messagesArea_left{ */
/* 		float: left; */
/* 		margin-left: 3%; */
/* 	} */
/* 	#messagesArea_right{ */
/* 		float: right;		 */
/* 		margin-right: 3%; */
/* 		width:150px; */
/* 		height:150px; */
/* 	} */
	#type_in{
	position:fixed;
		bottom:0px;
		center;
	}

	img{
		width:50px;
		height:50px;
	}
/* 	#fix_head{ */
/* 		position:fixed; */
/* 		top:0px; */
	}
	#fix_bottom{
	position:fixed;
		bottom:0px;
	}
	#head{
	position:fixed;
		top:0px;
	}
	
	.#fix_head{ 
	position:absolute; 
	top:0px; 
	height:268px;/*高度可以不寫，可以通過內部元素撐開，但是需要考慮是否會與自適應部分發生重合*/ 
	width: 182px;/*寬度是必要，如果沒有寬度就無法撐出div*/ 
	} 

</style>

    <title>工具人出租</title>
</head>
<!-- 起點 : (1)     onload="connect(); 與 disconnect(); 都是連接到本html的websocket.onopen -->
    <body onload="connect();" onunload="disconnect();">
<!--     上層 div-->
        <div id="fix_head" style="height : 100px ; width:500%; background-color: #ccc">
       
		</div>
		<div id="head">
        <h1> Chat Room </h1>
	    <h3 id="statusOutput" class="statusOutput"></h3>
		
		</div>
<!-- 		<div> -->
<!-- 			<div id="messagesArea_left"> -->
<%-- 				 <input class="" type="text" name="" style="border: #FFF" readonly value="${memVO.mem_Id}"> --%>
<%-- 				 <img src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}"> --%>
<!-- 			<div id="messagesArea_left"><input id="messagesArea" class="" type="text" name="" style="border: #FFF" readonly ></div> -->
<!-- 			</div> -->
<!-- 			<div id="messagesArea_right"> -->
<%-- 				<input id="memid" class="" type="text" name="" style="border: #FFF" readonly value="${memVO.mem_Id}"> --%>
<%-- 				<img src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}"> --%>
<!-- 				<div id="messagesArea_right"><input id="messagesArea1" class="" type="text" name="" value="" style="border: #FFF" readonly ></div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		把<div id="myPanel"> 裡面的內容當成樣版, 然後下面用jQuery抓 id 把重複的內容塞進去  ,注意單引號雙引號問題-->
		<div id="myPanel">
<!-- 			<div> -->
<%-- 				<img src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}"> --%>
<!-- 				<span style='word-wrap:break-word; width: 200px; height: 50px; '>xxxxxxxxxxx xxxxxxeed fddd ewwegffss ee</span><span>  </span> -->
<!-- 			</div> -->
<!-- 			<div style="text-align: right;"> -->
<!-- 				<span style='word-wrap:break-word; width: 200px; height: 50px; '>xxxxxxxxxxx xxxxxxeed fddd ewwegffss ee</span><span>  </span> -->
<%-- 				<img src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}"> --%>
<!-- 			</div> -->
		</div>

			<div id="fix_bottom" style="height : 50px ; width:5000px; background-color:#fff;"></div>
        <div id="type_in">
        <div class="panel input-area">
        <hr style="width:500%">
            <input value="${memVO.mem_Id}" readonly id="userName" class="text-field" type="text"/>		
       
<!--         		onkeydown="if (event.keyCode == 13) sendMessage(); 是按enter 也可以送出發言 -->
        
            <input id="message"  class="text-field" type="text" placeholder="訊息" onkeydown="if (event.keyCode == 13) sendMessage();"/>
       
       			
            
            <input type="submit" id="sendMessage" class="button" value="送出" onclick="sendMessage();"/>
		    <input type="button" id="connect"     class="button" value="連線" onclick="connect();"/>
		    <input type="button" id="disconnect"  class="button" value="離線" onclick="disconnect();"/>
<!-- 		    <select type="button" id="roomNo"  class="button" value="房間號碼" onclick="sendRoomNo();"> -->
<!-- 		    <option value="1001">AAAAAA</option> -->
<%-- 			<option value="${memVO.mem_No}">BBBBB</option> --%>
<!-- 			<option value="3">其他</option> -->
<!-- 		    </select> -->
	    </div>
	    </div>
    </body>
<script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/jquery/jquery.js"></script>
    
<script>
    
    //把EL跟JSP的內容存成變數,方便跟JS溝通
     
    
	var memno = '${memVO.mem_No}';
    var context = '<%=request.getContextPath() %>';
    var memname = "${memVO.mem_Id}";
    
    var MyPoint = "/MyEchoServer/"+memname+"/"+memno;		// 對照server 哪個Server / 使用者名稱 / 房號
    alert(MyPoint);
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    console.log("endPointURL +" +endPointURL);
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
// 			var messagesArea = document.getElementById("messagesArea");
			
// 			var messagesArea1 = document.getElementById("messagesArea1");
// 	        var jsonObj = JSON.parse(event.data);
	        
// 	        var message = /*jsonObj.userName + ": " +*/ jsonObj.message + "\r\n";
	        
// 	        if("${memVO.mem_Id}" == jsonObj.userName){
// 		        					//空值 + jsonObj內容物接上
// 		        messagesArea1.value = messagesArea1.value + message;
// 		        					//保持視窗一直在最下面,以方便顯示內容
// 		        messagesArea1.scrollTop = messagesArea1.scrollHeight;
//  			}
	        
	        
// 	        var message = jsonObj.userName + ": " + jsonObj.message + "\r\n";
	        
// 	        if("${memVO.mem_Id}" != jsonObj.userName){
// 	        	console.log("123","${memVO.mem_Id}" != jsonObj.userName);
// 	        					//空值 + jsonObj內容物接上
// 	        messagesArea.value = messagesArea.value + message;
// 	        					//保持視窗一直在最下面,以方便顯示內容
// 	        messagesArea.scrollTop = messagesArea.scrollHeight;
//  		}
			var jsonObj = JSON.parse(event.data);
			
// 			var JSON.data{userName : ""};
			var userName = jsonObj.userName;
	        var message = jsonObj.message;
	        console.log("@@@@@@@@@@@@@"+ jsonObj.memno)
			console.log("jsonObj.userName"+ jsonObj.userName)
			console.log("11sadasd11111userName +"+ memno)
	        if(memname === jsonObj.userName){
	        	$('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;">'+userName+':'+message+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
	            console.log("endPointURL +" +endPointURL);
			console.log("1111111userName +"+ userName)
			} else {
	        	$('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+':'+message+'</span><span>  </span></div>');
			}
			console.log('test')			
			$('html, body').scrollTop(10000000);
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
	    	console.log('-------------------------'+userName)
	        var jsonObj = {"userName" : userName, "message" : message, "memno" : memno};
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
    
	
// 	$(function(){
// 		$('#sendMessage').on('click', function(){
// 			console.log('test')			
// 			$('html, body').scrollTop(10000000);
// 		});
// 	});
</script>
</html>
