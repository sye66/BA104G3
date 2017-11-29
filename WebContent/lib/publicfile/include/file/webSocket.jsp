<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.casecandidate.model.*" %>
<%@ page import="com.relation.model.*" %>
<%@ page import="com.getmission.model.*" %>
<%@ page import="com.chatrecord.model.*" %>
<%@ page import="java.sql.Timestamp"%>


<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>
<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>
<jsp:useBean id="CaseCandidateService" scope="page" class="com.casecandidate.model.CaseCandidateService"/>
<jsp:useBean id="GetMissionService" scope="page" class="com.getmission.model.GetMissionService"/>
<jsp:useBean id="ChatRecordService" scope="page" class="com.chatrecord.model.ChatRecordService"/>

<% 
   MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); 
   String takecase_Mem_No = request.getParameter("takecase_Mem_No");
   String issuer_Mem_No = request.getParameter("issuer_Mem_No");
   String mission_No = request.getParameter("mission_No");

   CaseCandidateVO caseCandidateVO = new CaseCandidateVO();
   CaseCandidateService ccSvc = new CaseCandidateService();
   caseCandidateVO.setCandidate_Mem_No(takecase_Mem_No);
   caseCandidateVO.setMission_No(mission_No);
   request.setAttribute("caseCandidateVO", caseCandidateVO);
   request.setAttribute("mission_No", mission_No);
%>
        

<!DOCTYPE html>
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
    <body onload="connect();" onunload="disconnect();">
        <div id="fix_head" style="height : 100px ; width:500%; background-color: #ccc">
		</div>
		<div id="head" style="height : 100px ; width:500%; background-color: #ccc">
        	<h1> Chat Room </h1>
	    	<h3 id="statusOutput" class="statusOutput"></h3>
		</div>
		
		<div id="myPanel"></div>

		<div id="fix_bottom" style="height : 50px ; width:550px; background-color:#fff;"></div>
        <div id="type_in">
        	<div class="panel input-area" style="height : 50px ; width:5500px; background-color:#18bc9c;">
	        	<hr style="width:500%">
	            <input value="${memVO.mem_Id}" readonly id="userName" class="text-field" type="text"/>		
	            <input id="message"  class="text-field" type="text" placeholder="訊息" onkeydown="if (event.keyCode == 13) sendMessage();"/>
	            
	            <input type="submit" id="sendMessage" class="button" value="送出" onclick="sendMessage();"/>
			    <input type="button" id="connect"     class="button" value="連線" onclick="connect();"/>
			    <input type="button" id="disconnect"  class="button" value="離線" onclick="disconnect();"/>
				<input id="mem_Pic" name="mem_Pic" size="30" type="file" value="上傳照片" onchange="previewFile();"  multiple/>
	
				<form action="insert" id="save" method="post" >
				</form>
	    	</div>
	    </div>
    </body>
    
    
<script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/jquery/jquery.js"></script>

<script type="text/javascript">
		function previewFile(input) {
			 var i;
	 		 var preview = document.querySelector('#img_pic');
	  		 var reader  = new FileReader();
			 for(i=0 ; i<100;i++){
		 		 var file    = document.querySelector('input[type=file]').files[i];
		  		 
		 		 reader.addEventListener("load", function () {
		  		     preview.src = reader.result;
		 	     }, false);
		 		 
		 		 if (file) {
		 			 reader.onload = function(e){
		 			 sendImg(e.target.result);
		 	     	 }
		   		     reader.readAsDataURL(file);
		 		 }	
			 }
		}
</script>
    
<script>
    
   //把EL跟JSP的內容存成變數,方便跟JS溝通
var missionNo = '${caseCandidateVO.mission_No}';
var targetMemNo = '${caseCandidateVO.candidate_Mem_No}';
var memno = '${memVO.mem_No}';
var context = '<%=request.getContextPath() %>';
var memname = "${memVO.mem_Id}";
alert("missionNo + targetMemNo" +targetMemNo+missionNo);
   
var MyPoint = "/MyEchoServer/"+memno+"/"+missionNo;		// 對照server 哪個Server / 使用者名稱 / 房號
var host = window.location.host; 
var path = window.location.pathname;
var webCtx = path.substring(0, path.indexOf('/', 1));
var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
   console.log("endPointURL +" +endPointURL);
var statusOutput = document.getElementById("statusOutput");
var webSocket;
	
function connect() {
	
	
console.log(123);
	webSocket = new WebSocket(endPointURL);
	webSocket.onopen = function(event) {
			
		updateStatus("WebSocket 成功連線");
		document.getElementById('sendMessage').disabled = false;
		document.getElementById('connect').disabled = true;
		document.getElementById('disconnect').disabled = false;
				
		<%  
			ChatRecordService crSvc = new ChatRecordService();
		    ChatRecordVO chatRecordVO = new ChatRecordVO();
		    chatRecordVO.setSender_Mem_No(memVO.getMem_No());
		    chatRecordVO.setReceiver_Mem_No(takecase_Mem_No);
		    
	
		    request.setAttribute("chatRecordVO", chatRecordVO);
				    
		    List<ChatRecordVO> chatRecordVOList =crSvc.getRecord(memVO.getMem_No(),takecase_Mem_No);
		    for(ChatRecordVO list: chatRecordVOList){
	   	%>
	   	<%     
	   		System.out.println(list.getSender_Mem_No());
		    System.out.println(	list.getReceiver_Mem_No());
		    System.out.println(	list.getChat_Datetime());

		    
		    if(list.getChat_Content()!=null){
			    System.out.println(	list.getChat_Content().trim());
		    }
		%>
	
		var Sender_Mem_No = "<%=list.getSender_Mem_No()%>";
		var Receiver_Mem_No = "<%=list.getReceiver_Mem_No()%>";
		var Chat_Datetime = "<%=list.getChat_Datetime()%>";		
		var Chat_Content=":";
		<c:if test="<%=list.getChat_Content()!=null%>">
			Chat_Content="<%=list.getChat_Content().trim()%>";
		</c:if>
	
		console.log("Sender_Mem_No +" +Sender_Mem_No);
		console.log("Receiver_Mem_No +" +Receiver_Mem_No);
		console.log("Chat_Datetime +" +Chat_Datetime);
		console.log("Chat_Content +" +Chat_Content);
		console.log(Chat_Content.split(':'));
		
		//***************把Timestamp 格式轉成 一般時間格式**************
		var Chat_Datetime = Date.parse(Chat_Datetime);  
		Chat_Datetime = Chat_Datetime / 1000;  
		var newDate = new Date();  
		newDate.setTime(Chat_Datetime * 1000);  
		Chat_Datetime =newDate.toLocaleString(); 
		//***************把Timestamp 格式轉成 一般時間格式**************
		
	    
		        	
	    if(Chat_Content.length >1000){	        
	    	if(memname != jsonObj.userName){
	      		$('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+'_'+nowdate+'<img style="width: 200px; height: 200px;" src="'+url+'"></span><span>  </span></div>');
				console.log("1111111userName +"+ userName);
			} else {
	      		$('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;"><img style="width: 200px; height: 200px;" src="'+url+'">'+userName+'_'+nowdate+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
			}
	    }else if(targetMemNo === Sender_Mem_No){
	    
	       	$('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+Receiver_Mem_No+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+memname+':'+Chat_Content+':<br>'+Chat_Datetime+':</span><span>  </span></div>');
			console.log("1111111userName +"+ userName);
	       }else {
	       	$('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;"><br>'+Chat_Datetime+':'+Chat_Content+':'+memname+':'+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+Sender_Mem_No+'"></div>');
		}
		
		<%}%>
	};

	webSocket.onmessage = function(event) {
		var jsonObj = JSON.parse(event.data);
		var userName = jsonObj.userName;
		var message = jsonObj.message;
		var nowdate = jsonObj.chat_Datetime;
		nowdate=new Date();
		nowdate = nowdate.getHours()+':'+nowdate.getMinutes();
			    
			    
			    
			    
		var url = jsonObj.src;
		        	
	    if(url !=null){	        
	    	if(memname != jsonObj.userName){
	      		$('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+'_'+nowdate+'<img style="width: 200px; height: 200px;" src="'+url+'"></span><span>  </span></div>');
				console.log("1111111userName +"+ userName);
			} else {
	      		$('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;"><img style="width: 200px; height: 200px;" src="'+url+'">'+userName+'_'+nowdate+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
			}
	    }else{
	    	if(memname === jsonObj.userName){
	    	    $('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;">'+userName+'_'+message+'_'+nowdate+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
	    	}else{
	    		$('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+'_'+message+'_'+nowdate+'</span><span>  </span></div>');
	    	}
	    }
	
	console.log('test')			
		$('html, body').scrollTop(10000000);
	};

	webSocket.onclose = function(event) {
		updateStatus("WebSocket 已離線");
	};
}
	
	
var inputUserName = document.getElementById("userName");
inputUserName.focus();
	
function sendMessage() {
    var userName = inputUserName.value.trim();
	
    console.log("${memVO.mem_Id}" == userName);
    console.log("senduserName"+ userName);
   
    if (userName === ""){
        alert ("使用者名稱請勿空白!");	        
        inputUserName.focus();	
		return;
    }
    
    if("${memVO.mem_Id}" == userName){
    	var inputMessage = document.getElementById("message");
    	var message = inputMessage.value.trim();
    }
    if (message === ""){
        alert ("訊息請勿空白!");
        inputMessage.focus();	
    }else{ 
    	console.log('-------------------------'+userName)
    	
    	//**************************************************************************************
    	
    	
    	var chatContent = $('#myPanel').text();
	<%   
		crSvc = new ChatRecordService();
	    chatRecordVO = new ChatRecordVO();
	    chatRecordVO.setSender_Mem_No(memVO.getMem_No());
	    chatRecordVO.setReceiver_Mem_No(takecase_Mem_No);
	    String dateStr="";
	    Timestamp chat_Datetime = new Timestamp(System.currentTimeMillis());
	    System.out.println("chat_Datetime+"+chat_Datetime);
	    chatRecordVO.setChat_Datetime(chat_Datetime);
		    
	    System.out.println("adfasdf" +takecase_Mem_No);
		   
	    request.setAttribute("chatRecordVO", chatRecordVO);
	%>
    console.log("chatContent" + chatContent);
    var queryString= {"action":"insert","chatContent":message, "Sender_Mem_No":'<%=memVO.getMem_No()%>' , "Receiver_Mem_No":'<%=takecase_Mem_No%>' , "chat_Datetime":'<%=chat_Datetime%>'};
		console.log("queryString +" +queryString);
	$.ajax({
		 type: "POST",
		 url: "<%=request.getContextPath()%>/chatrecord/chatrecord.do",
		 data: queryString,
		 dataType: "json",
		 
		 success: function (data){ },
		 error: function(){alert("網路不穩斷線")}
		 
      });
    	
    	
    	
    	
    	
    	
    	
    	//*************************************************************************************
        var jsonObj = {"userName" : userName, "message" : message, "Sender_Mem_No":'<%=memVO.getMem_No()%>' , "Receiver_Mem_No":'<%=takecase_Mem_No%>' , "chat_Datetime":'<%=chat_Datetime%>'};
		webSocket.send(JSON.stringify(jsonObj));
	
        inputMessage.value = "";
        inputMessage.focus();
    }
}
	
function sendImg(url){
	var userName = inputUserName.value.trim();
	var inputMessage = document.getElementById("message");
    var message = inputMessage.value.trim();
    var date = new Date();
    var nowdate = date.getHours()+":"+date.getMinutes();
    alert(userName);
    var jsonObj ={
    		"userName" : userName,
    		"src" : url,
    		"time" : nowdate,
    		};
    console.log("src : " + url);
    webSocket.send(JSON.stringify(jsonObj));
    inputMessage.value = "";
       inputMessage.focus();
}

function disconnect () {
	webSocket.close();
	console.log("11111111111111111111");
	document.getElementById('sendMessage').disabled = true;
	document.getElementById('connect').disabled = false;
	document.getElementById('disconnect').disabled = true;
// 	var chatContent = $('#myPanel').text();
<%-- 	<%    --%>
// 		crSvc = new ChatRecordService();
// 	    chatRecordVO = new ChatRecordVO();
// 	    chatRecordVO.setSender_Mem_No(memVO.getMem_No());
// 	    chatRecordVO.setReceiver_Mem_No(takecase_Mem_No);
// 	    Timestamp chat_Datetime = new Timestamp(System.currentTimeMillis());
// 	    chatRecordVO.setChat_Datetime(chat_Datetime);
		    
// 	    System.out.println("adfasdf" +takecase_Mem_No);
		   
// 	    request.setAttribute("chatRecordVO", chatRecordVO);
<%-- 	%> --%>
//     console.log("chatContent" + chatContent);
<%--     var queryString= {"action":"insert","chatContent":chatContent, "Sender_Mem_No":'<%=memVO.getMem_No()%>' , "Receiver_Mem_No":'<%=takecase_Mem_No%>' , "chat_Datetime":'<%=chat_Datetime%>'}; --%>
		
// 	$.ajax({
// 		 type: "POST",
<%-- 		 url: "<%=request.getContextPath()%>/chatrecord/chatrecord.do", --%>
// 		 data: queryString,
// 		 dataType: "json",
		 
// 		 success: function (data){ },
// 		 error: function(){alert("網路不穩斷線")}
		 
//       });
	   console.log("1111111111133333333111111111");
	}

	function updateStatus(newStatus) {
		statusOutput.innerHTML = newStatus;
	}
</script>
</html>