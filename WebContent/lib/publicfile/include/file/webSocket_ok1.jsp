<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.casecandidate.model.*" %>
<%@ page import="com.relation.model.*" %>
<%@ page import="com.getmission.model.*" %>
<%@ page import="com.chatrecord.model.*" %>
<%@ page import="java.sql.Timestamp"%>

<%-- <c:if test="${not empty login_memVO.mem_Id}"><% MemVO memVO = (MemVO)request.getSession().getAttribute("login_memVO"); %></c:if> --%>

<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>
<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>
<jsp:useBean id="CaseCandidateService" scope="page" class="com.casecandidate.model.CaseCandidateService"/>
<jsp:useBean id="GetMissionService" scope="page" class="com.getmission.model.GetMissionService"/>
<jsp:useBean id="ChatRecordService" scope="page" class="com.chatrecord.model.ChatRecordService"/>

<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); 
//    String memVO1 = request.getParameter("takecase_Mem_No");
   String takecase_Mem_No = request.getParameter("takecase_Mem_No");
   String issuer_Mem_No = request.getParameter("issuer_Mem_No");
   String mission_No = request.getParameter("mission_No");
//    System.out.println(memVO1);

   CaseCandidateVO caseCandidateVO = new CaseCandidateVO();
   CaseCandidateService ccSvc = new CaseCandidateService();
   caseCandidateVO.setCandidate_Mem_No(takecase_Mem_No);
   caseCandidateVO.setMission_No(mission_No);
   request.setAttribute("caseCandidateVO", caseCandidateVO);
   request.setAttribute("mission_No", mission_No);

  
   
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
		<div id="head" style="height : 100px ; width:500%; background-color: #ccc">
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

			<div id="fix_bottom" style="height : 50px ; width:550px; background-color:#fff;"></div>
        <div id="type_in">
        <div class="panel input-area" style="height : 50px ; width:5500px; background-color:#18bc9c;">
        <hr style="width:500%">
            <input value="${memVO.mem_Id}" readonly id="userName" class="text-field" type="text"/>		
       
<!--         		onkeydown="if (event.keyCode == 13) sendMessage(); 是按enter 也可以送出發言 -->
        
            <input id="message"  class="text-field" type="text" placeholder="訊息" onkeydown="if (event.keyCode == 13) sendMessage();"/>
       
       			
            
            <input type="submit" id="sendMessage" class="button" value="送出" onclick="sendMessage();"/>
		    <input type="button" id="connect"     class="button" value="連線" onclick="connect();"/>
		    <input type="button" id="disconnect"  class="button" value="離線" onclick="disconnect();"/>
			<input id="mem_Pic" name="mem_Pic" size="30" type="file" value="上傳照片" onchange="previewFile();"  multiple/>
<%-- 			<img id="img_pic" src="<%=request.getContextPath()%>/mem/images/nopic.jpg" alt="your image" width="150" height="200" />  --%>

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
	 				 //e.target.result = base64 format picture
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
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
// 	(2)	webSocket.onopen 連結到server的 onOpen (配對myName , myRoom, 把資訊存到userSession)
		
		webSocket.onopen = function(event) {
			updateStatus("WebSocket 成功連線");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
			
			<%  ChatRecordService crSvc = new ChatRecordService();
			    ChatRecordVO chatRecordVO = new ChatRecordVO();
			    chatRecordVO.setSender_Mem_No(memVO.getMem_No());
			    chatRecordVO.setReceiver_Mem_No(takecase_Mem_No);

			    request.setAttribute("chatRecordVO", chatRecordVO);
			   
			    
			    List<ChatRecordVO> chatRecordVOList =crSvc.getRecord(memVO.getMem_No(),takecase_Mem_No);
			    for(ChatRecordVO list: chatRecordVOList){
			    System.out.println(list.getSender_Mem_No());
			    System.out.println(	list.getReceiver_Mem_No());
			    System.out.println(	list.getChat_Datetime());
			    System.out.println(	list.getChat_Content());%>
			    
			    
			
// 			var jsonObj = JSON.parse(event.data);
			
// 			var JSON.data{userName : ""};

			var Sender_Mem_No = "<%=list.getSender_Mem_No()%>";
			var Receiver_Mem_No = "<%=list.getReceiver_Mem_No()%>";
			var Chat_Datetime = "<%=list.getChat_Datetime()%>";
			var Chat_Content = "<%=list.getChat_Content().trim()%>";
			console.log("Sender_Mem_No +" +Sender_Mem_No);
			console.log("Receiver_Mem_No +" +Receiver_Mem_No);
			console.log("Chat_Datetime +" +Chat_Datetime);
			console.log("Chat_Content +" +Chat_Content);
			console.log(Chat_Content.split(':'));
			
// 			var userName = jsonObj.userName;
// 	        var message = jsonObj.message;
// 		    var nowdate = jsonObj.time;
		    
// 	        var url = jsonObj.src;
// 	        var status = jsonObj.status;
	        	
// 	        if(url !=null){
	        
// 			        if(memname != jsonObj.userName){
// 			        	$('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+':'+nowdate+'<img style="width: 200px; height: 200px;" src="'+url+'"></span><span>  </span></div>');
// 					console.log("1111111userName +"+ userName);
// 					} else {
// 			        	$('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;"><img style="width: 200px; height: 200px;" src="'+url+'">'+userName+':'+nowdate+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
// 					}
// 	        }else{
// 	        	    if(memname === jsonObj.userName){
// 	        	       $('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;">'+':'+userName+':'+message+':'+nowdate+':'+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
// 	        	    }else{
// 	        		   $('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+':'+message+':'+nowdate+':'+'</span><span>  </span></div>');
// 	        	     }
// 	        }
<%-- 			  <%}%> --%>
			
<%-- 			var takecase_Mem_No = '<%=takecase_Mem_No%>'; --%>
// 			console.log("takecase_Mem_No + " +takecase_Mem_No);
<%-- 			<% System.out.println("qqqqqqqqqqqqqq" +crSvc.getRecord("M000003","M000001"));%> --%>
// 			console.log('${param.takecase_Mem_No}');
			
// 			console.log("aaa + " +aaa);
// 			var chatContent = $('#myPanel').append().val();
			
//還原處--------------------------------------
	
// 	        if(url ===null){
	        
			        if(targetMemNo === Sender_Mem_No){
			        	$('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+Receiver_Mem_No+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+memname+':'+Chat_Content+':</span><span>  </span></div>');
					console.log("1111111userName +"+ userName);
			        }else {
			        	$('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;">'+Chat_Content+':'+memname+':'+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+Sender_Mem_No+'"></div>');
					}
// 	        }else{
// 	        	    if(memname === jsonObj.userName){
<%-- 	        	       $('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;">'+':'+userName+':'+Chat_Content+':'+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+<%=list.getSender_Mem_No()%>+'"></div>'); --%>
// 	        	    }else{
<%-- 	        		   $('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+<%=list.getReceiver_Mem_No()%>+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+':'+Chat_Content+':'+'</span><span>  </span></div>'); --%>
// 	        	     }
// 	        }
			  <%}%>
			
<%-- 			var takecase_Mem_No = '<%=takecase_Mem_No%>'; --%>
// 			console.log("takecase_Mem_No + " +takecase_Mem_No);
<%-- 			<% System.out.println("qqqqqqqqqqqqqq" +crSvc.getRecord("M000003","M000001"));%> --%>
// 			console.log('${param.takecase_Mem_No}');
			
// 			console.log("aaa + " +aaa);
// 			var chatContent = $('#myPanel').append().val();
// 			   console.log("chatContent" + chatContent);
<%-- 			   var queryString= {"action":"insert","chatContent":chatContent, "Sender_Mem_No":'<%=memVO.getMem_No()%>'}; --%>
//還原處--------------------------------------
			
			
			
			
			
			
			
			
			
			
// 			   console.log("chatContent" + chatContent);
<%-- 			   var queryString= {"action":"insert","chatContent":chatContent, "Sender_Mem_No":'<%=memVO.getMem_No()%>'}; --%>
			
// 			$.ajax({
// 				 type: "POST",
<%-- 				 url: "<%=request.getContextPath()%>/chatrecord/chatrecord.do", --%>
// 				 data: queryString,
// 				 dataType: "json",
				 
// 				 success: function (data){ },
// 				 error: function(){alert("網路不穩斷線")}
				 
// 	       });
// 			//$('#save').submit();
// 			console.log("1111111111133333333111111111");
			
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
		    var nowdate = jsonObj.time;
		    
	        var url = jsonObj.src;
// 	        var status = jsonObj.status;
	        	
	        if(url !=null){
	        
			        if(memname != jsonObj.userName){
			        	$('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+':'+nowdate+'<img style="width: 200px; height: 200px;" src="'+url+'"></span><span>  </span></div>');
					console.log("1111111userName +"+ userName);
					} else {
			        	$('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;"><img style="width: 200px; height: 200px;" src="'+url+'">'+userName+':'+nowdate+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
					}
	        }else{
	        	    if(memname === jsonObj.userName){
	        	       $('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;">'+':'+userName+':'+message+':'+nowdate+':'+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
	        	    }else{
	        		   $('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+':'+message+':'+nowdate+':'+'</span><span>  </span></div>');
	        	     }
	        }
			console.log('test')			
			
			
// 		     if(url !=null){
			        
// 			        if(memname === jsonObj.userName){
// 			        	$('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;"><img style="width: 200px; height: 200px;" src="'+url+'">'+userName+':'+message+':'+nowdate+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
// 					console.log("1111111userName +"+ userName)
// 					} else {
// 			        	$('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+':'+message+':'+nowdate+'<img style="width: 200px; height: 200px;" src="'+url+'"></span><span>  </span></div>');
// 					}
// 	        }else{
// 	        	    if(memname === jsonObj.userName){
// 	        	       $('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;">'+':'+userName+':'+message+':'+nowdate+':'+status+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
// 	        	    }else{
// 	        		   $('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+':'+message+':'+nowdate+':'+status+':'+'</span><span>  </span></div>');
// 	        	    }
// 	        }
// 			console.log('test')			
			
// 			   if(url ==null){
// 			        if(memname === jsonObj.userName){
// 			        	$('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;">'+url+':'+userName+':'+message+':'+nowdate+':'+status+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
// 					console.log("1111111userName +"+ userName)
// 					} else {
// 			        	$('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+':'+message+':'+nowdate+':'+status+':'+url+'</span><span>  </span></div>');
// 					}
// 	        }else{
	        	
// 	        	    if(memname === jsonObj.userName){
// 	        	       $('#myPanel').append('<div style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;"><img style="width: 200px; height: 200px;" src="'+url+'">'+':'+userName+':'+message+':'+nowdate+':'+status+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
// 	        	    }else{
// 	        		   $('#myPanel').append('<div><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+userName+':'+message+':'+nowdate+':'+status+':'+'<img style="width: 200px; height: 200px;" src="'+url+'"></span><span>  </span></div>');
// 	        	    }
// 	        	}
// 	        }
// 			console.log('test')		
			
			
			
			
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
	    console.log("senduserName"+ userName);
	   
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
	        var jsonObj = {"userName" : userName, "message" : message, "memno" : memno ,};
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
// 	    		"status" : status
	    		};
	    console.log("src : " + url);
	    webSocket.send(JSON.stringify(jsonObj));
	    inputMessage.value = "";
        inputMessage.focus();
		}
	
	
	

	// (9) 把斷線的按扭打開 ,其他兩個關閉
	function disconnect () {
webSocket.close();
		console.log("11111111111111111111");
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
		var chatContent = $('#myPanel').text();
		<%   crSvc = new ChatRecordService();
		    chatRecordVO = new ChatRecordVO();
		    chatRecordVO.setSender_Mem_No(memVO.getMem_No());
		    chatRecordVO.setReceiver_Mem_No(takecase_Mem_No);
		    Timestamp chat_Datetime = new Timestamp(System.currentTimeMillis());
		    chatRecordVO.setChat_Datetime(chat_Datetime);
		   
		    
		    System.out.println("adfasdf" +takecase_Mem_No);
		   
		    request.setAttribute("chatRecordVO", chatRecordVO);
		   %>
		   console.log("chatContent" + chatContent);
		   var queryString= {"action":"insert","chatContent":chatContent, "Sender_Mem_No":'<%=memVO.getMem_No()%>' , "Receiver_Mem_No":'<%=takecase_Mem_No%>' , "chat_Datetime":'<%=chat_Datetime%>'};
		
		$.ajax({
			 type: "POST",
			 url: "<%=request.getContextPath()%>/chatrecord/chatrecord.do",
			 data: queryString,
			 dataType: "json",
			 
			 success: function (data){ },
			 error: function(){alert("網路不穩斷線")}
			 
       });
		//$('#save').submit();
		console.log("1111111111133333333111111111");
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
