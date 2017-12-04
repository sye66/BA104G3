<%@page import="com.casecandidate.model.CaseCandidateService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.disputecase.model.DisputeCaseVO"%>
<%@page import="com.disputecase.model.DisputeCaseService"%>
<%@page import="java.util.*"%>
<%@page import="com.getmission.model.*"%>
<%@page import="com.getmission.controller.*"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.getmission.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="getMissionService" scope="page" class="com.getmission.model.GetMissionService"></jsp:useBean>
<jsp:useBean id="disputeCaseService" scope="page" class="com.disputecase.model.DisputeCaseService"></jsp:useBean>
<jsp:useBean id="memService" scope="page" class="com.mem.model.MemService"></jsp:useBean>
<%
	MemVO memVO2;
	try{
		memVO2 = (MemVO) request.getSession().getAttribute("memVO");
		if (memVO2.getMem_Name() == null){
			RequestDispatcher notLogin = request.getRequestDispatcher("/lib/publicfile/include/file/index.jsp");
			notLogin.forward(request, response);
			return;
		}
	} catch (NullPointerException e){
		RequestDispatcher notLogin = request.getRequestDispatcher("/lib/publicfile/include/file/index.jsp");
		notLogin.forward(request, response);
		return;
	}
	String mem_No = memVO2.getMem_No();
	System.out.print("JSP的 mem_No:" + mem_No);
	List<MemVO> list = memService.getAll(); 
	List<GetMissionVO> listUserMissionPending = getMissionService.findByMem(mem_No,1);
	List<GetMissionVO> listUserMission = getMissionService.findByMem(mem_No,1);
	List<DisputeCaseVO> listMemDisputeCase = disputeCaseService.getDisputeCaseByMem(mem_No);
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
	List<DisputeCaseVO> listGetMemDisCase = disputeCaseService.getDisputeCaseByMem(mem_No);
%>
<style type="text/css">
	.userimg{
		height: 100px
	}
</style>

<!DOCTYPE>
<html>
<head>
	
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Title Page</title>
	
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- TODO記得要放專案路徑 -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/css/issuemission/SanderTemplate.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/css/issuemission/Button.css">
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
       ul,li,tr,td,label,p{
        style="color:black;"
        font-size:12px;
        font-family: "微軟正黑體";
        }
       .userimg{
       	width: 100%;
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
	<%-- 第一層 - 任務顯示面板 --%>
	<div class="container-fluid">
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
                            <a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">爭議案件處理</a>
                        </li>
                    </ul>
                    <!-- 標籤面板：內容區 -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="tab1">
                            <table class="table table-condensed">
                                <thead>
                                    <tr>
                                        <td>任務編號</td>
                                        <td>任務名稱</td>
                                        <td>發出日期</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for(GetMissionVO getMissionVO : listUserMissionPending){ %>
                                        <tr>
                                            <td>
                                                <%=getMissionVO.getMission_No() %>
                                            </td>
                                            <td>
                                                <%=getMissionVO.getMission_Name() %>
                                            </td>
                                            <td>
                                                <%=simpleDateFormat.format(getMissionVO.getMission_Release_Time())%>
                                            </td>
                                        </tr>
                                        <%}%>
                                </tbody>
                            </table>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="tab3">
                            <table class="table table-condensed">
                            	<tr>
                            		<td>爭議案件編號</td>
                            		<td>發布時間</td>
                            		<td>處理狀態</td>
                            	</tr>
                            	<%try{for(DisputeCaseVO disputeCaseVO : listGetMemDisCase){ %>
                            	<tr>
                            		<td><%=disputeCaseVO.getDispute_Case_No()%></td>
                            		<td><%=simpleDateFormat.format(disputeCaseVO.getIssue_Datetime())%></td>
                            		<%
                            			Integer statusCode = disputeCaseVO.getDispute_Case_Status();
                            			String status = null;
                            			switch(statusCode){
                            				case 1: status = "未處理";
                            				break;
                            				case 2: status = "處理中";
                            				break;
                            				case 3: status = "申訴成功";
                            				break;
                            				case 4: status = "申訴失敗";
                            				break;
                            			}
                            		%>
                            		<td><%=status%></td>
                            	</tr>
                            	<%} } catch(NullPointerException e){%>
                            		<td></td>
                            		<td></td>
                            		<td></td>
                            		<%} %>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <%-- 發案按鈕區 --%>
            <div class="col-xs-12 col-sm-4">
                <div class="row" style="margin-bottom:30px;">
                    <a href="<%=request.getContextPath()%>/frontdesk/issuemission/issuemission_normalmission.jsp" style="margin-left: auto;margin-right: auto;">
                        <div class="issuemission_normal_button" style="">一般任務</div>
                    </a>
                </div>
                <div class="row" style="margin-top: 30px;margin-left: auto;margin-right: auto;">
                    <a href="<%=request.getContextPath()%>/frontdesk/issuemission/issuemission_emergencymission.jsp" style="margin-left: auto;margin-right: auto;">
                        <div class="issuemission_ermergency_button">緊急任務</div>
                    </a>
                </div>
                <div class="row" style="margin-top:10px; margin-left: auto;margin-right: auto;">
                    <a href="<%=request.getContextPath()%>/frontdesk/mission/missiongroup.jsp" style="margin-left: auto;margin-right: auto;">
                        <div class="mission_management_button">查看我的任務</div>
                    </a>
                </div>
            </div>
        </div>
    </div>
	<hr>
	
	<!-- =============================================================== -->

	<!-- 第二層 - Google Map -->
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
				        
				        
				        var map = new google.maps.Map(document.getElementById('map'), {
				            center: { lat: -34.397, lng: 150.644 },
				            zoom: 2
				        });

				        // Try HTML5 geolocation.

				        if (navigator.geolocation) {
				            navigator.geolocation.getCurrentPosition(function(position) {
				                pos = {
				                    lat: position.coords.latitude,
				                    lng: position.coords.longitude
				                };
				                map.setCenter(pos);

				                $.ajax({
				                    url: '<%=request.getContextPath()%>/getmission/getmission.do',
				                    type: 'post',
				                    data: {
				                        action: "get_Location_Json",
				                    },
				                    dataType: "json",

				                    success: function(data) {
				                        for (var i = 0; i < data.length; i++) {
				                            var obj = data[i];
				                            var contentString = obj.mem_No+'<form action="<%=request.getContextPath()%>/frontdesk/issuemission/issuemission_takecasemission.jsp" method="post"><input type="hidden" name="takecase_Mem_No"	value="' + obj.mem_No + '"><input type="submit" value="直接發案" class="btn btn-info"></form>';
				                            var GPS_Position = { lat: obj.mem_GPS_LAT, lng: obj.mem_GPS_LNG }
				                            // InfoWindow
				                            var infoWindow2 = new google.maps.InfoWindow({ contents: contentString });
				                            infoWindow2.setPosition(GPS_Position);
				                            // Marker
				                            var marker2 = new google.maps.Marker({
				                                position: GPS_Position,
				                                map: map,
				                                title: "某工具人"
				                            });
				                            google.maps.event.addListener(marker2, 'click', (function(marker2, contentString, infoWindow2) {
				                                return function() {
				                                    infoWindow2.setContent(contentString);
				                                    infoWindow2.open(map, marker2);
				                                };
				                            })(marker2, contentString, infoWindow2));
				                        }
				                    }
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
	
<%-- 第三層 - 接案人 --%>
    <%-- 所有任務列表 --%>
        <%-- 取得所有會員的集合 --%>
        <div class="container">
        <%-- 老師的分頁檔案PART1 --%>
    	<%@ include file="pages/page1.file"%>
        <c:forEach var="memVO" items="<%=memService.getAll(mem_No)%>"  begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="StepCount" step="1">
        	<%-- 從一起算，第一筆(左側)資料加上ROW --%>
        	<c:if test="${((StepCount.count) % 2) == 1}">
        		<div class="row">
    		</c:if>
            <%-- 開始寫入本體 --%>
				<div class="col-xs-12 col-sm-6">
					<div class="row">
						<%-- 會員照片 --%>
						<div class="col-xs-12 col-sm-4">
							<img class="userimg" src="<%=request.getContextPath()%>/mem/mem.do?action=get_Mem_pic&request_From_Issue=${memVO.mem_No}">
						</div>
						<%-- 會員資訊 --%>
						<div class="col-xs-12 col-sm-8">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3 class="panel-title">${memVO.mem_Id}</h3>
								</div>
								<div class="panel-body" style="height: 110px">
									<p style="font-size: 16px;">${memVO.mem_Intro}</p>
									<form
										action="<%=request.getContextPath()%>/frontdesk/issuemission/issuemission_takecasemission.jsp"
										method="post">
										<input type="hidden" name="takecase_Mem_No"	value="${memVO.mem_No}"> 
										<input type="submit" value="直接發案" class="btn btn-info">
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			<%-- 從一起算，第二筆(右側)資料加上ROW END TAG --%>
   			<c:if test="${((StepCount.count) % 2)==0}">
    			</div>
    		</c:if>
		</c:forEach>
		</div>
		<%-- 老師的分頁檔案PART2 --%>
	     <div class="container">
			<%@include file="pages/page2.file"%>
		</div>
	</div>
	<hr>
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
	<!-- =============================================================== -->
	<script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<%@ include file="/lib/publicfile/include/file/footer.jsp"%>
</body>

</html>