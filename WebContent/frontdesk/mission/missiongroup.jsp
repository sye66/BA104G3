<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="com.missionimages.model.*"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="missionImagesSvc" scope="page" class="com.missionimages.model.MissionImagesService" />
<jsp:useBean id="getMissionSvc" scope="page" class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<c:set var="sessionMemVO" value="${memVO}"/>
<c:set var="missionAsTakecase" value="${getMissionSvc.successGetMission(sessionMemVO.mem_No)}" />
<c:if test="${sessionMemVO == null}" var="test">
	<c:redirect url="${request.getContextPath()}/lib/publicfile/include/file/index.jsp"></c:redirect>
</c:if>


<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mem mission home</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/lib/css/getmission/MissionGroupButton.css">
<script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>
<style type="text/css">
    .buttonlink{
        margin: 20px;
        font-family: "微軟正黑體"
    }
    .wellcomeback{
        font-size: 30px;
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
    <br>
    <br>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-6 col-sm-offset-3">
                <%-- 錯誤處理 --%>
                    <c:if test="${not empty errorMsgs}">
                        <div>${errorMsgs}</div>
                    </c:if>
                <%-- 歡迎詞 --%>
                    <p class="wellcomeback">${sessionMemVO.mem_Name} 你好，歡迎回來</p>
                <%-- 查看接案候選人 --%>
                        <a href="<%=request.getContextPath()%>/frontdesk/casecandidate/casecandidate.jsp" class="checkcandidatebutton buttonlink">查看任務接案候選人</a>
                <%-- 查看自己候選的接案 --%>
                        <a href="<%=request.getContextPath()%>/frontdesk/casecandidate/waitcase.jsp" class="imcandidatebutton buttonlink">查看已接案候選狀態</a>
                <%-- 接案人任務 - 當任務狀態為身分未確認(3)或確認(4)時顯示正在進行的接案 --%>
                    <c:if test="${missionAsTakecase.size() != 0  }">
                        <c:forEach var="missionVO" items="${missionAsTakecase}" varStatus="state" step="1" end="${stop}" >
                            <c:if test="${missionVO.mission_State == 3 ||missionVO.mission_State ==  4  }">
                            	<%-- 往"/frontdesk/mission/finalstep.jsp" --%>
                            	<a href="<%=request.getContextPath()%>/frontdesk/mission/finalstep.jsp" class="takecasemissionongoingbutton  buttonlink">查看正在進行的接案</a>
                            	<c:set var="stop" value="0"/>
                        	</c:if>
                        </c:forEach>

                    </c:if>
                <%-- 發案人任務 - 當任務狀態為身分未確認(3)或確認(4)時顯示發案進行中--%>
                    <c:set var="issuersCaseList" value="${getMissionSvc.findIssuerCase(memVO.mem_No)}" />
                    <c:if test="${issuersCaseList.size() != 0  }">
                        <%--<c:forEach var="missionVO" items="${issuersCaseList}" varStatus="state2" step="1" end="${stop}">--%>
                                <a href="<%=request.getContextPath()%>/frontdesk/mission/issuerfinalstep.jsp" class="issuermissionongoingbutton buttonlink">查看進行中發出案件</a>
                                <c:set var="stop" value="0"/>
                        <%--</c:forEach>--%>
                    </c:if>
                </div>
            
            <div class="col-xs-12 col-sm-9">
                <div class="showMissionBoard"></div>
            </div>
        </div>
    </div>
	<br>
	<br>
	<br>


    <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>
</body>
</html>