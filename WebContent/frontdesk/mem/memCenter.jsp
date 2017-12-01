<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">
    <title>工具人出租</title>
</head>
<body>


<!-- navbar====================================================================== -->


<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include>

<br><br><br><br><br><br><br>
<!-- navbar====================================================================== -->




<!-- 麵包屑 -->

<div class="row">
 <div class="col-xs-12 col-sm-8 col-sm-offset-2">
	<ol class="breadcrumb">
	<li>
		<a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/mem/memCenter.jsp">會員中心</a>
	</li>
	<!-- <li class="active">媽我上電視了</li> -->
	</ol>
</div>
</div>


<!-- 註冊表單====================================================================== -->


<%-- 錯誤處理 --%>

<c:if test="${not empty errorMsgs}">
	<font style="color:#da0">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:#00f">${message}</li>
		</c:forEach>
	</ul>
</c:if>





<!-- memPageLeft====================================================================== -->



<br><br>
<div class="container">
	<div class="row">
        <div class="col-xs-12 col-sm-3">
            <div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
                <!-- 區塊1 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel1">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#aaa" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="aaa">
			         <h2> 會員資料管理</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="aaa" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="panel1">
                        <div class="panel-body">
                        <c:if test="${memVO.mem_State == 0 }">
                        	<h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/mem/memAuthentication.jsp">會員驗證</a></h3>
                        </c:if>
                            <h3><a id="noUnderLine" href="<%= request.getContextPath() %>/frontdesk/mem/memUpdateFile.jsp">修改會員資料</a></h3>
                        </div>
                    </div>
                </div>
                <!-- 區塊5 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel5">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#eee" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="eee">
			           <h2> 好友</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="eee" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel5">
                        <div class="panel-body">
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/follow_tm/followTmList.jsp">關注工具人列表</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/relation/beAppliedRelationship.jsp">好友申請人</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/relation/friendlList.jsp">好友列表</a></h3>
                        </div>
                    </div>
                </div>
                 <!-- 區塊2 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel2">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#bbb" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="bbb">
			           <h2> 儲值</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="bbb" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel2">
                        <div class="panel-body">
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/stored_history/stored_historyRecharge_PointCard.jsp">點數卡儲值</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/stored_history/rechage_credit.jsp">信用卡儲值</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/stored_history/stored_historyReview.jsp">儲值歷史紀錄</a></h3>
                        </div>
                    </div>
                </div>
                <!-- 區塊3 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel4">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#ddd" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="ddd">
			           <h2> 疑難困惑解答區</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="ddd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel4">
                        <div class="panel-body">
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/mem/FAQ.jsp">ＦＡＱ</a></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>


<div class="col-xs-12 col-sm-9">
            <img src="<%= request.getContextPath() %>/res/images/mem/memCenter/memPhoto1.png">
        </div>
</div>
</div>

<!-- memPageLeft====================================================================== -->




<!-- footer====================================================================== -->
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>


<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>


<!-- footer====================================================================== -->


</body>
</html>