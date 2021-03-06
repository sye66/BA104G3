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
//    String issuer_Mem_No = request.getParameter("issuer_Mem_No");
   String mission_No = request.getParameter("mission_No");
   MemVO memVO2 =MemSvc.getOneMem(takecase_Mem_No);
//    MemVO memVO3 =MemSvc.getOneMem(issuer_Mem_No);
   

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

	#type_in{
	position:fixed;
		bottom:2px;
		left:0px;
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
		bottom:5px;
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
	left:0px;
	right:0px;
	} 

</style>

    <title>工具人出租</title>
</head>
    <body onload="connect();" onunload="disconnect();">
        <div id="fix_head" style="height : 57px ; width:100%; background-color: #ccc">
		</div>
		<div id="head">
        	<h1 style="margin-bottom:0px ;margin-top:5px "> Chat Room </h1>
	    	<h3 style="margin-top:0px" id="statusOutput" class="statusOutput"></h3>
		</div>
		
<!-- 		<div> -->
<!-- 		<div class="left speech leftd"> -->
<!-- 		<img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"> -->
<!-- 		<span style="word-break: break-all; width: 200px; height: 50px;"> -->
<!-- 		'+Receiver_Mem_Id+':'+Chat_Content+':<br>'+Chat_Datetime+':</span> -->
<!-- 		<span>  </span></div>' -->
<!-- 		</div> -->
		
		
		<div id="myPanel" style="overflow-y:auto ; max-height:380px"></div>

		<div id="fix_bottom" style="height :width:650px; background-color:#fff;"></div>
        <div id="type_in">
        	<div class="panel1 input-area" style="width:700px; background-color:#18bc9c;">
	        	<hr style="width:250%">
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
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
		 		 
		 			 toFile(file);
		   		    
		 		 }	
			 }
		
		function toFile(file){
			var reader  = new FileReader();
		if (file) {
			 reader.onload = function(e){
			 sendImg(e.target.result);
			 url=e.target.result;
	     	 }
			 reader.readAsDataURL(file);
		}
		}
		
</script>
    
<script>
    
//把EL跟JSP的內容存成變數,方便跟JS溝通
var message="";
var userName
var jsonObj
var url="";
var missionNo = '${caseCandidateVO.mission_No}';
var targetMemNo = '${caseCandidateVO.candidate_Mem_No}';
var memno = '${memVO.mem_No}';
var context = '<%=request.getContextPath() %>';
var memname = "${memVO.mem_Id}";
var targetMemName ='<%=memVO2.getMem_Id()%>';
<%-- var issuer_Mem_No ='<%=memVO3.getMem_Id()%>'; --%>
// alert("missionNo + targetMemNo" +targetMemNo+missionNo);

var MyPoint = "/MyEchoServer/"+'<%=memVO.getMem_No()%>'+"/"+missionNo;		// 對照server 哪個Server / 使用者編號 / 房號
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
				
		
		//*****************************把之前的留言重新載入***************
		
		//******************************第一段出現	crSvc.getRecord(memVO.getMem_No(),takecase_Mem_No); 內容*************
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
		
		<%
		MemVO memVO4 =MemSvc.getOneMem(list.getSender_Mem_No());
		MemVO memVO5 =MemSvc.getOneMem(list.getReceiver_Mem_No());
		%>
		
		var Sender_Mem_Id = "<%=memVO4.getMem_Id()%>";
		var Receiver_Mem_Id = "<%=memVO5.getMem_Id()%>";
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
		
		 userName = inputUserName.value.trim();
	    console.log(userName);
// 	    console.log("issuer_Mem_No + " +issuer_Mem_No);
	    console.log("Receiver_Mem_Id + " + Receiver_Mem_Id);
	    console.log("memname +" + memname);
	    console.log("Sender_Mem_Id +" + Sender_Mem_Id);
	    
	    
		        
	    if(<%=list.getChat_Content().length() %> >50){	        
	    	if(memname === Sender_Mem_Id){
	      		$('#myPanel').append('<div class="right speech rightd" style="text-align: right; vertical-align: text-bottom"><br>'+Sender_Mem_Id+'<br></span><span>  '+<c:if test="<%=list.getChat_Content().length()>50%>">'<span style="word-break: break-all;"><img style="width: 200px; height: 200px;" src="' </c:if> +Chat_Content+ <c:if test="<%=list.getChat_Content().length()>50%>"> '">'</c:if> +'：</span><img src="'+context+'/mem/memShowImage.do?mem_No='+Sender_Mem_No+'"><br>'+Chat_Datetime+'</div>');
				console.log("1111111userName +"+ userName);
	    	}else{
	      		$('#myPanel').append('<div class="left speech leftd"><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+Receiver_Mem_Id+'<br>'+Chat_Datetime+'<img style="width: 200px; height: 200px;" src="'+Chat_Content+'"></span><span>  </span></div>');
	      		console.log("111222222222222221111userName +"+ userName);
	    	}
	    }else{
	    	
	    	if(memname === Sender_Mem_Id){
	       	$('#myPanel').append('<div class="right speech rightd" style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;">'+Sender_Mem_Id+'<br></span><span>  '+Chat_Content+'：</span><img src="'+context+'/mem/memShowImage.do?mem_No='+Sender_Mem_No+'"><br>'+Chat_Datetime+'</div>');
			console.log("11333333333333333311111userName +"+ userName);
			}else{
	       	$('#myPanel').append('<div class="left speech leftd"><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">'+Receiver_Mem_Id+':'+Chat_Content+'<br>'+Chat_Datetime+'</span><span>  </span></div>');
	    	console.log("1111444444444444444444111userName +"+ userName);
	       }
	    }	
	      		
	      		
		<%}%>
//******************************第一段出現	crSvc.getRecord(memVO.getMem_No(),takecase_Mem_No); 內容*************


//******************************第二段出現	crSvc.getRecord(takecase_Mem_No,memVO.getMem_No()); 內容*************
		<%
		 List<ChatRecordVO> chatRecordVOList1 =crSvc.getRecord(takecase_Mem_No,memVO.getMem_No());
		    for(ChatRecordVO list1: chatRecordVOList1){
	   	%>
	   	<%     
	   		System.out.println(list1.getSender_Mem_No());
		    System.out.println(	list1.getReceiver_Mem_No());
		    System.out.println(	list1.getChat_Datetime());

		    
		    if(list1.getChat_Content()!=null){
			    System.out.println(	list1.getChat_Content().trim());
		    }
		%>
	
		 Sender_Mem_No = "<%=list1.getSender_Mem_No()%>";
		 Receiver_Mem_No = "<%=list1.getReceiver_Mem_No()%>";
		
		<%
		 MemVO memVO4 =MemSvc.getOneMem(list1.getSender_Mem_No());
		 MemVO memVO5 =MemSvc.getOneMem(list1.getReceiver_Mem_No());
		%>
		
		 Sender_Mem_Id = "<%=memVO4.getMem_Id()%>";
		 Receiver_Mem_Id = "<%=memVO5.getMem_Id()%>";
		 Chat_Datetime = "<%=list1.getChat_Datetime()%>";		
		 Chat_Content=":"; 
		<c:if test="<%=list1.getChat_Content()!=null%>">
			Chat_Content="<%=list1.getChat_Content().trim()%>";
		</c:if>
	
		//***************把Timestamp 格式轉成 一般時間格式**************
		var Chat_Datetime = Date.parse(Chat_Datetime);  
		Chat_Datetime = Chat_Datetime / 1000;  
		var newDate = new Date();  
		newDate.setTime(Chat_Datetime * 1000);  
		Chat_Datetime =newDate.toLocaleString(); 
		//***************把Timestamp 格式轉成 一般時間格式**************
		
		
		  if(<%=list1.getChat_Content().length() %> >50){	        
		    	if(memname === Sender_Mem_Id){
		      		$('#myPanel').append('<div class="right speech rightd" style="text-align: right; vertical-align: text-bottom">'+<c:if test="<%=list1.getChat_Content().length()>50%>">'<span style="word-break: break-all;"><img style="width: 200px; height: 200px;" src="' </c:if> +Chat_Content+ <c:if test="<%=list1.getChat_Content().length()>50%>"> '">'</c:if> +'<br>'+Sender_Mem_Id+'<br>'+Chat_Datetime+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"></div>');
					console.log("11155555555555555551111userName +"+ userName);
		    	}else{
		      		$('#myPanel').append('<div class="left speech leftd">'+Sender_Mem_Id+'<br><img src="'+context+'/mem/memShowImage.do?mem_No='+Sender_Mem_No+'">：<span style="word-break: break-all; width: 200px; height: 50px;"><img style="width: 200px; height: 200px;" src="'+Chat_Content+'"></span><span><br>'+Chat_Datetime+'  </span></div>');
		      		console.log("1116666666666666661111userName +"+ userName);
		    	}
		    }else{
		    	
		    	if(memname === Sender_Mem_Id){
		       	$('#myPanel').append('<div class="right speech rightd" style="text-align: right; vertical-align: text-bottom"><span style="word-break: break-all;"><br>'+Chat_Content+'<br>'+Receiver_Mem_Id+'<br>'+Chat_Datetime+':'+'</span><span>  </span><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"></div>');
				console.log("1177777777777777771111userName +"+ userName);
				}else{
		       	$('#myPanel').append('<div class="left speech leftd">'+Sender_Mem_Id+'<br><img src="'+context+'/mem/memShowImage.do?mem_No='+Sender_Mem_No+'"><span style="word-break: break-all; width: 200px; height: 50px;">：'+Chat_Content+'<br>'+Chat_Datetime+'</span><span>  </span></div>');
		    	console.log("11188888888888111userName +"+ userName);
		       }
		    }	
		      		
			<%}%>
			
			//******************************第二段出現	crSvc.getRecord(takecase_Mem_No,memVO.getMem_No()); 內容*************		
			
			
			
		$('html, body , #myPanel').scrollTop(10000000);
	};

	//*****************************把之前的留言重新載入***************
	
	//*****************************把收到的訊息及輸入的訊息印出***************
	
	webSocket.onmessage = function(event) {
		 jsonObj = JSON.parse(event.data);
		 userName = jsonObj.userName;
		var message = jsonObj.message;
		var Receiver_Mem_No = jsonObj.Receiver_Mem_No;
		var Sender_Mem_No = jsonObj.Sender_Mem_No;
		console.log("Receiver_Mem_No+"+Receiver_Mem_No);
		console.log("Sender_Mem_No +" +Sender_Mem_No);
		var nowdate = jsonObj.chat_Datetime;
		//***************把Timestamp 格式轉成 一般時間格式**************
		var date; 
		date = new Date();
		date = date.getUTCFullYear() + '-' +
		    ('00' + (date.getUTCMonth()+1)).slice(-2) + '-' +
		    ('00' + date.getUTCDate()).slice(-2) + ' ' + 
		    ('00' + date.getUTCHours()).slice(-2) + ':' + 
		    ('00' + date.getUTCMinutes()).slice(-2) + ':' + 
		    ('00' + date.getUTCSeconds()).slice(-2);
		console.log(date);
		nowdate = date;
		
			    
			    
			    
		url = jsonObj.src;
		        	
	    if(url !=null){	        
	    	if(memno === Sender_Mem_No){
	      		$('#myPanel').append('<div class="right speech rightd" style="text-align: right; vertical-align: text-bottom">'+memname+'<br><span style="word-break: break-all;"><img style="width: 200px; height: 200px;" src="'+url+'"></span><span>  </span>：<img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"><br>'+nowdate+'</div>');
				console.log("1111111userName +" + userName );
// 				console.log("Date：" + Date);  
			} else {
	      		$('#myPanel').append('<div class="left speech leftd">'+Sender_Mem_Id+'<br><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'"><span style="word-break: break-all; width: 200px; height: 50px;">：<img style="width: 200px; height: 200px;" src="'+url+'"></span><span>  </span><br>'+nowdate+'</div>');
	      		console.log("1222222userName ");
			}
	    }else{
	    	if(memno === Sender_Mem_No){
	    	    $('#myPanel').append('<div class="right speech rightd" style="text-align: right; vertical-align: text-bottom">'+memname+'<br><span style="word-break: break-all;">'+message+'</span><span>  </span>：<img src="'+context+'/mem/memShowImage.do?mem_No='+memno+'"><br>'+nowdate+'</div>');
	    	    console.log("33333333userName ");
	    	}else{
	    		$('#myPanel').append('<div class="left speech leftd">'+userName+'<br><img src="'+context+'/mem/memShowImage.do?mem_No='+targetMemNo+'">：<span style="word-break: break-all; width: 200px; height: 50px;">'+message+'</span><span>  </span><br>'+nowdate+'</div>');
	    		console.log("4444444userName ");
	    	}
	    }
	
	console.log('test')			
		$('html, body , #myPanel').scrollTop(10000000);
	};

	webSocket.onclose = function(event) {
		updateStatus("WebSocket 已離線");
	};
}
	
	
var inputUserName = document.getElementById("userName");
inputUserName.focus();

//*****************************把收到的訊息及輸入的訊息印出***************
	
function sendMessage() {
 userName = inputUserName.value.trim();
	
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
			String dateStr = "";
			Timestamp chat_Datetime = new Timestamp(System.currentTimeMillis());
			System.out.println("chat_Datetime+" + chat_Datetime);
			chatRecordVO.setChat_Datetime(chat_Datetime);
			System.out.println("takecase_Mem_No" + takecase_Mem_No);
			request.setAttribute("chatRecordVO", chatRecordVO);
			%>
			
			var date;
			date = new Date();
			date = date.getUTCFullYear() + '-' +
			    ('00' + (date.getUTCMonth()+1)).slice(-2) + '-' +
			    ('00' + date.getUTCDate()).slice(-2) + ' ' + 
			    ('00' + date.getUTCHours()).slice(-2) + ':' + 
			    ('00' + date.getUTCMinutes()).slice(-2) + ':' + 
			    ('00' + date.getUTCSeconds()).slice(-2);
			console.log(date);
			var nowdate = date;
 console.log("chatContent" + chatContent);
 
 var queryString= {"action":"insert","chatContent":message, "Sender_Mem_No":'<%=memVO.getMem_No()%>' , "Receiver_Mem_No":'<%=takecase_Mem_No%>' , "chat_Datetime":nowdate,"src":url};
	
 console.log("queryString +" +queryString);
 
 upload(queryString);

 	//*************************************************************************************
      jsonObj = {"userName" : userName, "message" : message, "Sender_Mem_No":'<%=memVO.getMem_No()%>' , "Receiver_Mem_No":'<%=takecase_Mem_No%>' , "chat_Datetime":nowdate};
		webSocket.send(JSON.stringify(jsonObj));
	
     inputMessage.value = "";
     $('#mem_Pic').value ="";
     inputMessage.focus();
 }
}


function upload(aa){
	console.log("aa +" +aa);
$.ajax({
	 type: "POST",
	 url: "<%=request.getContextPath()%>/chatrecord/chatrecord.do",
	 data: aa,
	 dataType: "json",
	 
	 success: function (data){ },
	 error: function(){}
	 
});
	
}



	
function sendImg(url){
	
	userName = inputUserName.value.trim();
	var inputMessage = document.getElementById("message");
 var message = inputMessage.value.trim();
 //*******************************撰寫Timestamp格式
 var date;
	date = new Date();
	date = date.getUTCFullYear() + '-' +
	    ('00' + (date.getUTCMonth()+1)).slice(-2) + '-' +
	    ('00' + date.getUTCDate()).slice(-2) + ' ' + 
	    ('00' + date.getUTCHours()).slice(-2) + ':' + 
	    ('00' + date.getUTCMinutes()).slice(-2) + ':' + 
	    ('00' + date.getUTCSeconds()).slice(-2);
	console.log(date);
	var nowdate = date;
	//*******************************撰寫Timestamp格式
//  alert(userName);
  jsonObj ={
 		"action":"insert",
 		"chatContent":message, 
 		"Sender_Mem_No":'<%=memVO.getMem_No()%>' , 
 		"Receiver_Mem_No":'<%=takecase_Mem_No%>' , 
 		"chat_Datetime":nowdate,
 		"src":url
 		};
 console.log(jsonObj);
 upload(jsonObj);
 webSocket.send(JSON.stringify(jsonObj));
 inputMessage.value = "";
 $('#mem_Pic').value ="";
    inputMessage.focus();
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