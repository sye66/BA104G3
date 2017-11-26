<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="missionImagesSvc" scope="page"
	class="com.missionimages.model.MissionImagesService" />
<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page"
	class="com.mem.model.MemService" />
<%@ page import="com.getmission.model.*"%>
<%@ page import="com.missionimages.model.*"%>

<%
	GetMissionVO getMissionVO = (GetMissionVO) request.getAttribute("mission_No");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mem mission home</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link href="<%=request.getContextPath()%>/lib/publicfile/include/css/sweetalert2.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>


</head>
<body>
<%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
	<br><br><br><br><br>
	<br>

<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-3">
<c:if test="${not empty errorMsgs}">
<div>${errorMsgs}</div>
</c:if>
${memSvc.getOneMem(memVO.mem_No).mem_Name} 你好
		
			<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
				
			<button class="btn btn-info index" type="submit" name="action" value="missionindex">任務首頁</button>

			</form>

			<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
				
			<button class="btn btn-info pushdiv" type="submit" name="action" value="mymission">我的案子</button>

			</form>


			<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
				
			<button class="btn btn-info pushdiv" type="submit" name="action" value="missionwait">目前接案等待</button>

			</form>

			<c:if test="${getMissionSvc.successGetMission(memVO.mem_No).size() != 0  }">
			<c:forEach var="missionstate" items="${getMissionSvc.successGetMission(memVO.mem_No)}" varStatus="state" step="1">
			<c:if test="${missionstate.mission_State == 3 ||missionstate.mission_State ==  4  }" >
			<c:set var="alright" value="true"></c:set>
			</c:if>
			</c:forEach>
			<c:if test="${alright}">
			<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
			<button class="btn btn-danger pushdiv" type="submit" name="action" value="successgetmission">出動吧~工具人</button>
			</form>
			</c:if>
			</c:if>
			<c:if test="${getMissionSvc.findIssuerCase(memVO.mem_No).size() != 0  }">
			<c:forEach var="missionstate2" items="${getMissionSvc.findIssuerCase(memVO.mem_No)}" varStatus="state2" step="1">
			<c:if test="${missionstate2.mission_State == 3 ||missionstate2.mission_State == 4 }" >
			<c:set var="ok" value="true"></c:set>
			</c:if>
			</c:forEach>
			<c:if test="${ok}">
			<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
			<button class="btn btn-warning pushdiv" type="submit" name="action" value="missiondone">任務結案</button>
			</form>
			</c:if>
			</c:if>


		</div>
		<div class="col-xs-12 col-sm-9">
			
<div class="showMissionBoard"></div>

		</div>
	</div>
</div>



<input type="hidden" id=" " >
<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>
</body>



<script>
$(document).ready(function(){
		 $('.pushdiv').click(function(){
var nameType = $('.pushdiv').attr('name');

			 $.ajax({
				 type: "Post",
				 url: "<%=request.getContextPath()%>/getmission/getmission.do",
				 data: {action:nameType},
				 dataType: "json",
				 success: function (data){
					clearSelect();
					$.each(data, function(i, item){
						$('.showMissionBoard').append("<option value='"+item.classId+"'>"+item.className+"</option>");
					});
// 					$(data).each(function(i, item){
// 						$('#class').append("<option value='"+item.classId+"'>"+item.className+"</option>");
// 					});
// 					jQuery.each(data, function(i, item){
// 						$('#class').append("<option value='"+item.classId+"'>"+item.className+"</option>");
// 					});
			     },
	             error: function(){alert("AJAX-grade發生錯誤囉!")}
	         })
		 })
		
	})
 
    
</script>
</html>