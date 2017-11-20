<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="missionImagesSvc" scope="page"
	class="com.missionimages.model.MissionImagesService" />
<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<%@ page import="com.getmission.model.*"%>
<%@ page import="com.missionimages.model.*"%>

<%
	GetMissionVO getMissionVO = (GetMissionVO) request.getAttribute("getMissionVO");
	String mem_No = (String) session.getAttribute("mem_No");
	String errorMsgs = (String) session.getAttribute("errorMsgs");
%>

<!DOCTYPE html>
<html lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Mission_Detail</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
<style type="text/css">
#carousel-id {
	height: 500px;
}
</style>
</head>
<body>

<div class="col-xs-12 col-sm-12">
<%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
</div>

	<table>
		<tr>
		<td>
			<div class="form-group">
				<label for="aa" class="col-xs-12 col-sm-3 control-label">${memSvc.getOneMem(mem_No).mem_No}--${memSvc.getOneMem(mem_No).mem_Name}
					你好 </label>
				<div class="col-xs-12 col-sm-9">
					<input type="text" name="aa" id="aa" placeholder="文字"
						class="form-control">
				</div>
			</div>
			</td>
			<td>
			<div class="panel-body">

					<form method="post"
						action="<%=request.getContextPath()%>/accusecase/accusecase.do"
						name="getmission3">
						<button class="btn-lg btn-danger" type="submit" name="action"
							value="accusecase">檢舉任務</button>
						<input type="hidden" name="mission_No"
							value="${getMissionVO.mission_No}">
						<input type="hidden" name="mem_No"
							value="${mem_No}">
					</form>
				</div>
			</td>
		</tr>
		<tr class="jas">
			<div class="col-xs-12 col-sm-1"></div>
			<div class="col-xs-12 col-sm-10">
				<div class="col-xs-12 col-sm-6">
					<div id="carousel-id" class="carousel slide amos"
						data-ride="carousel">
						<!-- 幻燈片小圓點區 -->
						<ol class="carousel-indicators">
							<c:forEach var="missionImagesVO"
								items="${missionImagesSvc.getMissionpho(getMissionVO.mission_No)}"
								varStatus="p">
								<c:if test="${p.index == 0 }">
									<li data-target="#carousel-id" data-slide-to="${p.index}"
										class="active"></li>
								</c:if>
								<c:if test="${p.index != 0 }">
									<li data-target="#carousel-id" data-slide-to="${p.index}"
										class=""></li>
								</c:if>
							</c:forEach>
						</ol>
						<!-- 幻燈片主圖區 -->
						<div class="carousel-inner">
							<c:forEach var="missionImagesVO"
								items="${missionImagesSvc.getMissionpho(getMissionVO.mission_No)}"
								varStatus="p">

								<c:if test="${p.index == 0 }">
									<div class="item active">
										<img
											src="<%=request.getContextPath()%>/missionimages/getpic.do?image_No=${missionImagesVO.image_No}"
											alt="">
										<div class="container">
											<div class="carousel-caption">
												<h1>CSS可樂好喝超爽快</h1>
												<p>你喝過了嗎？</p>
												<p>
													<a class="btn btn-lg btn-primary" href="#" role="button">Sign
														up today</a>
												</p>
											</div>
										</div>
									</div>
								</c:if>
								<c:if test="${p.index != 0 }">
									<div class="item">
										<img
											src="<%=request.getContextPath()%>/missionimages/getpic.do?image_No=${missionImagesVO.image_No}"
											alt="">
										<div class="container">
											<div class="carousel-caption">
												<h1>CSS可樂好喝超爽快</h1>
												<p>你喝過了嗎？</p>
												<p>
													<a class="btn btn-lg btn-primary" href="#" role="button">Sign
														up today</a>
												</p>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<!-- 上下頁控制區 -->
						<a class="left carousel-control" href="#carousel-id"
							data-slide="prev"><span
							class="glyphicon glyphicon-chevron-left"></span></a> <a
							class="right carousel-control" href="#carousel-id"
							data-slide="next"><span
							class="glyphicon glyphicon-chevron-right"></span></a>
					</div>
				</div>

				<div class="col-xs-12 col-sm-6 ">
					<h3 class="text-center">任務簡介</h3>
					<h4>任務編號:</h4>
					<p>----${getMissionVO.mission_No}</p>
					<h4>任務名稱:</h4>
					<p>----${getMissionVO.mission_Name}</p>
					<h4>任務種類:</h4>
					<p>----${getMissionVO.mission_Category}</p>
					<h4>任務狀態:</h4>
					<p>----${getMissionVO.mission_State}</p>
					<h4>發案人:</h4>
					<p>發案人:${memSvc.getOneMem(getMissionVO.issuer_Mem_No).mem_Name}</p>
				</div>
		</tr>
		</div>
		<tr>
			<div class="col-xs-12 col-sm-1"></div>
			<div class="col-xs-12 col-sm-10">
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">任務細節</h3>
					</div>
					<div class="panel-body">
						<p>----發案人${getMissionVO.issuer_Mem_No}~${memSvc.getOneMem(getMissionVO.issuer_Mem_No).mem_Name}</p>

						<p>----${getMissionVO.mission_Des}</p>
						<p>----${getMissionVO.mission_Release_Time}</p>
						<p>----${getMissionVO.mission_Due_Time}</p>
						<p>----${getMissionVO.mission_Pattern}</p>
						<p>----${getMissionVO.mission_Pay} 積分</p>
					</div>
				</div>


			</div>
		</tr>
		<tr>


			<td>
				<div class="panel-body">

					<form method="post"
						action="<%=request.getContextPath()%>/getmission/getmission.do"
						name="getmission2">
						<a href='#modal-id' data-toggle="modal"><button
								class="btn-lg btn-warning">我要接案</button></a> <input type="hidden"
							name="mission_No" value="${getMissionVO.mission_No}">
					</form>
				</div>
			</td>






			<div class="modal fade" id="modal-id">
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
							</form>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">關閉</button>
						</div>
					</div>
				</div>
			</div>









			<td>
				<div class="panel-body">

					<form method="post"
						action="<%=request.getContextPath()%>/getmission/getmission.do"
						name="getmission3">
						<button class="btn-lg btn-success" type="submit" name="action"
							value="chat">和他聊天</button>
						<input type="hidden" name="mission_No"
							value="${getMissionVO.mission_No}">
					</form>
				</div>
			</td>

			<td>
				<form method="post"
					action="<%=request.getContextPath()%>/getmission/getmission.do"
					name="getmission">

					<button class="btn btn-info" type="submit" name="action"
						value="missionindex">任務首頁</button>

				</form>

			</td>
		</tr>
	</table>
	
	<div class="col-xs-12 col-sm-12">
	<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>
	</div>
	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		
	</script>
</body>
</html>
</body>
</html>