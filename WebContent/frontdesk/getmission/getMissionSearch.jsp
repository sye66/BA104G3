<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="missionImagesSvc" scope="page"
	class="com.missionimages.model.MissionImagesService" />
<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<%
	GetMissionService getMissionService = new GetMissionService();
	List<GetMissionVO> list = getMissionService.getAll();
%>
<jsp:useBean id="listmission_ByCompositeQuery" scope="request" type="java.util.List<GetMissionVO>" />

<html lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Title Page</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel=stylesheet type="text/css" href="css/map.css">
<link rel="stylesheet" href="css/map.css">
<script type="text/javascript" src="js/*"></script>
<script src="js/map.js"></script>
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->

<style type="text/css">
@media screen and (min-width: 768px) {
	.pic {
		
	}
}
</style>
</head>
<body>

	<%@ include file="/frontdesk/header.jsp"%>
<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-4">
			
		</div>
		<div class="col-xs-12 col-sm-8">
			
		</div>
	</div>
</div>

	<!-- map ====================================================================================-->

	<div class="container">
		<div class="row">

			<div class="input-group container">
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/getmission/getmission.do">
					<div class="input-group">
						
						<div class="input-group container">
						<div class="row">
						<div class="col-xs-12 col-sm-2">
						 <select id="mission_Category" name="mission_Category">
								<option value="-1">任務分類</option>
								<option value="教育">教育</option>
								<option value="修繕">修繕</option>
								<option value="其他">其他</option>
								<option value="交友">交友</option>
								<option value="官方">官方</option>
						</select>
						</div>
						
								<div class="col-xs-12 col-sm-10">
								<input type="text" class="form-control" id="search-mission"
									name="mission_Name" placeholder="Search for Mission...">
									
								<span class="input-group-btn">

									<button class="btn btn-success btn-secondary" type="summit"
										name="action" value="listmission_ByCompositeQuery">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</span>
								</div>
						</div>
					</div>
</div>
				</form>

				<div id="map"></div>
			</div>

		</div>
	</div>





	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBI0AqzghxJv55TD4xLnlng-4hZ57jt2JQ&libraries=places&callback=initMapCustom">
		$('.selectpicker').selectpicker({
			style : 'btn-info',
			size : 4
		});
	</script>


	<br>


<div class="container">
		<div class="row">

<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "missiongroup">
	
<button class="btn btn-success" type="submit" name="action" value="missiongroup">會員任務管理</button>

</form>
	<!-- button ====================================================================================-->


	<div class="container">
		<div class="row">
			<%@ include file="pages/page1_ByCompositeQuery.file"%>
		</div>
	</div>

	<c:set var="index" value="${1*1}" />
	<c:forEach var="getMissionVO" items="${listmission_ByCompositeQuery}"
		begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"
		varStatus="s" step="1">

		<c:set var="index" value="${index + 1}" />

		<c:if test="${s.index%2==0  }">
			<div class="container">
				<div class="row">
		</c:if>


		<div class="col-xs-12 col-sm-6">

			<div class="row">

				<div class="col-xs-12 col-sm-4">

					<div class="row">

						<c:if test="${missionImagesSvc.getMissionpho(getMissionVO.mission_No).size() !=0 }">
						<img
							src="<%=request.getContextPath()%>/missionimages/getpic.do?image_No=${missionImagesSvc.getMissionpho(getMissionVO.mission_No).get(0).image_No}"
							class="pic center">
							</c:if>
							<c:if test="${missionImagesSvc.getMissionpho(getMissionVO.mission_No).size() ==0}">
							<img src="<%=request.getContextPath()%>/res/images/getmission/panda.jpg"
							class="pic center">
							</c:if>
						<div class="user text-center">
							<p>USER PICTURE</p>
						</div>
					</div>

				</div>

				<div class="col-xs-12 col-sm-8">
					<div class="panel panel-default row">
						<div class="panel-heading">
							<h3 class="panel-title">${getMissionVO.mission_Name}</h3>
							<p>${getMissionVO.mission_No}</p>
							<p>發案人:${memSvc.getOneMem(getMissionVO.issuer_Mem_No).mem_Name}</p>

							<p>1.任務方向:${getMissionVO.mission_Category}</p>

							<p>2.報酬是:${getMissionVO.mission_Pay} 積分</p>
						</div>
						<table>
							<tr>
								<td>
									<div class="panel-body">
										<form method="post"
											action="<%=request.getContextPath()%>/getmission/getmission.do"
											name="getmission1">
											<button class="btn btn-warning" type="submit" name="action"
												value="mission_Detail">任務細節</button>

											<input type="hidden" name="mission_No"
												value="${getMissionVO.mission_No}"> <input
												type="hidden" name="requestURL"
												value="/frontdesk/getmission/getMission.jsp">
										</form>
									</div>
								</td>

								<td>
									<div class="panel-body">

										<form method="post"
											action="<%=request.getContextPath()%>/getmission/getmission.do"
											name="getmission2">
											<a href='#modal-id-mission${s.index} ' data-toggle="modal"><button
													class="btn btn-info">我要接案</button></a> <input type="hidden"
												name="mission_No" value="${getMissionVO.mission_No}">
										</form>
									</div>
								</td>

								<div class="modal fade" id="modal-id-mission${s.index}">
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
														value="${getMissionVO.mission_No}"> <input
														type="hidden" name="mission_State"
														value="${getMissionVO.mission_State}">
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

		<c:if test="${index%2==1 }">

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
			<%@ include file="pages/page2_ByCompositeQuery.file"%>
		</div>
	</div>





	<%@ include file="/frontdesk/footer.jsp"%>



	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>