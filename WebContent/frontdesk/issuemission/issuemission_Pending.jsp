<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>接案人驗證</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style type="text/css">
			img{
				width: 300px;
			}
			body {
	            background-image: url(<%=request.getContextPath()%>/res/images/QRcode/mountain_1920.jpg);
	            background-repeat: no-repeat;
	            background-attachment: fixed;
	            background-position: center;
	            background-size: cover;
	            font-family: Microsoft JhengHei;
	        }
		</style>
	</head>
	<body onload="connect();">
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-12">
					<p><font color='red'>請修正以下錯誤:</font></p>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color:red"><p>${message}</p></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		<%-- 抓session 會員MemVO 與任務 MissionVO 塞進Request 丟進QRcodeAccept --%> 
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-12" style="text-align: center;">
					<h1 class="text-center">接案人驗證</h1>
					<br>
					<br>
					<p style="font-size: 200%">請掃描下方QRcode</p>
					<br>
					<img src="<%=request.getContextPath()%>/qrcode/qrcode.do?takecase_Mem_No=<%=request.getParameter("mission_No")%>&mission_No=<%=request.getParameter("takecase_Mem_No")%>">
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<p style="font-size: 200%; color: grey;">...或是直接輸入驗證碼</p>
					<br>
					<br>
					<br>
					<div class="col-xs-12 col-sm-4 col-sm-offset-4">
						<div class="form-group">
						    <form action="<%=request.getContextPath()%>/qrcodeaccept/qrcodeaccept.do">
						        <input type="hidden" name="action" value="input_By_Type">
						        <input type="password" class="form-control" name="validation">
						        <br>
						        <br>
						        <input type="submit" value="驗證身分" class="btn btn-primary btn-lg">
						    </form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
	<script type="text/javascript">
 //    var MyPoint = "/MyEchoServer";
 //    var host = window.location.host;
 //    var path = window.location.pathname;
 //    var webCtx = path.substring(0, path.indexOf('/', 1));
 //    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;    
	// var webSocket;
	// function connect() {
	// 	// 建立 websocket 物件
	// 	webSocket = new WebSocket(endPointURL);
		
	// 	webSocket.onopen = function(event) {
	// 	};

	// 	webSocket.onmessage = function(event) {
	//         var jsonObj = JSON.parse(event.data);
	// 	};

	// 	webSocket.onclose = function(event) {
	// 	};
	// }
	</script>
</html>