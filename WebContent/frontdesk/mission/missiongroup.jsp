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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link href="<%=request.getContextPath()%>/lib/publicfile/include/css/sweetalert2.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>


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
            <div class="col-xs-12 col-sm-3">
                <%-- 錯誤處理 --%>
                    <c:if test="${not empty errorMsgs}">
                        <div>${errorMsgs}</div>
                    </c:if>
                <%-- 歡迎詞 --%>
                    <p>${sessionMemVO.mem_Name} 你好</p>
                    <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission">
                        <button class="btn btn-info index" type="submit" name="action" value="missionindex">任務首頁</button>
                    </form>
                <%-- 查看接案候選人 --%>
                    <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission">
                        <button class="btn btn-info pushdiv" type="submit" name="action" value="mymission">查看任務接案候選人</button>
                    </form>
                <%-- 查看自己候選的接案 --%>
                    <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission">
                        <button class="btn btn-info pushdiv" type="submit" name="action" value="missionwait">接案候選狀態</button>
                    </form>
                <%-- 當任務狀態為身分未確認(3)或確認(4)時宣告alright = true --%>
                    <c:if test="${missionAsTakecase.size() != 0  }">
                        <c:forEach var="missionVO" items="${missionAsTakecase}" varStatus="state" step="1" end="${stop}" >
                            <c:if test="${missionVO.mission_State == 3 ||missionVO.mission_State ==  4  }">
                            	<%-- 往"/frontdesk/mission/finalstep.jsp" --%>
                            	<a href="<%=request.getContextPath()%>/frontdesk/mission/finalstep.jsp" class="btn btn-danger">正在進行的接案</a>
                            	<c:set var="stop" value="0"/>
                        	</c:if>
                        </c:forEach>

                    </c:if>
                <%-- 當任務狀態為身分未確認(3)或確認(4)時宣告ok = true --%>
                    <c:set var="issuersCaseList" value="${getMissionSvc.findIssuerCase(memVO.mem_No)}" />
                    <c:if test="${issuersCaseList.size() != 0  }">
                        <c:forEach var="missionVO" items="${issuersCaseList}" varStatus="state2" step="1" end="${stop}">
                            <c:if test="${missionVO.mission_State == 3 || missionVO.mission_State == 4 }">
                                <a href="<%=request.getContextPath()%>/frontdesk/mission/issuerfinalstep.jsp" class="btn btn-warning">發案進行中</a>
                                <c:set var="stop" value="0"/>
                            </c:if>
                        </c:forEach>
                    <%-- 當ok為true則顯示出動吧工具人 --%>

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
</body>
</html>