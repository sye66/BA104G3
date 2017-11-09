<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proclass.model.*"%>
<%@page import="java.util.*"%>
<html>

<head>
<script language="JavaScript" src="js/calendarcode.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品</title>



<style>

.breadcrumb li,.breadcrumb li a {
    color: #f90;
	font-size: 16px;   
}

</style>
 
<%
	ProClassVO proClassVO = (ProClassVO) request.getAttribute("proClassVO");
	ProClassService ProClassSvc2 = new ProClassService();
	List<ProClassVO> list = ProClassSvc2.getAll();
	pageContext.setAttribute("list",list);
%>
</head>


<body>
 <jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
 <jsp:include page="/backdesk/pro/proBackLeft.jsp" flush="true" />
	
	<div class="col-xs-12 col-sm-8 col-sm-offset-1">
		<br>
		<nav aria-label="breadcrumb" role="navigation">
  		<ol class="breadcrumb">
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/backdesk.jsp">首頁</a></li>
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/pro/proBackIndex.jsp">商城管理</a></li>
    		<li class="breadcrumb-item active" aria-current="page">新增商品分類</li>
  		</ol>
		</nav>
	</div>
	
	<div class="col-xs-12 col-sm-8 col-sm-offset-1" style="height:300px">
<!-- <div class="col-xs-12 col-sm-5 col-sm-offset-1" style="height:300px"> -->
 <br><br>
 <table style="width:600px">
	<tr>
		<th>商品分類編號</th>
		<th>商品分類名稱</th>
	</tr>
	
	<%@ include file="page1.file" %> 
	<c:forEach var="proClassVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${proClassVO.pro_Class_No}</td>
			<td>${proClassVO.pro_Class_Name}</td>
			
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/proClass.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="pro_Class_No"  value="${proVO.pro_Class_No}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/proClass.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="pro_Class_No"  value="${proVO.pro_Class_No}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
 </table>
 <%@ include file="page2.file" %>
</div>
<div class="col-xs-12 col-sm-5 col-sm-offset-1">
		<br>
		<h1>添加新的商品分類</h1>
		<br>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
		<font color='red'>請修正以下錯誤:
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li>${message}</li>
				</c:forEach>
			</ul>
		</font>
	</c:if>

	<form action="<%=request.getContextPath()%>/pro/proClass.do" method=post  name="form1">
		
  
		<div class="col-xs-12 col-sm-6">
			<div class="input-group input-group-lg ">
  					<span class="input-group-addon" id="sizing-addon1">商品分類名稱:</span>
  					<input name="pro_Class_Name" value="<%=(proClassVO == null) ? "運動類" : proClassVO.getPro_Class_Name()%>" type="text" class="form-control">
			
			</div>
			<br>
			
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出新增" id="buy" style="background-color: #e90" >
		</div>
	</form>
	
	
	
</div>

</body>
</html>