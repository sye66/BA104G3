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

body {
  width:90%;
  height:90%;
  line-height: 100%;
  word-break: break-word;
  font: 18px verdana, Times New Roman, arial, helvetica, sans-serif, Microsoft JhengHei;
  
}

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
    height:500px;
   margin-left: 20px;
   font-size:20px;
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
map {
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

main {
  display: block;
  height:100%;
  margin-top:350px;
}

.list-content >.panel {
  padding-bottom: 16px;
  height:100%;
  margin-top:350px;
}

footer {
  height: 80px;
  overflow: hidden;
  -webkit-box-sizing: border-box;
          box-sizing: border-box;
  background: #fafafa;
  border-top: 1px solid #ddd;
  z-index: 50;
}
</style>
    </head>
    <body onload="connect();" onunload="disconnect();" class="layout-scroll">

        <h1> Chat Room ***</h1>            
	        <h3 id="statusOutput" class="statusOutput"></h3>
	        
	 <main class="list" >
        <div>
            <div id="list" class="list-content">      
            <map id="messagesArea" class="panel message-area" readonly >
            </map>
            </div>
        </div>
    </main>  
    

    <div class="emo" style="background-color:#FFF">
    
    </div>

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
            
      <td width="189" align="left"> &nbsp;&nbsp;字體顏色：
      <select name="color" size="1" class="wenbenkuang" id="select" onChange="myNewFunction(this);">
        <option selected style="color:#FFFF00" value="#FFFF00" >默認顏色</option>
        <option style="color:#FF0000" value="FF0000">紅色熱情</option>
        <option style="color:#0000FF" value="0000ff">藍色開朗</option>
        <option style="color:#ff00ff" value="ff00ff">桃色浪漫</option>
        <option style="color:#009900" value="009900">綠色青春</option>
        <option style="color:#009999" value="009999">青色清爽</option>
        <option style="color:#CCBBFF" value="CCBBFF">淡紫曖昧</option>
        <option style="color:#FF8888" value="FF8888">平淡的熱情</option>
        <option style="color:#66FFFF" value="66FFFF">青藍飄揚</option>
        <option style="color:#999900" value="999900">青澀的青春</option>
        <option style="color:#ff9900" value="ff9900">流金歲月</option>
        <option style="color:#0099ff" value="0099ff">湖波蕩漾</option>
        <option style="color:#9900ff" value="9900ff">發亮藍紫</option>
        <option style="color:#ff0099" value="ff0099">愛的暗示</option>
        <option style="color:#006600" value="006600">墨綠深沉</option>
        <option style="color:#999999" value="999999">煙雨濛濛</option>
      </select></td>
<!--            
       <select id="itemImage" name="itemImage">
           <option data-img="">0</option>
           <option data-img="BA1014G3/res/images/GroupChat/deer1.gif">1</option>
           <option data-img="BA1014G3/res/images/GroupChat/deer2.gif">2</option>
           <option data-img="BA1014G3/res/images/GroupChat/deer3.gif">3</option>
       </select>
         <img src="" id='changeImage'/>
-->              
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
			//加照片版本
//			var jsonObj = JSON.parse(even.data);
//			var userName = jsonObj.userName;
//			var message = jsonObj.message;
			
//			if(mem_Name===jsonObj.userName){
//				$('#mem_Pic').append('<div style="text-align: left; vertical-align: text-bottom"><span style="word-break; break-all;">'+userName+' : '+message+'</span><span></span><img src="'+context+'/tool/showimage.do?mem_No='+mem_No+'"></div>');
//			} else {
//				$('#mem_Pic').append('<div><img src="'+context+'/tool/showimage.do?mem_No='+mem_No+'"><span style="word-break; break-all;width: 200px; height:50px">'+userName+' : '+message+'</span><span></span></div>');
//			}
//			$('html, body').scollTop(10000000);
//            function myNewFunction(sel){
//            	alert(sel.options[sel.selectedIndex].text);
//            	}

//    $(document).ready(function(){
//        $('#itemImage').change(function(){
//            var src = $(this).find('option:selected').attr('data-img');
//            $('img#changeImage').attr('src',src);
//         });
//    });

			//原版本
			var messagesArea = document.getElementById("messagesArea");
//			var color = document.getElementById("select").options[color].value;
            var color =$("#select option:selected").val();
//            var emo = $("#select option:selected").innerHTML();
	        var jsonObj = JSON.parse(event.data);
	        
	        var message ="<font color='#"+ color +"'>" + jsonObj.userName+ "</font>"+": <font color='#" + color + "'>" + jsonObj.message + "</font><br>\r\n";
//	        messagesArea.value = messagesArea.value + message;
	        messagesArea.innerHTML =messagesArea.innerHTML+message;
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
<!--  
<script type="text/javascript">
        function onLoadBinaryFile() {
            var theFile = document.getElementById("theBinaryFile");

            // 確定選取了一個二進位檔案，而非其他格式。
            if (theFile.files.length != 0 && theFile.files[0].type.match(/image.*/)) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var theImg = document.getElementById("theImage");
                    theImg.src = e.target.result;
                };
                reader.onerror = function (e) {
                    alert("例外狀況，無法讀取二進位檔");
                };

                // 讀取二進位檔案。
                reader.readAsDataURL(theFile.files[0]);
            }
            else {
                alert("請選取一個二進位檔");
            }
        }
    </script>


<script>
	
	function InitFace() {
	    var strHTML = "";
	    for (var i = 1; i <= 39; i++) {
	        strHTML += "![](""/GroupChat/" + i + ".gif )";
	    }
	    $("#divFace").html(strHTML);
	}
	
	$(function() {
	    InitFace();
	    $("table tr td img").click(function() {
	        var strContent = $("#txtContent").val() + "<:" + this.id + ":>";
	        $("#txtContent").val(strContent);
	    })
	});
	
	//face icons 
	function InitFace() {
	    var strHTML = "";
	    for (var i = 1; i <= 10; i++) {
	        strHTML += "![](""/GroupChat/" + i + ".gif)";
	    }
	    $("#divFace").html(strHTML);
	}


    window.onload = function() {
    	document.getElementById("itemImage").onchange = showFormatImage;
    	};
    
    	function showFormatImage() {
             var image = document.getElementById("changeImage");
             image.src = $('select[name=itemImage] option:selected').attr('data-img');
             return false;
          }
</script>
-->
</html>
