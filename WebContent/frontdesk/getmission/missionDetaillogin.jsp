<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="missionImagesSvc" scope="page"
	class="com.missionimages.model.MissionImagesService" />
<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="ChangeStateToName" scope="page" class="com.getmission.controller.ChangeStateToName" />
<%@ page import="com.getmission.model.*"%>
<%@ page import="com.missionimages.model.*"%>
<%@ page import="com.casecandidate.model.*"%>
<jsp:useBean id="caseCandidateSvc" scope="page"
	class="com.casecandidate.model.CaseCandidateService" />

<%
	GetMissionVO getMissionVO = (GetMissionVO) request.getAttribute("getMissionVO");
	String mem_No = (String) session.getAttribute("mem_No");
	String errorMsgs = (String) session.getAttribute("errorMsgs");
	CaseCandidateVO missionmem = new CaseCandidateVO();
%>

<!DOCTYPE html>
<html lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Mission_Detaillogin</title>
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

.missionImg {
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            z-index: -999;
        }
        .missionImg img {
            max-height: 520px;
            min-width: auto;
            width: 100%;
        }

        @media screen and (max-width: 1000px) {
            img.missionImg {
                left: 50%;
                margin-left: -500px;
            }
        }
        
      body
{
<%--     background:  url('<%=request.getContextPath()%>/res/images/getmission/bgimg7.jpg') fixed; --%>
   
    background-size: cover;
    padding: 0;
    margin: 0;
}  



.slickButton3 {
    color: white;
    font-weight: bold;
    padding: 10px;
    border: solid 1px black;
    background: lightgreen;
    cursor: pointer;   
    transition: box-shadow 0.5s;
    -webkit-transition: box-shadow 0.5s;
}
 
.slickButton3:hover {
    box-shadow:5px 5px 10px gray;
}

</style>
</head>
<body>

<div class="col-xs-12 col-sm-12">
<%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
</div>
<br><br><br><br><br><br><br>
<div class="col-xs-12 col-sm-10 col-sm-offset-1">
	<div class="row">
	<table>
		<tr>
		<td>
			<div class="form-group">
				
				<div class="col-xs-12 col-sm-9">
					<c:if test="${not empty errorMsgs}">
					<div>${errorMsgs}</div>
					</c:if>
				</div>
			</div>
		</td>
		
		</tr>
		<div class="modal fade" id="accuse">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">檢舉原因</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				
			</div>
			<form method="post" action="<%=request.getContextPath()%>/accusecase/accusecase.do"
										name="getmission3">
			<div class="modal-body">
				<textarea class="container accuse_Detail" name="accuse_Detail" ><c:out value="${uabout}" /> </textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
				
				<button type="submit" name="action" class="btn btn-danger" value="accusecase">確認送出檢舉</button>
				<input type="hidden" name="mission_No" value="${getMissionVO.mission_No}"> 
				<input type="hidden" name="mem_No" value="${memVO.mem_No}">
				</div>
			</form>
		</div>
	</div>
</div>
		<tr class="jas">
		
			
			<div class="col-xs-12 col-sm-10 col-sm-offset-1">
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
									<div class="item active missionImg">
										<img
											src="<%=request.getContextPath()%>/missionimages/getpic.do?image_No=${missionImagesVO.image_No}"
											alt="">
										
									</div>
								</c:if>
								<c:if test="${p.index != 0 }">
									<div class="item missionImg">
										<img
											src="<%=request.getContextPath()%>/missionimages/getpic.do?image_No=${missionImagesVO.image_No}"
											alt="">
									
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

				<div class="col-xs-12 col-sm-4 ">
					<h3 class="text-center">任務簡介</h3>
					<h4 style="color:red">任務編號:</h4>
					<p>----${getMissionVO.mission_No}</p>
					<h4 style="color:mediumslateblue">任務名稱:</h4>
					<p>----${getMissionVO.mission_Name}</p>
					<h4 style="color:mediumslateblue">任務種類:</h4>
					<p>----${getMissionVO.mission_Category}</p>
					<h4 style="color:mediumslateblue">任務狀態:</h4>
					<p style="color:#21a261">----${ChangeStateToName.ChangeStateToName(getMissionVO.mission_State)}</p>
					<h4 style="color:mediumslateblue">發案人:</h4>
					<p>${memSvc.getOneMem(getMissionVO.issuer_Mem_No).mem_Name}</p>
				</div>
				<div class="col-xs-12 col-sm-2 ">
				<div class="panel-body">
								<c:if
									test="${accusecaseSvc.getOneAccuseCaseBymissionAndmem(getMissionVO.mission_No,memVO.mem_No) ==null && getMissionSvc.getOneMission(getMissionVO.mission_No).issuer_Mem_No != memVO.mem_No}">
									<form method="post"
										action=""
										name="getmission3">
										<a href='#accuse' data-toggle="modal"><button class="btn-lg btn-danger " id="accuse" name="action"
											value="accusecase">檢舉任務</button></a>
										<input type="hidden" name="mission_No"
											value="${getMissionVO.mission_No}"> <input
											type="hidden" name="mem_No" value="${memVO.mem_No}">
									</form>
									

								</c:if>

								<c:if
									test="${accusecaseSvc.getOneAccuseCaseBymissionAndmem(getMissionVO.mission_No,memVO.mem_No) !=null && getMissionSvc.getOneMission(getMissionVO.mission_No).issuer_Mem_No != memVO.mem_No}">
									<form method="post"
										action="<%=request.getContextPath()%>/accusecase/accusecase.do"
										name="getmission3">
										<button class="btn-lg btn-info" type="submit" name="action"
											value="cancelaccusecase">取消檢舉任務</button>
										<input type="hidden" name="mission_No"
											value="${getMissionVO.mission_No}"> <input
											type="hidden" name="mem_No" value="${memVO.mem_No}">
									</form>
								</c:if>
							</div>
				</div>
		</tr>
		</div>
		</table>
		<table>
		<tr>
			<div class="col-xs-12 col-sm-9 col-sm-offset-1">
				<div class="panel panel-info slickButton3">
					<div class="panel-heading">
						<h3 class="panel-title">任務細節</h3>
					</div>
					<div class="panel-body">
						<h5 style="color:brown">發案人</h5><p>${getMissionVO.issuer_Mem_No}~${memSvc.getOneMem(getMissionVO.issuer_Mem_No).mem_Name}</p>

						<h5 style="color:brown">敘述</h5><p>${getMissionVO.mission_Des}</p>
						<h5 style="color:brown">任務發佈時間</h5><p>${getMissionVO.mission_Release_Time}</p>
						<h5 style="color:brown">任務截止日期</h5><p>${getMissionVO.mission_Due_Time}</p>
						<h5 style="color:brown">任務模式</h5><p style="color:red">${ChangeStateToName.ChangePatternToName(getMissionVO.mission_Pattern)}</p>
						<h5 style="color:brown">任務報酬</h5><p>${getMissionVO.mission_Pay} 積分</p>
					</div>
				</div>


			</div>
			
<% 
							missionmem.setCandidate_Mem_No(memVO.getMem_No());
							pageContext.setAttribute("missionmem" ,missionmem);
							
							%>
			<c:if test="${memVO.mem_No != getMissionVO.issuer_Mem_No &&  !caseCandidateSvc.getCandidate(getMissionVO.mission_No).contains(missionmem) && getMissionVO.mission_State !=3 && getMissionVO.mission_State !=4 && getMissionVO.mission_State !=5 && getMissionVO.mission_State !=6 && getMissionVO.mission_State !=8 && getMissionVO.mission_State !=9}" var="accept">
							<td>
								<div class="panel-body">

									<form method="post"
										action="<%=request.getContextPath()%>/getmission/getmission.do"
										name="getmission2">
										<a href='#modal-id-mission' data-toggle="modal"><button
												class="btn-lg btn-warning">我要接案</button></a> <input
											type="hidden" name="mission_No"
											value="${getMissionVO.mission_No}">
									</form>
								</div>
							</td>
						</c:if>
						<c:if test="${!accept}">
									<a  data-toggle="modal">
									<button class="btn btn-info" style="visibility: hidden" >我要接案</button></a> 
						</c:if>

			<div class="modal fade" id="modal-id-mission">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">任務編號:${getMissionVO.mission_No}</h4>
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
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
								<input type="hidden" name="requestURL" value="<%=request.getContextPath()%>/frontdesk/getmission/missionDetail.jsp">
							</form>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">關閉</button>
						</div>
					</div>
				</div>
			</div>
			

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
	</div>
</div>
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