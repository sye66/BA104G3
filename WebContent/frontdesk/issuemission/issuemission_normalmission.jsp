<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		
		<style>
	       #map {
	        height: 300px;
	        width: 100%;
	       }
	    </style>

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
			<font color='red'>請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
		<%-- IssueMissionForm --%>
		<div class="container">
			<div class="row">
				<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do">
					<div class="col-xs-12 col-sm-8 col-sm-offset-2">
						<%-- 發案人會員編號 --%>
						<input type="hidden" name="issuer_Mem_No" value="M000010">
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
								<input type="text" name="mission_Name" id="mission_Name" placeholder="請輸入任務名稱" class="form-control">
							</div>
						<%-- 任務敘述 --%>
							<div class="form-group">
								<label for="mission_Des">
									說說關於你的任務
								</label>
								<textarea class="form-control" name="mission_Des" id="mission_Des" rows="3"></textarea>
							</div>
						<%-- 任務發布時間 --%>
							<div class="form-group col-sm-6">
								<label>
									任務發布時間
								</label>
									<input type="text" name="mission_Release_Time" id="mission_Release_Time" class="form-control">
								<script type="text/javascript">
									$(function(){
										$('#mission_Release_Time').datepicker({
											dateFormat: 'yy-mm-dd'
										});
									});
								</script>
							</div>
						<%-- 任務截止時間 --%>
							<div class="form-group col-sm-6">
								<label>
									任務截止時間
								</label>
									<input type="text" name="mission_Due_Time" id="mission_Due_Time" class="form-control">
								<script type="text/javascript">
									$(function(){
										$('#mission_Due_Time').datepicker({
											dateFormat: 'yy-mm-dd'
										});
									});
								</script>
							</div>
						<%-- 報酬 --%>
							<div class="form-group">
								<label for="mission_Pay">積分花費</label>
								<input type="number" name="mission_Pay" id="mission_Pay" class="form-control is-invalid" value=50 readonly>
						 	    <div class="invalid-feedback">
	        						一般任務固定消費50點積分
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
						          center: {lat: -34.397, lng: 150.644},
						          zoom: 15
						        });
						        var infoWindow = new google.maps.InfoWindow({map: map});

						        // Try HTML5 geolocation.
						        if (navigator.geolocation) {
						          navigator.geolocation.getCurrentPosition(function(position) {
						            pos = {
						              lat: position.coords.latitude,
						              lng: position.coords.longitude
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
						          }, function() {
						            handleLocationError(true, infoWindow, map.getCenter());
						          });
						        } else {
						          // Browser doesn't support Geolocation
						          handleLocationError(false, infoWindow, map.getCenter());
						        }
						      }
					      
						      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
						        infoWindow.setPosition(pos);
						        infoWindow.setContent(browserHasGeolocation ?
						                              'Error: The Geolocation service failed.' :
						                              'Error: Your browser doesn\'t support geolocation.');
						      }
						    </script>
						 	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDsHkChmufu1IrpSdVxTk0VC3_6cvjQeIo&callback=initMap"></script>

						<div style="text-align: center; height: 200px; width: 100%; margin-top: 30px;">
								<input type="hidden" name="action" value="issue_Normal_Mission">
								<input type="submit" name="發出任務">
						</div>
						
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
