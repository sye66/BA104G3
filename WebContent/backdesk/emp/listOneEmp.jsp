<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.emp.model.*"%>
<%EmpVO empVO = (EmpVO) request.getAttribute("empVO");%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<style>
  table#table-1 {
    box-shadow: 0 17px 50px 0 rgba(0, 0, 0, 0.01), 0 12px 15px 0 rgba(0, 0, 0, 0.1), 0 0px 50px 0   #8A5CB8, 0 12px 15px 0   #5C5CB8;
    border-radius: 20px;
    text-align: center;
    width: 80%;
    height: 60px;
    padding-top: 30px;
    color: #4cae4c;
    margin : 20px;
    margin-left : 20px;
  }
  
  h3{
    width: 80%;
    height: 25px;  
    margin : 20px;
  }
  
  body{margin:40px;}
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
	
	<div class="col-xs-12 col-sm-8 col-sm-offset-1">
		<br>
		<nav aria-label="breadcrumb" role="navigation">
  		<ol class="breadcrumb">
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/backdesk.jsp">首頁</a></li>
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/emp/select_page.jsp">員工管理</a></li>
    		<li class="breadcrumb-item active" aria-current="page">單一員工查詢</li>
  		</ol>
	</nav>
	</div>
	

<div align="center">
<table id="table-1">
	<tr><td>
		 <h3 >員工資料</h3>
		 
	</td></tr>
</table>
<br>
<br>

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
</div>

</body>
</html>