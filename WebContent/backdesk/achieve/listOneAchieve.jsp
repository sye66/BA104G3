<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.achieve.model.*"%>
<%AchieveVO achieveVO = (AchieveVO) request.getAttribute("achieveVO");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

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

<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>成就資料 - ListOneAchieve.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/selectAchieve_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>成就編號</th>
		<th>成就名稱</th>
		<th>成就圖片</th>
		<th>成就說明</th>
	</tr>
	<tr align='center' valign='middle'>
		<td><%=achieveVO.getAch_No()%></td>
		<td><%=achieveVO.getAch_Name()%></td>
		<td><img id="img" src="<%=request.getContextPath()%>/achieve/achieveShowImage.do?ach_No=${achieveVO.ach_No}"></td>
		<td><%=achieveVO.getAch_Explain()%></td>
	</tr>
</table>

</body>
</html>