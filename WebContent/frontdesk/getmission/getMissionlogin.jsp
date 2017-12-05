<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.casecandidate.model.*"%>
<jsp:useBean id="missionImagesSvc" scope="page"
	class="com.missionimages.model.MissionImagesService" />
<jsp:useBean id="getMissionSvc" scope="page" class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="caseCandidateSvc" scope="page"
	class="com.casecandidate.model.CaseCandidateService" />
<%
	GetMissionService getMissionService = new GetMissionService();
	MemVO memVO2 = (MemVO) request.getSession().getAttribute("memVO");
	List<GetMissionVO> list = getMissionService.getAllValidMission(memVO2.getMem_No());
	CaseCandidateVO missionmem = new CaseCandidateVO();
	System.out.print("list"+list.size());
	System.out.print("memVO2"+memVO2.getMem_No());
	
%>

<html lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>getmissionLogin</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">


<link rel="stylesheet" href="<%=request.getContextPath()%>/lib/css/getmission/map.css">
<%-- <script src="<%=request.getContextPath()%>/lib/js/getmission/map.js"></script> --%>
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->

<style type="text/css">

<c:forEach var="getMissionVO" items="${getMissionSvc.getAllValidMission(memVO.mem_No)}" varStatus="s" step="1">
<c:if test="${s.index%4==1 || s.index%4==2}">
 
  .bgcolor${s.index}{
	background-color:#d4f6dc;
 }
</c:if>

 

</c:forEach>

@media screen and (min-width: 768px) {
	.pic {
		
	}
}

.slickButton {
    color: white;
    font-weight: bold;
    padding: 10px;
    border: solid 1px black;
    background: lightgreen;
    cursor: pointer;
}
 
.slickButton:hover {
    color: black;
    background: yellow;
}
 
</style>
</head>
<body>

	<%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
	<br><br><br><br><br>
	<br><br><br>
	


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
						
								<input type="text" class="form-control input-lg" id="search-mission"
									name="mission_Name" placeholder="Search for Mission...">
									
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





	


	<br>
<c:if test="${not empty errorMsgs}">
<div>${errorMsgs}</div>
</c:if>
<div class="container">
		<div class="row">

<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "missiongroup">
	
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
	<c:forEach var="getMissionVO" items="${getMissionSvc.getAllValidMission(memVO.mem_No)}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="s" step="1">

		<c:set var="index" value="${index + 1}" />

		<c:if test="${s.index%2==0  }">
			<div class="container">
				<div class="row">
		</c:if>


		<div class="col-xs-12 col-sm-6">
<div class="container">
	
			<div class="row bgcolor${s.index}  " >

				<div class="col-xs-12 col-sm-4">

					<!-- <div class="row"> -->
						<c:if test="${missionImagesSvc.getMissionpho(getMissionVO.mission_No).size() !=0 }">
						<img
							src="<%=request.getContextPath()%>/missionimages/getpic.do?image_No=${missionImagesSvc.getMissionpho(getMissionVO.mission_No).get(0).image_No}"
							class="img-responsive pic center">
							</c:if>
							<c:if test="${missionImagesSvc.getMissionpho(getMissionVO.mission_No).size() ==0}">
							<img src="<%=request.getContextPath()%>/res/images/getmission/panda.jpg"
							class="img-responsive pic center">
							</c:if>
						<div class="user text-center">
						</div>
					<!-- </div> -->

				</div>

				<div class="col-xs-12 col-sm-8">
				
				
					<div class="panel panel-default row slickButton">
						<div class="panel-heading hoA">
							<h3 class="panel-title">${getMissionVO.mission_Name}</h3>
							<p>${getMissionVO.mission_No }</p>
							<p>發案人:${memSvc.getOneMem(getMissionVO.issuer_Mem_No).mem_Id}</p>

							<p>1.任務方向:${getMissionVO.mission_Category }</p>

							<p>2.報酬是:${getMissionVO.mission_Pay } 積分</p>
						</div>
					
						<table>
							<tr>
								<td>
									<div class="panel-body">
										<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission1">
											<button class="btn btn-warning" type="submit" name="action"
												value="mission_Detail">任務細節</button>

											<input type="hidden" name="mission_No"
												value="${getMissionVO.mission_No}"> <input
												type="hidden" name="requestURL"
												value="/frontdesk/getmission/getMission.jsp">
										</form>
									</div>
								</td>

							<% 
							missionmem.setCandidate_Mem_No(memVO.getMem_No());
							pageContext.setAttribute("missionmem" ,missionmem);
							
							%>

								<td>
									<div class="panel-body">
										<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission2">
											
								<c:if test="${memVO.mem_No != getMissionVO.issuer_Mem_No &&  !caseCandidateSvc.getCandidate(getMissionVO.mission_No).contains(missionmem) && getMissionVO.mission_State !=3 && getMissionVO.mission_State !=4 && getMissionVO.mission_State !=5 && getMissionVO.mission_State !=6 && getMissionVO.mission_State !=8 && getMissionVO.mission_State !=9}" var="accept">
								
								<a href='#modal-mission-id${s.index} ' data-toggle="modal">
								<button class="btn btn-info" >我要接案</button></a> 
								
								
								</c:if>
								
								<c:if test="${!accept}">
									<a  data-toggle="modal">
									<button class="btn btn-info" style="visibility: hidden" >我要接案</button></a> 
								</c:if>
											
											<input type="hidden" name="mission_No" value="${getMissionVO.mission_No}">
										</form>
									</div>
								</td>

								<div class="modal fade" id="modal-mission-id${s.index}">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true">&times;</button>
												<h4 class="modal-title">任務編號:${getMissionVO.mission_No}</h4>
											</div>
											<div class="modal-body">
												<h4>任務名稱:</h4>
												<p>----${getMissionVO.mission_Name}</p>
												<h4>任務種類:</h4>
												<p>----${getMissionVO.mission_Category}</p>
											</div>
											<div class="modal-footer">

												<form method="post"
													action="<%=request.getContextPath()%>/getmission/getmission.do"
													name="getmission2">
													<button class="btn btn-info" type="submit" name="action"
														value="take_mission">確認接案</button>
													<input type="hidden" name="mission_No"
														value="${getMissionVO.mission_No}"> 
													<input type="hidden" name="mission_State" value="${getMissionVO.mission_State}">
													<input type="hidden" name="requestURL" value="<%=request.getContextPath()%>/frontdesk/getmission/getMission.jsp">
												</form>
												<button type="button" class="btn btn-default"
													data-dismiss="modal">關閉</button>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		 <script>


       // The following example creates complex markers to indicate beaches near
      // Sydney, NSW, Australia. Note that the anchor is set to (0,32) to correspond
      // to the base of the flagpole.

      function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: {lat: 24.9722, lng: 121.2054}
        });

        setMarkers(map);
      }

      // Data for the markers consisting of a name, a LatLng and a zIndex for the
      // order in which these markers should display on top of each other.
//       var allmission = [];
//       for(GetMissionVO vo : list){
//     	  allmission.push(vo.mission_Name,mission_Category, vo.mission_Gps_Lat,mission_Gps_Lng)
//     	  console.log(allmission)
//       }
      
      
      var allmission = [ 
    	  <c:forEach var="getMissionVO" items="${getMissionSvc.getAllValidMission()}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="s" step="1">
  		['${getMissionVO.mission_Name}','${getMissionVO.mission_Category}' ,${getMissionVO.mission_Gps_Lat} , ${getMissionVO.mission_Gps_Lng}]
  		
  		<c:if test = "${!s.last}">
  		,
  		</c:if>
	</c:forEach>   
    	          
   
   ];
      
      
//       var beaches = [
//         ['Bondi Beach', -33.890542, 151.274856, 4],
//         ['Coogee Beach', -33.923036, 151.259052, 5],
//         ['Cronulla Beach', -34.028249, 151.157507, 3],
//         ['Manly Beach', -33.80010128657071, 151.28747820854187, 2],
//         ['Maroubra Beach', -33.950198, 151.259302, 1]
//       ];

      function setMarkers(map) {
        // Adds markers to the map.

        // Marker sizes are expressed as a Size of X,Y where the origin of the image
        // (0,0) is located in the top left of the image.

        // Origins, anchor positions and coordinates of the marker increase in the X
        // direction to the right and in the Y direction down.
        var image = {
          url: 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
          // This marker is 20 pixels wide by 32 pixels high.
          size: new google.maps.Size(20, 32),
          // The origin for this image is (0, 0).
          origin: new google.maps.Point(0, 0),
          // The anchor for this image is the base of the flagpole at (0, 32).
          anchor: new google.maps.Point(0, 32)
        };
        // Shapes define the clickable region of the icon. The type defines an HTML
        // <area> element 'poly' which traces out a polygon as a series of X,Y points.
        // The final coordinate closes the poly by connecting to the first coordinate.
        var shape = {
          coords: [1, 1, 1, 20, 18, 20, 18, 1],
          type: 'poly'
        };
        for (var i = 0; i < allmission.length; i++) {
          var mission = allmission[i];
          var marker = new google.maps.Marker({
            position: {lat: mission[2], lng: mission[3]},
            map: map,
            icon: image,
            shape: shape,
            title: mission[0]
          });
        }
        
//         for (var i = 0; i < beaches.length; i++) {
//             var beach = beaches[i];
//             var marker = new google.maps.Marker({
//               position: {lat: beach[1], lng: beach[2]},
//               map: map,
//               icon: image,
//               shape: shape,
//               title: beach[0]
//             });
//           }
      }
      
      
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBI0AqzghxJv55TD4xLnlng-4hZ57jt2JQ&libraries=places&callback=initMap">
			
	</script>
</body>
<style><link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel=stylesheet type="text/css" href="css/map.css"></style>
</html>