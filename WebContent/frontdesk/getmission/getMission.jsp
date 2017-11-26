<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="missionImagesSvc" scope="page" class="com.missionimages.model.MissionImagesService" />
<jsp:useBean id="getMissionSvc" scope="page" class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="caseCandidateSvc" scope="page" class="com.casecandidate.model.CaseCandidateService" />

<%
	GetMissionService getMissionService = new GetMissionService();
	List<GetMissionVO> list = getMissionService.getAllValidMission();
%>

<html lang="">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>getMission</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/css/getmission/map.css">
    <script src="<%=request.getContextPath()%>/lib/js/getmission/map.js"></script>
    <script type="text/javascript" src="js/*"></script>
    <!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
    <style type="text/css">
    @media screen and (min-width: 768px) {
        .pic {}
    }
    </style>
</head>

<body>
    <%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <!-- map ====================================================================================-->
        <div class="container">
            <div class="row">
                <div class="input-group ">
                    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/getmission/getmission.do">
                        <div class="row">
                            <select id="mission_Category" name="mission_Category">
                                <option value="">任務分類</option>
                                <option value="教育">教育</option>
                                <option value="修繕">修繕</option>
                                <option value="其他">其他</option>
                                <option value="交友">交友</option>
                                <option value="官方">官方</option>
                            </select>
                            <input type="text" class="form-control input-lg" id="search-mission" name="mission_Name" placeholder="Search for Mission...">
                            <span class="input-group-btn">
									<button class="btn btn-success btn-secondary" type="submit"
										name="action" value="listmission_ByCompositeQuery">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</span>
                        </div>
                    </FORM>
                </div>
                <div id="map"></div>
            </div>
        </div>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBI0AqzghxJv55TD4xLnlng-4hZ57jt2JQ&libraries=places&callback=initMapCustom">
        $('.selectpicker').selectpicker({
            style: 'btn-info',
            size: 4
        });
        </script>
        <br>
        <c:if test="${not empty errorMsgs}">
            <div>${errorMsgs}</div>
        </c:if>
        <div class="container">
            <div class="row">
                <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="missiongroup">
                    <button class="btn btn-success" type="submit" name="action" value="missiongroup">會員任務管理</button>
                    <input type="hidden" name="requestURL" value="<%=request.getContextPath()%>/frontdesk/getmission/getMission.jsp">
                </form>
            </div>
        </div>
        <!-- button ====================================================================================-->
        <div class="container">
            <div class="row">
                <%@ include file="pages/page1.file"%>
            </div>
        </div>
        <c:set var="index" value="${1*1}" />
        <c:forEach var="getMissionVO" items="${getMissionSvc.getAllValidMission()}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="s" step="1">
            <c:set var="index" value="${index + 1}" />
            <c:if test="${s.index%2==0  }">
                <div class="container">
                    <div class="row">
            </c:if>
            <div class="col-xs-12 col-sm-6">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4">
                            <!-- <div class="row"> -->
                            <c:if test="${missionImagesSvc.getMissionpho(getMissionVO.mission_No).size() !=0 }">
                                <img src="<%=request.getContextPath()%>/missionimages/getpic.do?image_No=${missionImagesSvc.getMissionpho(getMissionVO.mission_No).get(0).image_No}" class="img-responsive pic center">
                            </c:if>
                            <c:if test="${missionImagesSvc.getMissionpho(getMissionVO.mission_No).size() ==0}">
                                <img src="<%=request.getContextPath()%>/res/images/getmission/panda.jpg" class="img-responsive pic center">
                            </c:if>
                            <div class="user text-center">
                                <p>USER PICTURE</p>
                            </div>
                            <!-- </div> -->
                        </div>
                        
                        <div class="col-xs-12 col-sm-8">
                            <div class="panel panel-default row">
                                <div class="panel-heading">
                                    <h3 class="panel-title">${getMissionVO.mission_Name}</h3>
                                    <p>${getMissionVO.mission_No }</p>
                                    <p>發案人:${memSvc.getOneMem(getMissionVO.issuer_Mem_No).mem_Name}</p>
                                    <p>1.任務方向:${getMissionVO.mission_Category }</p>
                                    <p>2.報酬是:${getMissionVO.mission_Pay } 積分</p>
                                </div>
                                <table>
                                    <tr>
                                        <td>
                                            <div class="panel-body">
                                                <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission1">
                                                    <button class="btn btn-warning" type="submit" name="action" value="mission_Detail">任務細節</button>
                                                    <input type="hidden" name="mission_No" value="${getMissionVO.mission_No}">
                                                    <input type="hidden" name="requestURL" value="/frontdesk/getmission/getMission.jsp">
                                                </form>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="panel-body">
                                                <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission2">
                                                    <a href='#modal-mission-id${s.index} ' data-toggle="modal">
                                                        <button class="btn btn-info">我要接案</button>
                                                    </a>
                                                    <input type="hidden" name="mission_No" value="${getMissionVO.mission_No}">
                                                </form>
                                            </div>
                                        </td>
                                        <div class="modal fade" id="modal-mission-id${s.index}">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                        <h4 class="modal-title">任務編號:${getMissionVO.mission_No}</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <h4>任務名稱:</h4>
                                                        <p>----${getMissionVO.mission_Name}</p>
                                                        <h4>任務種類:</h4>
                                                        <p>----${getMissionVO.mission_Category}</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission2">
                                                            <button class="btn btn-info" type="submit" name="action" value="take_mission">確認接案</button>
                                                            <input type="hidden" name="mission_No" value="${getMissionVO.mission_No}">
                                                            <input type="hidden" name="mission_State" value="${getMissionVO.mission_State}">
                                                            <input type="hidden" name="requestURL" value="/frontdesk/getmission/getMission.jsp">
                                                        </form>
                                                        <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${s.index%2==1 }">
                </div>
                </div>
            </c:if>
        </c:forEach>
        <c:if test="${index%2==0 }">
            </div>
            </div>
        </c:if>
        <div class="container text-center">
            <div class="row">
                <%@ include file="pages/page2.file"%>
            </div>
        </div>
        <!-- <hr color="#996400"> -->
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
        <br>
        <br>
        <br>
        <br>
        <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>
        <script src="https://code.jquery.com/jquery.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
        $(document).ready(function() {
            $.ajax({
                type: "Post",
                url: <%=request.getContextPath()%> + "/getmission/getmission.do",
                data: { action: "getmissionmap" },
                dataType: "json",
                success: function(data) {
                    var map;
                    var markers = [];
                    var searchResult;
                    var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';

                    function initMap() {
                        var myLatlng = { lat: 24.969, lng: 121.192 };

                        map = new google.maps.Map(document.getElementById('map'), {
                            center: myLatlng,
                            zoom: 14
                        });
                        var marker = new google.maps.Marker({
                            position: myLatlng,
                            map: map,
                            title: 'Click to zoom'
                        });

                        // 擷取及時公車資訊
                        getJSON(data, callback);

                        map.addListener('center_changed', function() {
                            deleteMarkers();
                            getJSON(data, callback);
                        });
                    }

                    function getJSON(url, callback) {
                        var xhr = new XMLHttpRequest();
                        xhr.open('Post', url, true);
                        xhr.responseType = 'json';
                        xhr.onload = function() {
                            var status = xhr.status;
                            if (status === 200) {
                                callback(null, xhr.response);
                            } else {
                                callback(status, xhr.response);
                            }
                        };
                        xhr.send(data);
                    }

                    function callback(errorMsgs, data) {
                        if (errorMsgs !== null) {
                            alert('Something went wrong: ' + err);
                        } else {
                            searchResult = data;
                            console.log(data[0]);
                            $("#place").empty();
                            var index = 1;
                            for (var i = 0; i < data.length; i++) {
                                var mission_No = data[i].mission_No;
                                var mission_Name = data[i].mission_Name;
                                var issuer_Mem_No = data[i].issuer_Mem_No;
                                var mission_Category = data[i].mission_Category;
                                var latLng = new google.maps.LatLng(mission_Gps_Lat, mission_Gps_Lng);
                                if (map.getBounds().contains(latLng)) {
                                    addMarker(latLng, data[i]);
                                    // 			          		$("#place").append("<tr><td>"+index+"</td><td>"+mission_No+"</td><td>"+mission_Name+"</td><td>"+issuer_Mem_No+"</td><td>"+mission_Category+"</td><td>"+mission_Gps_Lat+"</td><td>"+mission_Gps_Lng+"</td></tr>");
                                    index++;
                                }
                            }
                        }
                    }

                    // Adds a marker to the map and push to the array.
                    function addMarker(latLng, result) {
                        var marker = new google.maps.Marker({
                            position: latLng,
                            map: map,
                            icon: iconBase + 'bus_maps.png'
                        });
                        markers.push(marker);
                        var infowindow = new google.maps.InfoWindow({
                            content: "<h2>" + result.mission_Category.Zh_tw + "</h2><div><p><b>任務編號: </b>" + result.mission_No + "</p><p><b>任務名: </b>" + result.mission_Name + "</p><p><b>位置: </b>{" + result.mission_Gps_Lat + "," + result.mission_Gps_Lng + "}</p></div>"
                        });
                        marker.addListener('click', function() {
                            infowindow.open(map, marker);
                        });
                    }

                    // Deletes all markers in the array by removing references to them.
                    function deleteMarkers() {
                        setMapOnAll(null);
                        markers = [];
                    }

                    // Sets the map on all markers in the array.
                    function setMapOnAll(map) {
                        for (var i = 0; i < markers.length; i++) {
                            markers[i].setMap(map);
                        }
                    }
                    //				
                },
                error: function() { alert("AJAX-grade發生錯誤囉!") }
            })


        })
        // window.onload = initMap;  //測試用
        </script>
</body>
<style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"><link rel=stylesheet type="text/css" href="css/map.css">
</style>

</html>