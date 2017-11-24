<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.disputecase.model.DisputeCaseVO"%>
<%@page import="com.disputecase.model.DisputeCaseService"%>
<%@page import="java.util.*"%>
<%@page import="com.getmission.model.*"%>
<%@page import="com.getmission.controller.*"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.getmission.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
GetMissionService getMissionService = new GetMissionService();
DisputeCaseService disputeCaseService = new DisputeCaseService();
List<GetMissionVO> listUserMissionPending = getMissionService.findByMem("M000002",1);
List<GetMissionVO> listUserMission = getMissionService.findByMem("M000002",1);
List<DisputeCaseVO> listMemDisputeCase = disputeCaseService.getDisputeCaseByMem("M000011");
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
%>
<!DOCTYPE html>
<html>
<head>
	
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Title Page</title>
	
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- TODO記得要放專案路徑 -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/css/issuemission/SanderTemplate.css">
    <!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
    <style type="text/css">
	/* 對齊div用 */
    	/*div{border: 1px solid grey;}*/
    /* 字體from Google	 */
    	/* @import url(//fonts.googleapis.com/earlyaccess/notosanstc.css);
    	font-family: 'Noto Sans TC', sans-serif; */
       #map {
        height: 400px;
        width: 100%;
       }
       p{
        style="color:black;"
        font-size:20px;
        }
    </style>
</head>


           
<body>
	<!-- includefile -->
		<%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
	<!-- MissionControlPanel -->
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-8">
				<%-- 任務管理面板 --%>
					<div role="tabpanel">
					    <!-- 標籤面板：標籤區 -->
					    <ul class="nav nav-tabs" role="tablist">
					        <li role="presentation" class="active">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">已發任務一覽</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">接案人申請列表</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">待結案與評價</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab4" aria-controls="tab4" role="tab" data-toggle="tab">爭議案件處理</a>
					        </li>
					    </ul>
					    <!-- 標籤面板：內容區 -->
					    <div class="tab-content">
					        <div role="tabpanel" class="tab-pane active" id="tab1">
						        <table class="table table-condensed">
						        	<thead>
						        		<tr>
						        			<td><p>任務編號</p></td>
						        			<td><p>任務名稱</p></td>
						        			<td><p>發出日期</p></td>
						        		</tr>
						        	</thead>
						        	<tbody>
						        		<%for(GetMissionVO getMissionVO : listUserMissionPending){ %>
						        		<tr>
						        			<td><p><%=getMissionVO.getMission_No() %></p></td>
						        			<td><p><%=getMissionVO.getMission_Name() %></p></td>
						        			<td><p><%=simpleDateFormat.format(getMissionVO.getMission_Release_Time())%></p></td>
						        		</tr>
						        		<%}%>
						        	</tbody>
						        </table>
					        </div>
					        <div role="tabpanel" class="tab-pane" id="tab2">
					        	<p>頭條標籤的內容</p>
					        </div>
					        <div role="tabpanel" class="tab-pane" id="tab3">
					        	<p>最新標籤的內容</p>
					        </div>
					    </div>
					</div>
				</div>
				<%-- 發案按鈕區 --%>
				<div class="col-xs-12 col-sm-4">
					<a href="issuemission_normalmission.jsp"><div class="css_issuemissionbutton">一般任務</div></a>
					<a href="issuemission_emergencymission.jsp"><div class="css_issuemissionbutton">緊急任務</div></a>
				</div>
			</div>
		</div>
	<hr>
	<!-- Google Map -->
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-12">
					<%-- 地圖 --%>
					<label>所在位置</label>
				    <div id="map"></div>
				    <script>
				      function initMap() {
				      	var pos;
				      	var lat;
				      	var lng;
				      	var contentString = '<div class="content"><input type="submit" class="btn btn-primary" name="" value="Check"></div>';
				        var map = new google.maps.Map(document.getElementById('map'), {
				          center: {lat: -34.397, lng: 150.644},
				          zoom: 15
				        });
				        var infoWindow = new google.maps.InfoWindow({contents: contentString});
				        // Try HTML5 geolocation.
				        if (navigator.geolocation) {
				          navigator.geolocation.getCurrentPosition(function(position) {
				            pos = {
				              lat: position.coords.latitude,
				              lng: position.coords.longitude
				            };

				            infoWindow.setPosition(pos);
				            infoWindow.setContent(contentString);
				            map.setCenter(pos);
				            var marker = new google.maps.Marker({
				          		position: pos,
				          		map: map,
				          		title: "某工具人"
				        	});	
				           	marker.addListener('click', function () {
				           		infoWindow.open(map,marker);
				           	})
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
				</div>
			</div>
		</div>
		<hr>
    <!-- =============================================================== -->
	



    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>

</html>