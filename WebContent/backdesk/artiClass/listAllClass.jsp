<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.artiForm.model.*"%>

<%  
// EmpService empSvc = new EmpService();
// List<EmpVO> list = empSvc.getAll();
// pageContext.setAttribute("list",list);
%>
<jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService" />


<html>
<head><title> 所有分類 - listAllArtiClass.jsp</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
  table#table-1 {
	background-color: orange;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
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
<table id="table-1">
	<tr><td>
		 <h3>所有分類 - ListAllArtiClass.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/frontdesk/artiForm/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th> 分類編號 </th>
		<th> 分類名稱 </th>
		<th> 修改 </th>
		<th> 刪除 <font color=red>(關聯測試與交易-小心)</font></th>
		<th> 查詢分類文章 </th>
	</tr>
	
	<c:forEach var="artiClassVO" items="${artiClassSvc.all}">
		<tr align='center' valign='middle'>
			<td>${artiClassVO.arti_Cls_No}</td>
			<td>${artiClassVO.arti_Cls_Name}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiClass/artiClass.do" style="margin-bottom: 0px;">
			    <input type="submit" value="修改"   disabled="disabled"> 
			    <input type="hidden" name="arti_Cls_No" value="${artiClassVO.arti_Cls_No}">
			    <input type="hidden" name="action" value="getOne_For_Update_Dept"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiClass/artiClass.do" style="margin-bottom: 0px;">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="arti_Cls_No" value="${artiClassVO.arti_Cls_No}">
			    <input type="hidden" name="action" value="delete_artiClass"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiClass/artiClass.do" style="margin-bottom: 0px;">
			    <input type="submit" value="送出查詢"> 
			    <input type="hidden" name="arti_Cls_No" value="${artiClassVO.arti_Cls_No}">
			    <input type="hidden" name="action" value="listArti_ByClass_No_B"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<%if (request.getAttribute("listArti_ByClassNo")!=null){%>
       <jsp:include page="listArti_ByClassNo_back.jsp" />
<%} %>

</body>
</html>