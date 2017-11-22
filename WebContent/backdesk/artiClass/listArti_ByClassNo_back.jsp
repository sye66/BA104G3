<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiForm.model.*"%>

<jsp:useBean id="listArti_ByClassNo" scope="request" type="java.util.Set<ArtiFormVO>" />
<jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService" />


<html>
<head><title> 分類文章 - listArti_ByClassNo.jsp</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/reply.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/artiForm/backdeskLeft_ArtiForm.jsp" flush="true" />
	
<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-2">
	<tr><td>
		 <h3> 分類文章 - listArti_ByClassNo.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>文章編號</th>
		<th>會員名稱</th>
		<th>文章標題</th>
		<th>文章人氣</th>
		<th>文章內容</th>
		<th>發文時間</th>
		<th>文章附圖</th>
		<th>文章類別</th>
		<th>文章狀態</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	
	<c:forEach var="artiFormVO" items="${listArti_ByClassNo}" >
		<tr ${(artiFormVO.arti_No==param.arti_No) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->
			<td>${artiFormVO.arti_No}</td>
			<td>${artiFormVO.mem_No}</td>
			<td>${artiFormVO.arti_Title}</td>
			<td>${artiFormVO.arti_Like}</td>
			<td>${artiFormVO.describe}</td>		
			<td><c:forEach var="artiClassVO" items="${artiClassSvc.all}">
                    <c:if test="${artiFormVO.arti_Cls_No==artiClassVO.arti_Cls_No}">
	                    ${artiClassVO.arti_Cls_No}【<font color=orange>${artiClassVO.arti_Cls_Name}</font>】
                    </c:if>
                </c:forEach>
			</td>
			<td>${artiFormVO.arti_Cls_No}</td>
			<td>${artiFormVO.arti_Status}</td> 
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" style="margin-bottom: 0px;">
			    <input type="submit" value="修改"> 
			    <input type="hidden" name="arti_No"      value="${artiFormVO.arti_No}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--><!-- 目前尚未用到  -->
			    <input type="hidden" name="action"	   value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do"" style="margin-bottom: 0px;">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="arti_No"      value="${artiFormVO.arti_No}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			    <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>