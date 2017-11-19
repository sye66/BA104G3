<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.emp.model.*"%>
<%EmpVO empVO = (EmpVO) request.getAttribute("empVO");%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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

</head>
<body bgcolor='white'>
<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="backdeskEmpLeft.jsp" flush="true" />

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - ListOneEmp.jsp</h3>
		 
	</td></tr>
</table>

<table>
	<tr>
		<th>員工編號</th>
		<th>員工姓名</th>
		<th>信箱</th>
		<th>職稱</th>
		<th>電話</th>
		<th>狀態</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<tr align='center' valign='middle'>
		<td><%=empVO.getEmp_No()%></td>
		<td><%=empVO.getEmp_Name()%></td>
		<td><%=empVO.getEmp_Mail()%></td>
		<td><%=empVO.getEmp_Job()%></td>
		<td><%=empVO.getEmp_Phone()%></td>
		<td><%=empVO.getEmp_State()%></td>
		<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改"> 
			     <input type="hidden" name="emp_No"      value="${empVO.emp_No}">
			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="emp_No"      value="${empVO.emp_No}">
			     <input type="hidden" name="action"     value="delete"></FORM>
			</td>
	</tr>
	
</table>

</body>
</html>