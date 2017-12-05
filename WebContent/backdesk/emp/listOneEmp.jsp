<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.emp.model.*"%>
<%EmpVO empVO = (EmpVO) request.getAttribute("empVO");%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">


<style>
  table {
	width: 98%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
	
  }
  table, th, td ,#bo{
    border: 1px solid #0044BB;
    text-align: center;
     font-size:20px;
  } 
</style>
</head>
<body bgcolor='white'>
<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="backdeskEmpLeft.jsp" flush="true" />
	
	<br>
<br>
<br>

	<div class="container" align="center">
	<div class="row">
		<div class="col-xs-12 col-sm-12">
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
			     <input class="btn btn-primary" type="submit" value="修改"> 
			     <input type="hidden" name="emp_No"      value="${empVO.emp_No}">
			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" style="margin-bottom: 0px;">
			     <input class="btn btn-primary" type="submit" value="刪除">
			     <input type="hidden" name="emp_No"      value="${empVO.emp_No}">
			     <input type="hidden" name="action"     value="delete"></FORM>
			</td>
	</tr>
	
</table>
		</div>
	</div>
</div>


</body>
</html>