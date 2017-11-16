<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>

<%@ page import="com.mem.model.*"%>

<%
  MemVO memVO = (MemVO) request.getSession().getAttribute("register_memVO");		
  ProOrderVO proOrderVO = (ProOrderVO) request.getAttribute("ProOrderVO");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>訂單</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body>
	

<h3>新增訂單:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/proOrderServlet.do" name="form1">
<table>
	<tr>
<!-- 	注意會員變數還是小寫未更改版 -->
		<td>姓名:</td>
		<td><input type="TEXT" name="ord_Consignee" size="45" 
			 value="<%= (memVO==null)? "吳永志" : memVO.getMem_Name()%>" /></td>
	</tr>
	<tr>
		<td>地址:</td>
		<td><input type="TEXT" name="ord_Address" size="45"
			 value="<%= (proOrderVO==null)? "MANAGER" : proOrderVO.getOrd_Address()%>" /></td>
	</tr>
	<tr>
		<td>電話:</td>
		<td><input type="TEXT" name="ord_Phone" size="45"
			 value="<%= (proOrderVO==null)? "0953711015" : proOrderVO.getOrd_Phone()%>" /></td>
	</tr>
	<tr>
		<td>總價:${totalPrice} </td>
		
	</tr>
	
</table>
<br>
<input type="hidden" name="ord_Price" value="${totalPrice}">
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
	
	
	
</body>
</html>