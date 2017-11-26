<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>
<%@ page import="com.proordlist.model.*"%>
<%@ page import="com.mem.model.*"%><html>
<%@page import="java.util.*"%><html><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>檢視訂單</title>
</head>
<body>
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"/>  --%>
</div>
<!-- 商城TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	
</div>
<!--麵包屑 -->
		<div class="col-xs-12 col-sm-8 col-sm-offset-2">

			<br>
			<ol class="breadcrumb">
				<li><a href="<%=request.getContextPath()%>">首頁</a></li>
				<li><a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a></li>
				<li class="active">個人訂單
				</li>

			</ol>

		</div>
		<!--麵包屑 結束-->




















<div class="col-xs-12 col-sm-12">
		<jsp:include page="/lib/publicfile/include/file/footer2.jsp" flush="true"></jsp:include>
</div>
</body>
</html>