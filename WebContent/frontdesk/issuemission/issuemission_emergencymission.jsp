<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.mem.model.*" %>
<%
	MemVO memVOemergencymission;
	try{
		memVOemergencymission = (MemVO) request.getSession().getAttribute("memVO");
		if (memVOemergencymission.getMem_Name() == null){
			RequestDispatcher notLogin = request.getRequestDispatcher("/lib/publicfile/include/file/index.jsp");
			notLogin.forward(request, response);
			return;
		}  else if (memVOemergencymission.getMem_State()==0 || memVOemergencymission.getMem_State()==9) {
			RequestDispatcher disqualify = request.getRequestDispatcher("/frontdesk/issuemission/issuemission_Disqualify.jsp");
			disqualify.forward(request, response);
			return;
		}
	} catch (NullPointerException e){
		RequestDispatcher notLogin = request.getRequestDispatcher("/lib/publicfile/include/file/index.jsp");
		notLogin.forward(request, response);
		return;
	}
%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		
		<title>工具人聽候差遣</title>
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/component/JQueryUI/jquery-ui.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="<%=request.getContextPath()%>/lib/component/JQueryUI/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
	    <style type="text/css">
	        body {
	            background-image: url(<%=request.getContextPath()%>/res/images/issuemission/soviet-union-2704166_1920.jpg);
	            background-repeat: no-repeat;
	            background-attachment: fixed;
	            background-position: center;
	            background-size: cover;
	            font-family: Microsoft JhengHei;
	        }
	       label,p {
	       	color: white;
	       }
	       #map {
	        height: 300px;
	        width: 100%;
	       }
	    </style>
		<script type="text/javascript">
		$(function() {

		    function format_float(num, pos) {
		        var size = Math.pow(10, pos);
		        return Math.round(num * size) / size;
		    }

		    function preview(input) {

		        if (input.files && input.files[0]) {
		            var reader = new FileReader();

		            reader.onload = function(e) {
		                $('.preview').attr('src', e.target.result);
		                var KB = format_float(e.total / 1024, 2);
		                $('.size').text("檔案大小：" + KB + " KB");
		            }

		            reader.readAsDataURL(input.files[0]);
		        }
		    }

		    $("body").on("change", "#mission_images", function() {
		        preview(this);
		    })
		})
		</script>
	</head>
	<body>
		<%-- Banner --%>
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-8 col-sm-offset-2"></div>
			</div>
		</div>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-12">
					<p><font color='white'>請修正以下錯誤:</font></p>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color:white"><p>${message}</p></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		<%-- IssueMissionForm --%>
		<div class="container">
			<div class="row">
				<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" enctype="multipart/form-data">
					<div class="col-xs-12 col-sm-8 col-sm-offset-2">
						<%-- 發案人會員編號 --%>
						<input type="hidden" name="issuer_Mem_No" value="<%=memVOemergencymission.getMem_No()%>">
						<%-- 任務類別 --%>
							<div class="form-group">
								<label for="mission_Category">
									想要甚麼樣的工具人
								</label>
								<select class="form-control" name="mission_Category">
									<option value="修繕">需要很會修東西的</option>
									<option value="教育">博學多聞能教我的</option>
									<option value="交友">長的不錯交個朋友</option>
									<option value="其他">我的需求有點特別</option>
								</select>
							</div>
						<%-- 任務名稱 --%>
							<div class="form-group">
								<label for="mission_Name">
									任務名稱
								</label>
								<input type="text" name="mission_Name" id="mission_Name" placeholder="請輸入任務名稱" class="form-control" id="mission_Name">
							</div>
						<%-- 任務敘述 --%>
							<div class="form-group">
								<label for="mission_Des">
									說說關於你的任務
								</label>
								<textarea class="form-control" name="mission_Des" id="mission_Des" rows="3"></textarea>
							</div>
						<%-- 報酬 --%>
							<div class="form-group">
								<label for="mission_Pay">積分花費</label>
								<input type="number" name="mission_Pay" id="mission_Pay" class="form-control is-invalid" value=100>
						 	    <div class="invalid-feedback">
	        						<p>緊急任務無積分上限</p>
	      						</div>
							</div>
						<%-- 位置GoogleMap --%>
							<%-- LAT --%>
							<div class="form-group col-sm-6">
								<input type="text" name="mission_Gps_Lat" id="mission_Gps_Lat" class="form-control" style="display: none;">
							</div>
							<%-- lng --%>
							<div class="form-group col-sm-6">
								<input type="text" name="mission_Gps_Lng" id="mission_Gps_Lng" class="form-control" style="display: none;">
							</div>
							<%-- 地圖 --%>
							<label>所在位置</label>
						    <div id="map"></div>
						    <script>
						      function initMap() {
						      	var pos;
						      	var lat;
						      	var lng;
						        var map = new google.maps.Map(document.getElementById('map'), {
						          center: {lat: 24.967982, lng:121.191678},
						          zoom: 15
						        });
						        var infoWindow = new google.maps.InfoWindow({map: map});

						        // Try HTML5 geolocation.
						            pos = {
						              lat: 24.967982,
						              lng: 121.191678
						            };

						            infoWindow.setPosition(pos);
						            infoWindow.setContent('安安你目前在這裡喔');
						            map.setCenter(pos);
						            document.getElementById("mission_Gps_Lat").value = pos.lat;
						            document.getElementById("mission_Gps_Lng").value = pos.lng;
						        //     var marker = new google.maps.Marker({
						        //   	position: pos,
						        //   	map: map
						        // }
						        // );	
						      
						      }
					      
						      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
						        infoWindow.setPosition(pos);
						        infoWindow.setContent(browserHasGeolocation ?
						                              'Error: The Geolocation service failed.' :
						                              'Error: Your browser doesn\'t support geolocation.');
						      }
						    </script>
						 	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDsHkChmufu1IrpSdVxTk0VC3_6cvjQeIo&callback=initMap"></script>
						<%-- 任務圖片 --%>
							<div class="form-group" style="text-align: center;">
								<label for="mission_images">上傳圖片</label>
								<input type="file" name="mission_images" id="mission_images" class="form-control">
								<br>
								<img class="preview" style="max-width: 300px; max-height: 300px;">
								<input type="button" name="dispute_demo" id="dispute_demo" value="爭">
								<input type="button" name="dispute_demo" id="accuse_demo" value="檢">
							</div>
						<div style="text-align: center; height: 200px; width: 100%; margin-top: 30px;">
								<input type="hidden" name="action" value="issue_Emergency_Mission">
								<input type="submit" value="發出任務" class="btn btn-primary btn-lg">
						</div>
						
					</div>
				</form>
			</div>
		</div>
		<script type="text/javascript">
		$("#dispute_demo").click(function(){
			console.log("dispute_demo clicked")
			$("#mission_Name").val("需要正妹陪我吃飯！");
			$("#mission_Des").val("快來找我吃飯吧呵呵")
		})
		$("#accuse_demo").click(function() {
			console.log("accuse_demo clicked")
			$("#mission_Name").val("積積陰陰德");
			$("#mission_Des").val("最近有點in")
		});
		</script>
	</body>
</html>
